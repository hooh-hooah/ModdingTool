using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using hooh_ModdingTool.asm_Packer.Utility;
using MyBox;
using UnityEditor;
using UnityEngine;

namespace ModPackerModule.Structure.Classes.ManifestData
{
    //TODO: make overridable material editor structures
    //such as... textures
    //custom default values
    //shit like that
    public class MaterialEditorData : IManifestData
    {
        private static readonly HashSet<string> blacklisted = new HashSet<string>
        {
            "__dirty"
        };

        private List<(string, string, string, string)> _materialData;
        private XElement _materialElement;

        public (bool, string) IsValid()
        {
            return (true, null);
        }

        public void ParseData(in SideloaderMod.SideloaderMod modObject, in XElement modDocument)
        {
            _materialElement = modDocument.Element("material-data");
            if (ReferenceEquals(null, _materialElement)) return;

            _materialData = new List<(string, string, string, string)>();
            foreach (var element in _materialElement.Elements())
            {
                var name = element.Attr<string>("name");
                var asset = element.Attr<string>("asset");
                var bundle = element.Attr("bundle", modObject.Assets.GetBundleFromName(asset));
                var path = modObject.Assets.GetPathFromName(asset);
                if (ValidateUtils.BulkValidCheck(asset, bundle, path))
                    _materialData.Add((name, asset, bundle, path));
            }
        }

        public void SaveData(ref XDocument document)
        {
            if (_materialData.IsNullOrEmpty()) return;
            var materialEditorData = new XElement("MaterialEditor"); // add other versions

            var parsedShader = new HashSet<Shader>();
            foreach (var valueTuple in _materialData)
            {
                var (_, _, _, path) = valueTuple;
                var gameAsset = AssetDatabase.LoadAssetAtPath<GameObject>(path);
                if (ReferenceEquals(null, gameAsset)) continue;

                var renderers = gameAsset.GetComponentsInChildren<Renderer>();
                foreach (var material in renderers.SelectMany(renderer => renderer.sharedMaterials))
                {
                    var shader = material.shader;
                    if (parsedShader.Contains(shader)) continue;
                    parsedShader.Add(shader);
                    GenerateShaderParameters(ref materialEditorData, shader, valueTuple);
                }
            }

            document.Root?.Add(materialEditorData);
        }

        private static void GenerateShaderParameters(ref XElement elementRoot, Shader shader, (string, string, string, string) data)
        {
            var (name, asset, bundle, _) = data;
            var element = new XElement("Shader");
            element.SetAttributeValue("Name", name ?? shader.name);
            element.SetAttributeValue("AssetBundle", bundle);
            element.SetAttributeValue("Asset", asset);

            for (var i = 0; i < ShaderUtil.GetPropertyCount(shader); i++)
            {
                var propertyName = ShaderUtil.GetPropertyName(shader, i);
                if (blacklisted.Contains(propertyName)) continue;
                var type = ShaderUtil.GetPropertyType(shader, i);
                // var defaultValue = ShaderUtil.GetRangeLimits(shader, i, 0);
                var minValue = ShaderUtil.GetRangeLimits(shader, i, 1);
                var maxValue = ShaderUtil.GetRangeLimits(shader, i, 2);
                var property = new XElement("Property", new XAttribute("Name", propertyName.Replace("_", "")));
                switch (type)
                {
                    case ShaderUtil.ShaderPropertyType.Color:
                        property.SetAttributeValue("Type", "Color");
                        break;
                    case ShaderUtil.ShaderPropertyType.Float:
                        property.SetAttributeValue("Type", "Float");
                        break;
                    case ShaderUtil.ShaderPropertyType.Range:
                        property.SetAttributeValue("Type", "Float");
                        property.SetAttributeValue("Range", $"{minValue},{maxValue}");
                        break;
                    case ShaderUtil.ShaderPropertyType.Vector:
                        property.SetAttributeValue("Type", "Color");
                        break;
                    case ShaderUtil.ShaderPropertyType.TexEnv:
                        property.SetAttributeValue("Type", "Texture");
                        break;
                    default:
                        throw new ArgumentOutOfRangeException();
                }

                element.Add(property);
            }

            elementRoot.Add(element);
        }
    }
}