#if UNITY_EDITOR
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using fastJSON;
using MyBox;
using UnityEditor;
using UnityEngine;

namespace DebugComponents
{
    [DisallowMultipleComponent]
    public class ClothingBindHelper : MonoBehaviour, IPreview
    {
        public GameObject[] meshesToTest;
        public GameObject boneRoot;
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

        public TextAsset bodyPreset;

        [ButtonMethod]
        private void ChangeBodyType()
        {
            if (bodyPreset != null)
            {
                // bruh
                var dynamic = JSON.ToDynamic(bodyPreset.text);
                var presets = new Dictionary<string, TransformPreset>();

                foreach (var key in dynamic.data.GetDynamicMemberNames())
                {
                    var transformData = dynamic.data[key];
                    presets.Add(key, new TransformPreset
                    {
                        position = new Vector3(
                            Convert.ToSingle(transformData.position[0]),
                            Convert.ToSingle(transformData.position[1]),
                            Convert.ToSingle(transformData.position[2])
                        ),
                        rotation = new Vector3(
                            Convert.ToSingle(transformData.rotation[0]),
                            Convert.ToSingle(transformData.rotation[1]),
                            Convert.ToSingle(transformData.rotation[2])
                        ),
                        scale = new Vector3(
                            Convert.ToSingle(transformData.scale[0]),
                            Convert.ToSingle(transformData.scale[1]),
                            Convert.ToSingle(transformData.scale[2])
                        )
                    });
                }

                var preset = new AIHSBodyPreset
                {
                    name = Convert.ToString(dynamic.name),
                    data = presets,
                };

                Debug.Log(1);
                AIHSPresetLoader.LoadObject(boneRoot, preset);
            }
            else
            {
                AIHSPresetLoader.LoadObject(boneRoot, 0);
            }
        }
    }
}
#endif