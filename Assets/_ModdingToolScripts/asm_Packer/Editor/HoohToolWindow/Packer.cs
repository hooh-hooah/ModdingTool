#if UNITY_EDITOR
using System;
using System.IO;
using System.Linq;
using Common;
using ModPackerModule;
using UnityEditor;
using UnityEngine;

public partial class HoohTools
{
    public TextAsset[] packingObjects;

    public enum PackerAction
    {
        None, Build, Remove, AddFolder
    }

    public void DrawModBuilder(SerializedObject serializedObject)
    {
        var packingObjectsField = serializedObject.FindProperty("packingObjects");
        var action = PackerAction.None;
        
        foldoutMod = EditorGUILayout.Foldout(foldoutMod, "Build Mod", true, _styles.Foldout);
        if (foldoutMod)
        {
            GUILayout.BeginVertical("box");
            if (packingObjects == null || packingObjects.Length <= 0)
                EditorGUILayout.HelpBox(
                    "You didn't specified the mod xml scripts. It will automatically try to get *.xml files from the folder you're looking at in Project Window.", MessageType.Info,
                    true);
            if (!Directory.Exists(GameExportPath)) EditorGUILayout.HelpBox("You need to provide Output Directory to build mods.", MessageType.Error, true);
            GUILayout.Label("Build Mod Targets", _styles.Header);

            EditorGUILayout.PropertyField(packingObjectsField, new GUIContent("Target Mod XML Files"), true);

            GUILayout.Space(10);

            EditorPrefs.SetString("hoohTool_exportPath", EditorGUILayout.TextField("Output Destination: ", GameExportPath));
            GameExportPath = EditorPrefs.GetString("hoohTool_exportPath");

            GUILayout.BeginHorizontal();
            GUI.backgroundColor = Styles.green;
            if (GUILayout.Button("Build Mod", _styles.ButtonDark)) 
                action = PackerAction.Build;
            GUI.backgroundColor = Styles.red;
            if (GUILayout.Button("Remove All", _styles.ButtonDark))
                action = PackerAction.Remove;

            GUI.backgroundColor = Color.white;
            if (GUILayout.Button("Add Folder", _styles.Button))
                action = PackerAction.AddFolder;
            
            GUILayout.EndHorizontal();
            GUILayout.EndVertical();
            
            // To prevent fuckery - there gotta be better way. 
            DoPackerAction(action);
        }
    }

    public void DoPackerAction(PackerAction action)
    {
        switch (action)
        {
            case PackerAction.None:
                break;
            case PackerAction.Build:
                ModPacker.PackMod(packingObjects, GameExportPath);
                break;
            case PackerAction.Remove:
                var check = EditorUtility.DisplayDialog("Are you sure?", "Just checking, did you really tried to remove all target xml files?", "Yes", "No");
                if (check) packingObjects = null;
                break;
            case PackerAction.AddFolder:
                var folderAssets = ModPacker.GetProjectDirectoryTextAssets();
                if (folderAssets.Length > 0)
                    packingObjects = packingObjects != null ? packingObjects.Concat(folderAssets).Distinct().ToArray() : folderAssets;
                else
                    EditorUtility.DisplayDialog("Oh shit", "There is no xml files in project window.", "Okay i'll go to folder where has some xml files.");
                break;
        }
    }
}
#endif