using System;
using System.IO;
using MyBox;
using UnityEngine;

namespace DebugComponents
{
    public class BodyPreviewComponent : MonoBehaviour, PreviewInterface
    {
        private static readonly string shaderBundleName = "_AIResources\\body_base.unity3d";
        private Material _instanceMaterial;
        public Texture2D bodyDiffuse;
        public Texture2D bodyNipple;
        public Texture2D bodyNormal;
        public Texture2D bodyNormalDetail;
        public Texture2D bodyOcclusion;

        [Separator("Body Parameters")] public SkinnedMeshRenderer[] bodyRenderers;

        public Material loadedBundleMaterial;

        [Separator("Body Style Initializer")] public TextAsset presetStyle;

        [ButtonMethod]
        private void ApplyBodyPreset()
        {
        }

        [ButtonMethod]
        private void ResetTextures()
        {
            if (_instanceMaterial)
            {
                _instanceMaterial.SetTexture("_MainTex", bodyDiffuse);
                _instanceMaterial.SetTexture("_OcclusionMap", bodyOcclusion);
                _instanceMaterial.SetTexture("_Texture2", bodyNipple);
                _instanceMaterial.SetTexture("_BumpMap", bodyNormal);
                _instanceMaterial.SetTexture("_BumpMap2", bodyNormalDetail);
                foreach (var renderer in bodyRenderers) renderer.material = _instanceMaterial;
            }
            else
            {
                Debug.LogError("Couldn't find body material assetbundle!");
            }
        }

        [ButtonMethod]
        private void AssignBodyMeshes()
        {
            bodyRenderers = GetComponentsInChildren<SkinnedMeshRenderer>();
        }

        private void Start()
        {
            try
            {
                var bundle =
                    AssetBundle.LoadFromFile(Path.Combine(Directory.GetCurrentDirectory(), shaderBundleName));
                foreach (var assetPath in bundle.GetAllAssetNames())
                    if (assetPath.Contains("p_cf_body_00"))
                    {
                        var prefab = bundle.LoadAsset<GameObject>(assetPath);
                        var renderer = prefab.GetComponentInChildren<SkinnedMeshRenderer>(true);
                        if (renderer.sharedMaterial == null)
                            continue;
                        loadedBundleMaterial = renderer.sharedMaterial;
                        break;
                    }

                _instanceMaterial = new Material(loadedBundleMaterial);
                ResetTextures();
            }
            catch (Exception e)
            {
                Debug.LogWarning(e.Message);
            }
        }
    }
}