#if UNITY_EDITOR
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Common;
using ModPackerModule;
using MyBox;
using UnityEditor;
using UnityEngine;

public partial class HoohTools
{
    [SerializeField]
    public List<TextAsset> packingObjects;

    public void DrawModBuilder(SerializedObject serializedObject)
    {
        var packingObjectsField = serializedObject.FindProperty("packingObjects");

        foldoutMod = EditorGUILayout.Foldout(foldoutMod, "Build Mod", true, Style.Foldout);
        if (!foldoutMod) return;

        using (new GUILayout.VerticalScope("box"))
        {
            // Display useful Debug Message
            if (packingObjects == null || packingObjects.Count <= 0)
                EditorGUILayout.HelpBox(
                    "You didn't specified the mod xml scripts. It will automatically try to get *.xml files from the folder you're looking at in Project Window.", MessageType.Info,
                    true);
            if (!Directory.Exists(GameExportPath)) EditorGUILayout.HelpBox("You need to provide Output Directory to build mods.", MessageType.Error, true);

            using (new GUILayout.HorizontalScope())
            {
                EditorPrefs.SetString("hoohTool_exportPath", EditorGUILayout.TextField("Output Directory: ", GameExportPath));
                GameExportPath = EditorPrefs.GetString("hoohTool_exportPath");
            }

            using (new GUILayout.HorizontalScope(EditorStyles.toolbar))
            {
                GUILayout.Label("Build Targets");
                GUI.backgroundColor = Color.white;
                if (GUILayout.Button("Add Folder", EditorStyles.toolbarButton))
                    SetEvent(() =>
                    {
                        var folderAssets = ModPacker.GetProjectDirectoryTextAssets();
                        if (folderAssets.Length > 0)
                            // packingObjects = packingObjects != null ? packingObjects.Concat(folderAssets).Distinct().ToList() : folderAssets;
                            folderAssets.ForEach(x => packingObjects.Add(x));
                        else
                            EditorUtility.DisplayDialog("Oh noes", "There is no xml files in project window.", "Okay i'll go to folder where has some xml files.");
                    });

                if (GUILayout.Button("Test", EditorStyles.toolbarButton))
                    SetEvent(
                        () => { ModPacker.PackMod(packingObjects, GameExportPath, true); }
                    );

                GUI.backgroundColor = HoohWindowStyles.red;
                GUI.color = Color.white;
                if (GUILayout.Button("Clear", EditorStyles.toolbarButton))
                    SetEvent(() =>
                    {
                        var check = EditorUtility.DisplayDialog("Are you sure?", "Just checking, did you really tried to remove all target xml files?", "Yes", "No");
                        if (check) packingObjects = null;
                    });

                GUI.backgroundColor = HoohWindowStyles.green;
                GUI.color = Color.white;
                if (GUILayout.Button("Build", EditorStyles.toolbarButton)) SetEvent(() => { ModPacker.PackMod(packingObjects, GameExportPath); });
                GUI.backgroundColor = Color.white;
                GUI.color = Color.white;
            }

            EditorGUILayout.PropertyField(packingObjectsField, new GUIContent("Target Mod XML Files"), true);
        }

        // GUILayout.Label("Build Mod Targets", Style.Header);
        // GUILayout.Space(10);
        // GUILayout.BeginHorizontal();
    }
}
#endif
