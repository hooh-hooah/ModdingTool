using System;
using System.IO;
using MyBox;
using UnityEngine;

namespace DebugComponents
{
    public class FacePreviewComponent : MonoBehaviour
    {
        private static readonly string shaderBundleName = "_AIResources\\face_base.unity3d";
        private Material _instanceMaterial;
        public Texture2D faceDiffuse;
        public Texture2D faceNipple;
        public Texture2D faceNormal;
        public Texture2D faceNormalDetail;
        public Texture2D faceOcclusion;

        [Separator("Body Parameters")] public SkinnedMeshRenderer[] faceRenderers;
        public Material loadedBundleMaterial;

        [ButtonMethod]
        private void ResetTextures()
        {
            if (_instanceMaterial)
            {
                _instanceMaterial.SetTexture("_MainTex", faceDiffuse);
                _instanceMaterial.SetTexture("_OcclusionMap", faceOcclusion);
                _instanceMaterial.SetTexture("_Texture2", faceNipple);
                _instanceMaterial.SetTexture("_BumpMap", faceNormal);
                _instanceMaterial.SetTexture("_BumpMap2", faceNormalDetail);
                foreach (var renderer in faceRenderers) renderer.material = _instanceMaterial;
            }
            else
            {
                Debug.LogError("Couldn't find face material assetbundle!");
            }
        }

        [ButtonMethod]
        private void AssignBodyMeshes()
        {
            faceRenderers = GetComponentsInChildren<SkinnedMeshRenderer>();
        }

        private void Start()
        {
            try
            {
                var bundle = AssetBundle.LoadFromFile(Path.Combine(Directory.GetCurrentDirectory(), shaderBundleName));
                foreach (var assetPath in bundle.GetAllAssetNames())
                    if (assetPath.Contains("p_cf_head_00"))
                    {
                        var prefab = bundle.LoadAsset<GameObject>(assetPath);
                        var renderers = prefab.GetComponentsInChildren<SkinnedMeshRenderer>(true);

                        foreach (var renderer in renderers)
                        {
                            if (!renderer.gameObject.name.Contains("o_head"))
                                continue;
                            if (renderer.sharedMaterial == null)
                                continue;
                            loadedBundleMaterial = renderer.sharedMaterial;
                        }

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