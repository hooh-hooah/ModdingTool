#if UNITY_EDITOR
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Media;
using ModPackerModule.Structure.SideloaderMod;
using ModPackerModule.Utility;
using MyBox;
using UnityEditor;
using UnityEngine;

namespace ModPackerModule
{
    public static class ModPacker
    {
        public static void Announce(bool isSuccess = true, string message = "Please check the console the see error.")
        {
            if (!isSuccess) return;
            EditorApplication.Beep();
            if (EditorUtility.DisplayDialog("Alert", "Build Successful!", "Open Folder", "Okay"))
                PathUtils.OpenPath(HoohTools.GameExportPath);
            else EditorUtility.DisplayDialog("FAILED!", message, "Dismiss");
        }

        public static TextAsset[] GetProjectDirectoryTextAssets()
        {
            return PathUtils.LoadAssetsFromDirectory<TextAsset>(PathUtils.GetProjectPath(), ".xml$");
        }


        public static void PackMod(TextAsset[] assets, string exportGamePath, bool isDryRun = false)
        {
            if (!Directory.Exists(exportGamePath))
            {
                EditorUtility.DisplayDialog("Error: Mod Packing",
                    "Target destination does not exists! Check if you provided valid target directory.", "Okay, I'll be more smart.");
                return;
            }

            var isFolderTarget = assets.IsNullOrEmpty();
            assets = isFolderTarget ? GetProjectDirectoryTextAssets() : assets;
            if (isFolderTarget)
                Debug.LogWarning("Target is empty! Attempting to get all xml files from current project folder.");

            if (assets.IsNullOrEmpty())
            {
                EditorUtility.DisplayDialog("Error: Mod Packing",
                    "There is no xml files to parse. Please add at least one file in mod builder.\nYou can manually drag and drop to targets or open a folder with .xml folders.",
                    "OK");
                return;
            }

            List<SideloaderMod> packingMods;
            try
            {
                packingMods = assets.Select(file => new SideloaderMod(file)).ToList();
            }
            catch (Exception e)
            {
                Debug.LogError(e);
                SystemSounds.Exclamation.Play();
                EditorUtility.DisplayDialog("Error!", "Failed to parse bundle information.\nCheck console for more detailed information.", "YES");
                throw new Exception("Failed to validate mods");
            }

            var total = packingMods.Count;
            var done = 0;

            void Progress()
            {
                var progress = done / (float) total;
                EditorUtility.DisplayProgressBar("Packing Mods", "hooh's Modding Tool is validating and packing mods.", progress);
            }

            void BuildFailed()
            {
                if (BuildPipeline.isBuildingPlayer || EditorApplication.isCompiling || EditorApplication.isPlayingOrWillChangePlaymode) return;

                SystemSounds.Exclamation.Play();
                EditorUtility.DisplayDialog("Error!", "An error occured while the tool is building the mod.\nCheck console for more detailed information.", "Dismiss");
            }

            Progress();
            packingMods.ForEach(mod =>
            {
                try
                {
                    if (!mod.IsValid()) Debug.LogError("The XML file is not valid!");
                    else if (!mod.Build(exportGamePath, isDryRun)) BuildFailed();
                }
                catch (Exception e)
                {
                    Debug.LogError(e);
                    BuildFailed();
                }
                finally
                {
                    EditorUtility.ClearProgressBar();
                }

                done++;
                Progress();
            });
            EditorUtility.ClearProgressBar();
            EditorApplication.Beep();
        }
    }
#endif
}