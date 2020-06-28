#if UNITY_EDITOR
using System.Collections.Generic;
using System.IO;
using System.Linq;
using MyBox;
using UnityEditor;
using UnityEngine;

namespace DebugComponents
{
    public class GameAssetLoader : MonoBehaviour
    {
        private static AssetBundle hs2Bundle;
        private static AssetBundle aiBundle;
        private static GameObject clothingContainer;

        private static readonly string basePath = "_AIResources\\.unity3d";

        private static readonly Dictionary<string, bool> badNames = new Dictionary<string, bool>
        {
            {"cf_t_root", true},
            {"cf_N_k", true}
        };

        [ButtonMethod]
        public void InitializeAsset()
        {
            LoadBody(Game.HS2);
        }

        [ButtonMethod]
        public void InitializeAssetLikeFucker()
        {
            LoadBody(Game.HS2, true);
        }

        [ButtonMethod]
        public void InitializeClothingBase()
        {
            LoadBody(Game.HS2, true, true);
        }

        private void LoadBody(Game game, bool brutalLoad = false, bool isClothingBase = false)
        {
            // remove all bullshits remaining.
            for (var i = 0; i < transform.childCount; i++) DestroyImmediate(transform.GetChild(i).gameObject);

            var bundlePath = $"_AIResources\\{"hs2_body"}.unity3d";

            // well shit this is mostly only part that loads shits 
            AssetBundle.UnloadAllAssetBundles(brutalLoad);
            hs2Bundle = AssetBundle.LoadFromFile(Path.Combine(Directory.GetCurrentDirectory(), bundlePath));

            // Get All asset names.
            var assets = hs2Bundle.GetAllAssetNames();
            assets.ToList().ForEach(x => Debug.Log(x));

            // Load base animation bones
            var animationAsset = hs2Bundle.LoadAsset<GameObject>("p_cf_anim");
            var animationGameObject = Instantiate(animationAsset);

            if (isClothingBase)
            {
                animationGameObject.transform.parent = transform;

                // Get all shits - fuck it has some duplicated names fuck my life
                animationGameObject.GetComponentsInChildren<Transform>()
                    .Where(x => badNames.ContainsKey(x.name)).Select(x => x.gameObject)
                    .ToList().ForEach(DestroyImmediate);

                //  un-fuckup shits
                var transforms = animationGameObject.GetComponentsInChildren<Transform>()
                    .Select(x => x.gameObject).ToList();
                transforms.ForEach(CleanShitUp);
            }
            else
            {
                InitBodyPreview(animationGameObject);
            }

            Debug.Log(assets);
        }

        private void InitBodyPreview(GameObject animationGameObject)
        {
            var meshContainer = new GameObject("Mesh Container");
            meshContainer.transform.parent = animationGameObject.transform;

            var clothingInstanceContainer = new GameObject("Clothing Container");
            clothingInstanceContainer.transform.parent = animationGameObject.transform;
            clothingContainer = clothingInstanceContainer.gameObject;

            var bodyAsset = hs2Bundle.LoadAsset<GameObject>("p_cf_body_00");
            var bodyObject = Instantiate(bodyAsset);
            bodyObject.transform.parent = transform;

            var rootBone = animationGameObject.transform.Find("cf_J_Root");
            bodyObject.GetComponentsInChildren<SkinnedMeshRenderer>().ToList().ForEach(x =>
            {
                x.updateWhenOffscreen = true; // we don't fucking care about performance in editor.
                x.gameObject.transform.parent = meshContainer.transform;
                x.rootBone = rootBone;
                var boneTransforms = x.bones.ToDictionary(t => t.name);
                rootBone.GetComponentsInChildren<Transform>().ToList().ForEach(t =>
                {
                    if (boneTransforms.ContainsKey(t.name))
                        boneTransforms[t.name] = t;
                });
                x.bones = boneTransforms.Values.ToArray();
            });

            DestroyImmediate(bodyObject);
        }

        private void CleanShitUp(GameObject tObject)
        {
            tObject.GetComponents<Component>()
                .Where(x => !(x is Animator) && !(x is Transform))
                .ToList().ForEach(x => { DestroyImmediate(x); });

            var serializedChild = new SerializedObject(tObject.gameObject);
            var serializedComponentList = serializedChild.FindProperty("m_Component");
            var components = tObject.GetComponents<Component>();
            for (var i = components.Length - 1; i > -1; i--)
            {
                if (components[i] != null)
                    continue;

                serializedComponentList.DeleteArrayElementAtIndex(i);
            }

            serializedChild.ApplyModifiedPropertiesWithoutUndo();
        }

        private enum Game
        {
            AI = 0,
            HS2 = 1
        }
    }
}
#endif