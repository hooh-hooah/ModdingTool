using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using UnityEditor;
using UnityEngine;

namespace hooh_ModdingTool.asm_Packer.Editor.PackageLocator
{
    public class PackageLocator : EditorWindow
    {
        public struct ModPackage
        {
            public TextAsset modXML;
            public string name;
        }

        [MenuItem("hooh Tools/Package Locator")]
        private static void ShowWindow()
        {
            var window = GetWindow<PackageLocator>();
            window.titleContent = new GUIContent("Buildable Packages");
            window.Show();
        }

        public List<ModPackage> packages;
        public Regex namePattern = new Regex("<name>(.+)</name>");

        private void OnGUI()
        {
            GUILayout.Label("AIHS2 Mod Packages");

            if (GUILayout.Button("Find all mod.xml projects"))
            {
                packages = new List<ModPackage>();
                var basePath = Path.GetDirectoryName(Application.dataPath);
                foreach (var guid in AssetDatabase.FindAssets("t:TextAsset").ToArray())
                {
                    var path = AssetDatabase.GUIDToAssetPath(guid);
                    if (!path.EndsWith(".xml")) continue;
                    using (var fs = File.OpenText(Path.Combine(basePath ?? string.Empty, path)))
                    {
                        var fl = fs.ReadLine();
                        if (fl != null && fl.StartsWith("<packer"))
                        {
                            // read rest onf them
                            packages.Add(new ModPackage
                            {
                                modXML = AssetDatabase.LoadAssetAtPath<TextAsset>(fl),
                                name = namePattern.Match(fs.ReadToEnd()).Value
                            });
                        }

                        fs.Close();
                    }
                }

                // packages = AssetDatabase.GetAllAssetPaths("t:TextAsset").Select(guid =>
                // {
                //     var path = AssetDatabase.GetAssetPath(guid);
                //     var asset  = AssetDatabase.asset
                // }).ToArray()
            }

            using (new GUILayout.VerticalScope())
            {
                if (packages != null)
                {
                    foreach (var p in packages)
                    {
                        GUILayout.Button(p.name);
                    }
                }
            }
        }
    }
}
