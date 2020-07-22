#if UNITY_EDITOR
using AIChara;
using Inspectors.Utilities;
using UnityEditor;
using UnityEngine;

[CustomEditor(typeof(CmpAccessory))]
public class AccessoryComponentEditor : CustomComponentBase
{
    private int _dynPreset = 0;
    private int _bodyPreset = 0;
    public override void OnInspectorGUI()
    {
        InitStyles();

        var accComponent = (CmpAccessory) target;

        GUILayout.BeginVertical("box");
            GUILayout.BeginHorizontal();
            if (GUILayout.Button("Re-Initialize Component"))
                accComponent.ReassignAllObjects();
            if (GUILayout.Button("Sync Default Values to Material"))
                accComponent.SyncMaterialDefaultValues();
            GUILayout.EndHorizontal();
        GUILayout.EndVertical();

        GUILayout.Space(5);
        
        if (accComponent.rendCheckVisible != null && accComponent.rendCheckVisible.Length <= 0)
            EditorGUILayout.HelpBox(
                "Rend Check Visible is EMPTY! Accessory will not rendered if rend check visible is not assigned.",
                MessageType.Error);
        
        var rendNormalTotal = accComponent.rendNormal?.Length;
        if (rendNormalTotal <= 0)
            EditorGUILayout.HelpBox("Nothing is assigned to Rend Normal!", MessageType.Error);

        var total = accComponent.GetComponentsInChildren<Renderer>().Length;
        if (accComponent.rendCheckVisible == null || total != accComponent.rendCheckVisible.Length)
            EditorGUILayout.HelpBox("Some Mesh Renderer is not assigned to rendCheckVisible List.", MessageType.Warning);
        if (rendNormalTotal != total)
            EditorGUILayout.HelpBox("Some Mesh Renderer is not assigned to rendNormal List.", MessageType.Warning);

        EditorGUI.indentLevel++;
        GUILayout.BeginVertical("box");
        GUILayout.Label("Render Objects", Styles.header);
        EditorGUILayout.PropertyField(serializedObject.FindProperty("rendCheckVisible"), new GUIContent("Visible Renderers"), true);
        EditorGUILayout.PropertyField(serializedObject.FindProperty("rendNormal"), new GUIContent("Accessory Renderer"), true);
        EditorGUILayout.PropertyField(serializedObject.FindProperty("trfMove01"), new GUIContent("Move Target 1"));
        EditorGUILayout.PropertyField(serializedObject.FindProperty("trfMove02"), new GUIContent("Move Target 2"));
        GUILayout.EndVertical();

        GUILayout.Space(5);

        var oldWidth = EditorGUIUtility.labelWidth;
        for (var index = 1; index <= 4; index++)
        {
            var colorName = "Color" + index;
            GUILayout.BeginVertical("box");
                GUILayout.Label($"{colorName} Option", Styles.header);

                SerializedProperty property = null;
                if (index < 4)
                {
                    property = serializedObject.FindProperty($"useColor{index:D2}");
                    EditorGUILayout.PropertyField(property, new GUIContent($"Use Color {index}"));
                }

                if (index >= 4 || (property != null && property.boolValue))
                {   
                    GUILayout.Space(5);
                    GUILayout.BeginHorizontal();
                    EditorGUILayout.PropertyField(serializedObject.FindProperty($"useGloss{index:D2}"), new GUIContent($"Use Gloss"));
                    EditorGUILayout.PropertyField(serializedObject.FindProperty($"useMetallic{index:D2}"), new GUIContent($"Use Metallic"));
                    GUILayout.EndHorizontal();
                    
                    GUILayout.Space(5);
                    EditorGUILayout.PropertyField(serializedObject.FindProperty($"defColor{index:D2}"), new GUIContent($"Default Color"));
                    EditorGUILayout.PropertyField(serializedObject.FindProperty($"defGlossPower{index:D2}"), new GUIContent($"Default Gloss"));
                    EditorGUILayout.PropertyField(serializedObject.FindProperty($"defMetallicPower{index:D2}"), new GUIContent($"Default Metallic"));
                }
             
                EditorGUIUtility.labelWidth = oldWidth;
            GUILayout.EndVertical();
            GUILayout.Space(5);
        }
        
        serializedObject.ApplyModifiedProperties();
    }
}
#endif