#if UNITY_EDITOR

using System;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using ADV;
using ModPackerModule.Utility;
using MyBox;
using UnityEditor;
using UnityEngine;
using Random = System.Random;

namespace ModdingTool
{
    public static class ScenarioDataCompiler
    {
        [MenuItem("Assets/CompileThisScenarioData")]
        public static void CompileScenarioDataCollection()
        {
            foreach (var textAsset in Selection.objects.OfType<TextAsset>())
            {
                CompileScenarioData(textAsset);
            }
        }


        public static void CompileScenarioData(TextAsset textAsset)
        {
            if (textAsset == null) return;
            var lines = Regex.Split(textAsset.text, "\n|\r|\r\n");
            var asset = ScriptableObject.CreateInstance<ScenarioData>();
            var savePath = Path.Combine(PathUtils.GetProjectPath(), Path.GetFileNameWithoutExtension(textAsset.name) + ".asset").ToUnixPath();
            var random = new Random();
            var hashIndex = random.Next(Int32.MaxValue/2);
            foreach (var line in lines)
            {
                if (line.IsNullOrEmpty()) continue;
                var dataSplit = line.Split('\t');
                if (dataSplit.IsNullOrEmpty()) continue;
                var cringe = (Command) Enum.Parse(typeof(Command), dataSplit[0]);
                asset.list.Add(new ScenarioData.Param
                {
                    _hash = hashIndex++,
                    _version = Convert.ToInt32(dataSplit[2]),
                    _multi = Convert.ToBoolean(dataSplit[1]), 
                    _command = cringe,
                    _args = dataSplit.Skip(3).ToArray()
                });
            }

            AssetDatabase.CreateAsset(asset, savePath);
            AssetDatabase.SaveAssets();
            EditorUtility.FocusProjectWindow();
            Selection.activeObject = asset;
        }
    }
}
#endif