using System.Collections.Generic;
using System.IO;
using ModdingTool;
using MyBox;
using UnityEditor;
using UnityEngine;

namespace DebugComponents
{
    public class CharacterShaderPreview : MonoBehaviour
    {
        private static readonly string[] bundles =
        {
            "_AIResources\\body_base.unity3d", "_AIResources\\face_base.unity3d"
        };

        [Header("Head Textures")] public Texture2D HeadTextureDiffuse;
        public Texture2D HeadTextureNormalDetail;
        public Texture2D HeadTextureOcclusion;
        public Texture2D HeadTextureOverlay;

        [Header("Body Textures")] public Texture2D BodyTextureDiffuse;
        public Texture2D BodyTextureNipple;
        public Texture2D BodyTextureNormalDetail;
        public Texture2D BodyTextureOcclusion;

        [Header("Face Details")] public Texture2D DetailTextureEyelashes;
        public Texture2D DetailTextureFaceOverlay;
        public Texture2D DetailTextureEyes;
        public Texture2D DetailTextureEyesIris;
        public Texture2D DetailTextureEyesHighlight;

        private Material _instancedMaterial;

        private Dictionary<string, Material> _materials;

        private readonly Dictionary<string, string> referenceTable = new Dictionary<string, string>
        {
            {"o_body_cf_0", "cf_m_skin_body_00"},
            {"o_eyelashes_0", "c_m_eyelashes"},
            {"o_eyeshadow_0", "c_m_eyekage"},
            {"o_head_0", "cf_m_skin_head_00"},
            {"o_namida_0", "c_m_eye_namida"},
            {"o_eyebase_L_0", "c_m_eye_01"},
            {"o_eyebase_R_0", "c_m_eye_01"}
        };

        private void Awake()
        {
            if (!LoadMaterial())
            {
                enabled = false;
                Debug.LogError("the Modding Tool failed to load body and face shader. Please check if the installation has been done correctly.");
                return;
            }

            foreach (var smr in GetComponentsInChildren<SkinnedMeshRenderer>())
                if (referenceTable.TryGetValue(smr.name, out var matname) && _materials.TryGetValue(matname, out var materialInstance))
                    smr.sharedMaterial = materialInstance;

            OnValidate();
        }

        private void OnValidate()
        {
            if (!EditorApplication.isPlaying) return;
            // change the texture
            ChangeTexture("cf_m_skin_head_00", "_MainTex", HeadTextureDiffuse);
            ChangeTexture("cf_m_skin_head_00", "BumpMap2", HeadTextureNormalDetail);
            ChangeTexture("cf_m_skin_head_00", "_OcclusionMap", HeadTextureOcclusion);
            ChangeTexture("cf_m_skin_body_00", "_MainTex", BodyTextureDiffuse);
            ChangeTexture("cf_m_skin_body_00", "_Texture2", BodyTextureNipple);
            ChangeTexture("cf_m_skin_body_00", "_BumpMap2", BodyTextureNormalDetail);
            ChangeTexture("cf_m_skin_body_00", "_OcclusionMap", BodyTextureOcclusion);
            ChangeTexture("c_m_eyelashes", "_MainTex", DetailTextureEyelashes);
            ChangeTexture("cf_m_skin_head_00", "_HairBase", DetailTextureFaceOverlay);
            ChangeTexture("c_m_eye_01", "_MainTex", DetailTextureEyes);
            ChangeTexture("c_m_eye_01", "_Texture2", DetailTextureEyesIris);
            ChangeTexture("c_m_eye_01", "_Texture3", DetailTextureEyesHighlight);
        }

        [ButtonMethod]
        private bool LoadMaterial()
        {
            if (_materials.IsNullOrEmpty()) _materials = new Dictionary<string, Material>();
            else _materials.Clear();

            AssetBundle.UnloadAllAssetBundles(false);
            foreach (var bundlePath in bundles)
            {
                var bundle = AssetBundleManager.GetBundle(Path.Combine(Directory.GetCurrentDirectory(), bundlePath));
                foreach (var path in bundle.GetAllAssetNames())
                {
                    var prefab = bundle.LoadAsset<GameObject>(path);
                    if (ReferenceEquals(null, prefab) || prefab == null) continue;
                    var renderers = prefab.GetComponentsInChildren<SkinnedMeshRenderer>(true);
                    if (renderers.IsNullOrEmpty()) continue;
                    foreach (var smr in renderers)
                    foreach (var material in smr.sharedMaterials)
                    {
                        if (material == null) continue;
                        if (_materials.ContainsKey(material.name)) continue;
                        _materials.Add(material.name, Instantiate(material));
                    }
                }
            }

            return true;
        }

        private void ChangeTexture(string key, string shaderProperty, Texture newTexture)
        {
            if (newTexture == null || _materials.IsNullOrEmpty()) return;
            if (_materials.TryGetValue(key, out var material))
            {
                if (material != null)
                {
                    if (material.HasProperty(shaderProperty))
                        material.SetTexture(shaderProperty, newTexture);
                    else
                        Debug.LogError($"Material does not have property {shaderProperty}.");
                }
                else
                {
                    Debug.LogError("Material is not valid");
                }
            }
            else
            {
                Debug.LogError("Invalid material name");
            }
        }
    }
}