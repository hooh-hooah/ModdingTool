#if UNITY_EDITOR
using System.IO;
using System.Linq;
using Common;
using ModPackerModule;
using UnityEditor;
using UnityEngine;

public partial class HoohTools
{
    public TextAsset[] packingObjects;

    public void DrawModBuilder(SerializedObject serializedObject)
    {
        var packingObjectsField = serializedObject.FindProperty("packingObjects");

        foldoutMod = EditorGUILayout.Foldout(foldoutMod, "Build Mod", true, Style.Foldout);
        if (!foldoutMod) return;

        GUILayout.BeginVertical("box");
        if (packingObjects == null || packingObjects.Length <= 0)
            EditorGUILayout.HelpBox(
                "You didn't specified the mod xml scripts. It will automatically try to get *.xml files from the folder you're looking at in Project Window.", MessageType.Info,
                true);
        if (!Directory.Exists(GameExportPath)) EditorGUILayout.HelpBox("You need to provide Output Directory to build mods.", MessageType.Error, true);
        GUILayout.Label("Build Mod Targets", Style.Header);

        EditorGUILayout.PropertyField(packingObjectsField, new GUIContent("Target Mod XML Files"), true);

        GUILayout.Space(10);

        EditorPrefs.SetString("hoohTool_exportPath", EditorGUILayout.TextField("Output Destination: ", GameExportPath));
        GameExportPath = EditorPrefs.GetString("hoohTool_exportPath");

        GUILayout.BeginHorizontal();
        GUI.backgroundColor = HoohWindowStyles.green;
        if (GUILayout.Button("Build Mod", Style.ButtonDark))
            SetEvent(() => { ModPacker.PackMod(packingObjects, GameExportPath); });
        GUI.backgroundColor = HoohWindowStyles.red;
        if (GUILayout.Button("Remove All", Style.ButtonDark))
            SetEvent(() =>
            {
                var check = EditorUtility.DisplayDialog("Are you sure?", "Just checking, did you really tried to remove all target xml files?", "Yes", "No");
                if (check) packingObjects = null;
            });
        GUI.backgroundColor = Color.white;
        if (GUILayout.Button("Add Folder", Style.Button))
            SetEvent(() =>
            {
                var folderAssets = ModPacker.GetProjectDirectoryTextAssets();
                if (folderAssets.Length > 0)
                    packingObjects = packingObjects != null ? packingObjects.Concat(folderAssets).Distinct().ToArray() : folderAssets;
                else
                    EditorUtility.DisplayDialog("Oh noes", "There is no xml files in project window.", "Okay i'll go to folder where has some xml files.");
            });
        GUILayout.EndHorizontal();
        GUILayout.BeginHorizontal();
        if (GUILayout.Button("Dry Run", Style.Button))
            SetEvent(
                () => { ModPacker.PackMod(packingObjects, GameExportPath, true); }
            );
        GUILayout.EndHorizontal();
        GUILayout.EndVertical();
    }
}
#endif