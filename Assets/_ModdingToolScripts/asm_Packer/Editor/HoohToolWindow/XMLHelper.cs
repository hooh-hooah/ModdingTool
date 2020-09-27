using System;
using System.Linq;
using ModPackerModule.Structure.SideloaderMod;
using ModPackerModule.Utility;
using UnityEditor;
using UnityEngine;

#if UNITY_EDITOR
public partial class HoohTools
{
    public GameObject[] prefabs;
    public int xmlBigCategory;
    public TextAsset xmlHelperTarget;
    public int xmlSmallCategory;

    public void DrawXMLHelper(SerializedObject serializedObject)
    {
        var xmlHelperTargetField = serializedObject.FindProperty("xmlHelperTarget");
        var prefabField = serializedObject.FindProperty("prefabs");
        var xmlBigCategoryField = serializedObject.FindProperty("xmlBigCategory");
        var xmlSmallCategoryField = serializedObject.FindProperty("xmlSmallCategory");

        foldoutElement = EditorGUILayout.Foldout(foldoutElement, "Mod Scaffolding", true, _styles.Foldout);
        if (!foldoutElement) return;
        // place warnings and errors
        if (xmlHelperTargetField == null) EditorGUILayout.HelpBox("You didn't specified the mod xml script.", MessageType.Error, true);

        GUILayout.BeginVertical("box");

        EditorGUILayout.PropertyField(xmlHelperTargetField, new GUIContent("Target Mod XML File"));
        EditorGUILayout.PropertyField(prefabField, new GUIContent("Prefabs to put in xml file"), true);

        GUILayout.BeginHorizontal();
        EditorGUILayout.PropertyField(xmlBigCategoryField, new GUIContent("Big Category"));
        EditorGUILayout.PropertyField(xmlSmallCategoryField, new GUIContent("Mid Category"));
        GUILayout.EndHorizontal();

        GUILayout.Space(5);

        GUILayout.BeginHorizontal();
        if (GUILayout.Button("Add Current Directory", _styles.Button))
            _guiEventAction = () =>
            {
                var gameObjects = PathUtils.LoadAssetsFromDirectory<GameObject>(PathUtils.GetProjectPath(), ".prefab$");
                prefabs = prefabs.Concat(gameObjects).Distinct().ToArray();
            };

        if (GUILayout.Button("Generate Studio Item List", _styles.Button))
            _guiEventAction = () =>
            {
                if (xmlHelperTarget == null) return;

                try
                {
                    Array.Sort(prefabs, (x, y) => string.Compare(x.name, y.name, StringComparison.Ordinal));
                    var sideloaderModObject = new SideloaderMod(xmlHelperTarget);
                    sideloaderModObject.UpsertStudioItems(prefabs, xmlBigCategory, xmlSmallCategory);
                    sideloaderModObject.Save();
                }
                catch (Exception e)
                {
                    Debug.LogError(e);
                }
            };

        GUILayout.EndHorizontal();
        GUILayout.EndVertical();

        Category = EditorPrefs.GetInt("hoohTool_category"); // this is mine tho
        SideloaderString = EditorPrefs.GetString("hoohTool_sideloadString");
        CategorySmall = EditorPrefs.GetInt("hoohTool_categorysmall"); // this is mine tho
    }
}
#endif