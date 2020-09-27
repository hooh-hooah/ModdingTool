using System;
using System.IO;
using ADV;
using ModdingTool;
using ModPackerModule.Utility;
using UnityEditor;

public static class ADVCommandParser
{
    private const string basepath = @"D:\suqa\abdata\adv\scenario";

    private const string output = @"D:\parsedscenarios";

    [MenuItem("Developers/Dump ADV", false)]
    public static void DumpADV()
    {
        RecursiveDump(basepath);
    }

    private static void RecursiveDump(string path)
    {
        foreach (var file in Directory.GetFiles(path))
        {
            ParseADV(file);
        }

        foreach (var directory in Directory.GetDirectories(path))
        {
            RecursiveDump(directory);
        }
    }

    private static void ParseADV(string path)
    {
        var dest = path.Replace(basepath, "");
        var bundle = AssetBundleManager.GetBundle(path);
        if (bundle == null) return;

        foreach (var scenarioData in bundle.LoadAllAssets<ScenarioData>())
        {
            var targetPath = Path.Combine(output + Path.GetDirectoryName(dest), Path.GetFileNameWithoutExtension(dest), scenarioData.name + ".txt").ToUnixPath();
            Directory.CreateDirectory(Path.GetDirectoryName(targetPath));
            using (var stream = new StreamWriter(targetPath))
            {
                foreach (var param in scenarioData.list)
                {
                    stream.WriteLine($"{Enum.GetName(typeof(Command), param._command)},{string.Join(",", param._args)}");
                }

                stream.Close();
            }
        }
    }
}