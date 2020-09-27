using System.Collections.Generic;
using System.IO;
using ModdingTool;
using MyBox;
using UnityEngine;

namespace DebugComponents
{
    public class TextureGeneratorPreview : MonoBehaviour
    {
        private static readonly string[] bundles =
        {
            "_AIResources\\mm_base.unity3d"
        };

        private Material _instancedMaterial;

        private Dictionary<string, Material> _materials;

        private readonly Dictionary<string, string> referenceTable = new Dictionary<string, string>
        {
            {"o_body_cf_0", "create_skin_body"},
            {"o_head_0", "create_skin_face"}
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
                {
                    smr.sharedMaterial = materialInstance;
                    if (materialInstance.name.Contains("body"))
                    {
                        var texture = Resources.Load<Texture2D>("paint_base_body");
                        if (texture != null) materialInstance.SetTexture("_MainTex", texture);
                    }
                    else if (materialInstance.name.Contains("face"))
                    {
                        var texture = Resources.Load<Texture2D>("paint_base_face");
                        if (texture != null) materialInstance.SetTexture("_MainTex", texture);
                    }
                }
                else
                {
                    smr.enabled = false;
                }
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
                    var material = bundle.LoadAsset<Material>(path);
                    if (material == null) continue;
                    if (_materials.ContainsKey(material.name)) continue;
                    _materials.Add(material.name, Instantiate(material));
                }
            }

            return true;
        }
    }
}