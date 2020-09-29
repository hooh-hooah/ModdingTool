#if UNITY_EDITOR
using System.Linq;
using MyBox;
using UnityEditor;
using UnityEngine;

namespace DebugComponents
{
    [DisallowMultipleComponent]
    public class ClothingBindHelper : MonoBehaviour, IPreview
    {
        public GameObject[] meshesToTest;
        [HideInInspector] public GameObject boneRoot;
        private GameObject meshTarget;

        private void Start()
        {
            meshTarget = new GameObject("Clothing Meshes");
            meshTarget.transform.parent = transform;
        }

        [ButtonMethod]
        private void TestClothingMeshInPlayMode()
        {
            if (!Application.isPlaying)
            {
                EditorUtility.DisplayDialog("Error", "You must be in Play Mode to test the Clothing Meshes", "OK");
                return;
            }

            var renderers = meshesToTest.SelectMany(prefab => prefab.GetComponentsInChildren<SkinnedMeshRenderer>());
            foreach (var r in renderers)
            {
                var newObject = Instantiate(r.gameObject, meshTarget.transform.parent);
                newObject.transform.name = r.name;
                var renderer = newObject.GetComponent<SkinnedMeshRenderer>();

                r.updateWhenOffscreen = true;
                renderer.rootBone = boneRoot.transform;
                var boneNames = renderer.bones.ToDictionary(x => x.name);
                boneRoot.GetComponentsInChildren<Transform>().ToList().ForEach(x =>
                {
                    if (boneNames.ContainsKey(x.name))
                        boneNames[x.name] = x;
                });

                renderer.bones = boneNames.Values.ToArray();
                renderer.sharedMesh.RecalculateBounds();
            }
        }
    }
}
#endif