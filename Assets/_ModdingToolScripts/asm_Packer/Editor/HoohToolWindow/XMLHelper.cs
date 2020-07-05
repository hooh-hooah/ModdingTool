using System;
using System.IO;
using UnityEditor;
using UnityEngine;

#if UNITY_EDITOR
public partial class HoohTools
{
    public GameObject[] prefabs;
    public TextAsset xmlHelperTarget;
    public int xmlBigCategory;
    public int xmlSmallCategory;
    
    public void DrawXMLHelper(SerializedObject serializedObject)
    {
        var xmlHelperTargetField = serializedObject.FindProperty("xmlHelperTarget");
        var prefabField = serializedObject.FindProperty("prefabs");
        var xmlBigCategoryField = serializedObject.FindProperty("xmlBigCategory");
        var xmlSmallCategoryField = serializedObject.FindProperty("xmlSmallCategory");

        foldoutElement = EditorGUILayout.Foldout(foldoutElement, "XML Helper", true, _styles.Foldout);
        if (foldoutElement)
        {
            // place warnings and errors
            if (xmlHelperTargetField == null) EditorGUILayout.HelpBox("You didn't specified the mod xml script.", MessageType.Error, true);

            GUILayout.BeginVertical("box");

            EditorGUILayout.PropertyField(xmlHelperTargetField, new GUIContent("Target Mod XML File"));
            EditorGUILayout.PropertyField(prefabField, new GUIContent("Prefabs to put in xml file"), true);

            GUILayout.BeginHorizontal();
                EditorGUILayout.PropertyField(xmlBigCategoryField, new GUIContent("Big Category"));
                EditorGUILayout.PropertyField(xmlSmallCategoryField, new GUIContent("Small Category"));
            GUILayout.EndHorizontal();
            
            GUILayout.Space(5);

            GUILayout.BeginHorizontal();
                if (GUILayout.Button("Add Current Directory", _styles.Button))
                {
                    
                }

                if (GUILayout.Button("Generate Studio Item List", _styles.Button))
                {
                    if (xmlHelperTarget != null) {
                        try
                        {
                            Array.Sort(prefabs, (x, y) => String.Compare(x.name, y.name, StringComparison.Ordinal));
                            var path = Path.Combine(Directory.GetCurrentDirectory(), AssetDatabase.GetAssetPath(xmlHelperTarget)).Replace("\\", "/");
                            var document = TouchXML.GetXMLObject(path);
                            TouchXML.GenerateObjectString(document, prefabs);
                            TouchXML.GenerateBundleString(document, prefabs);
                            document.Save(path);
                        }
                        catch (InvalidCastException e)
                        {
                            Debug.LogError("You've selected wrong kind of object. You should only select prefabs!");
                        }
                        catch (Exception e)
                        {
                            Debug.LogError(e);
                        }
                    }
                }
            GUILayout.EndHorizontal();
            GUILayout.EndVertical();

            Category = EditorPrefs.GetInt("hoohTool_category"); // this is mine tho
            SideloaderString = EditorPrefs.GetString("hoohTool_sideloadString");
            CategorySmall = EditorPrefs.GetInt("hoohTool_categorysmall"); // this is mine tho
        }
    }
}
#endif