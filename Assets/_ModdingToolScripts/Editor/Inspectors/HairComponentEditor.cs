using System.Linq;
using AIChara;
using Inspectors.Utilities;
using UnityEditor;
using UnityEngine;

[CustomEditor(typeof(CmpHair))]
public class HairComponentEditor : Editor
{ 
     private Styles _styles;
     
     void InitStyles()
     {
         _styles = new Styles();
     }

     public override void OnInspectorGUI()
    {
        InitStyles();
         
        float oldLabelWidth = EditorGUIUtility.labelWidth,
              oldFieldWIdth = EditorGUIUtility.fieldWidth;
        EditorGUIUtility.labelWidth = oldLabelWidth;
        EditorGUIUtility.fieldWidth = oldFieldWIdth;

        CmpHair hairComponent = (CmpHair) target;
        GUILayout.BeginHorizontal("box");
            string[] clothPresetOptions = ModdingTool.Presets.Hairs.Select(x => x.name).ToArray();
            hairComponent.dynamicBonePreset =
                EditorGUILayout.Popup("Dynamic Bone Preset", hairComponent.dynamicBonePreset, clothPresetOptions);
        
            if (GUILayout.Button("Apply"))
                hairComponent.ApplyDynamicBones(ModdingTool.Presets.Clothing[hairComponent.dynamicBonePreset]);
        GUILayout.EndHorizontal();
        
        GUILayout.BeginVertical("box");
            GUILayout.BeginHorizontal();
            if (GUILayout.Button("Re-Initialize Component"))
                hairComponent.ReassignAllObjects();
            if (GUILayout.Button("Sync Default Values to Material"))
                hairComponent.SyncMaterialDefaultValues();
            GUILayout.EndHorizontal();
        GUILayout.EndVertical();
        GUILayout.Space(5);
        
        int total = hairComponent.GetComponentsInChildren<Renderer>().Length;
        int rendNormalTotal = hairComponent.rendHair.Length;
        if (hairComponent.rendCheckVisible != null && hairComponent.rendCheckVisible.Length <= 0)
            EditorGUILayout.HelpBox(
                "Rend Check Visible is EMPTY! Clothing will not rendered if rend check visible is not assigned.",
                MessageType.Error);
        if (rendNormalTotal <= 0)
            EditorGUILayout.HelpBox("Nothing is assigned to Rend Hair!", MessageType.Error);
        if (hairComponent.rendCheckVisible != null && total != hairComponent.rendCheckVisible.Length)
            EditorGUILayout.HelpBox("Some Mesh Renderer is not assigned to rendCheckVisible List.", MessageType.Warning);
        if (rendNormalTotal != total)
            EditorGUILayout.HelpBox("Some Mesh Renderer is not assigned to rendNormal List.", MessageType.Warning);
        
        EditorGUI.indentLevel++;
        GUILayout.BeginVertical("box");
            GUILayout.Label("Main Hair Information", _styles.header);
		    EditorGUILayout.PropertyField(serializedObject.FindProperty("rendCheckVisible"), new GUIContent("Visible Renderers"), true);
		    EditorGUILayout.PropertyField(serializedObject.FindProperty("rendHair"), new GUIContent("Hair Renderers"), true);
		    EditorGUILayout.PropertyField(serializedObject.FindProperty("boneInfo"), new GUIContent("Bone Information"), true);
            GUILayout.Space(5);
            GUILayout.Label("Main Color Information", _styles.header);
            GUILayout.BeginHorizontal();
                EditorGUIUtility.labelWidth = 130;
                EditorGUIUtility.fieldWidth = 40;
		        EditorGUILayout.PropertyField(serializedObject.FindProperty("useTopColor"), new GUIContent("Top Color"));
		        EditorGUILayout.PropertyField(serializedObject.FindProperty("useUnderColor"), new GUIContent("Bottom Color"));
                EditorGUIUtility.labelWidth = oldLabelWidth;
                EditorGUIUtility.fieldWidth = oldFieldWIdth;
            GUILayout.EndHorizontal();
        GUILayout.EndVertical();
		
        GUILayout.Space(5);
        GUILayout.BeginVertical("box");
            GUILayout.Label("Accessory Information", _styles.header);
            EditorGUILayout.PropertyField(serializedObject.FindProperty("rendAccessory"), new GUIContent("Accessory Renderers"), true);
            GUILayout.BeginHorizontal();
                EditorGUIUtility.labelWidth = 130;
                EditorGUIUtility.fieldWidth = 40;
		        EditorGUILayout.PropertyField(serializedObject.FindProperty("useAcsColor01"), new GUIContent("Use Color 1"));
		        EditorGUILayout.PropertyField(serializedObject.FindProperty("useAcsColor02"), new GUIContent("Use Color 2"));
		        EditorGUILayout.PropertyField(serializedObject.FindProperty("useAcsColor03"), new GUIContent("Use Color 3"));
                EditorGUIUtility.labelWidth = oldLabelWidth;
                EditorGUIUtility.fieldWidth = oldFieldWIdth;
            GUILayout.EndHorizontal();
		    EditorGUILayout.PropertyField(serializedObject.FindProperty("acsDefColor"), new GUIContent("Default Material Parameters"), true);
        GUILayout.EndVertical();
        
        serializedObject.ApplyModifiedProperties();
    }
}