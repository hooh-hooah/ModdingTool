using System;
using System.IO;
using UnityEditor;
using UnityEngine;

#if UNITY_EDITOR
public partial class HoohTools
{
    public void DrawXMLHelper(SerializedObject serializedObject)
    {
        foldoutElement = EditorGUILayout.Foldout(foldoutElement, "Element Generator", true, foldoutStyle);
        if (foldoutElement)
        {
            EditorPrefs.SetInt("hoohTool_category", int.Parse(EditorGUILayout.TextField("Big Category Number: ", Category.ToString())));
            EditorPrefs.SetInt("hoohTool_categorysmall", int.Parse(EditorGUILayout.TextField("Mid Category Number: ", CategorySmall.ToString())));
            EditorPrefs.SetString("hoohTool_sideloadString", EditorGUILayout.TextField("Game Assetbundle Path: ", SideloaderString));

            Category = EditorPrefs.GetInt("hoohTool_category"); // this is mine tho
            SideloaderString = EditorPrefs.GetString("hoohTool_sideloadString");
            CategorySmall = EditorPrefs.GetInt("hoohTool_categorysmall"); // this is mine tho

            if (GUILayout.Button("Generate And Fill Item List in mod.xml"))
                if (CheckGoodSelection())
                    try
                    {
                        var selections = Selection.gameObjects;
                        Array.Sort(selections, delegate(GameObject x, GameObject y) { return x.name.CompareTo(y.name); });
                        var path = Path.Combine(Path.Combine(Directory.GetCurrentDirectory(), ModPacker.GetProjectPath()), "mod.xml").Replace("\\", "/");

                        var document = TouchXML.GetXMLObject(path);
                        TouchXML.GenerateObjectString(document, selections);
                        TouchXML.GenerateBundleString(document, selections);
                        Debug.Log(path);
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

            if (GUILayout.Button("Add Bone Information of this object"))
                if (CheckGoodSelection())
                    try
                    {
                        var selections = Selection.gameObjects;
                        var path = Path.Combine(Path.Combine(Directory.GetCurrentDirectory(), ModPacker.GetProjectPath()), "mod.xml").Replace("\\", "/");

                        var document = TouchXML.GetXMLObject(path);
                        TouchXML.GenerateBoneString(document, selections);
                        Debug.Log(path);
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
}
#endif