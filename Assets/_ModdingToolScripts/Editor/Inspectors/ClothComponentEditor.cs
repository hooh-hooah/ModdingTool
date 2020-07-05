using System.Linq;
using AIChara;
using Inspectors.Utilities;
using ModdingTool;
using UnityEditor;
using UnityEngine;

[CustomEditor(typeof(CmpClothes))]
public class ClothComponentEditor : Editor
{
    private Styles _styles;

    private void InitStyles()
    {
        _styles = new Styles();
    }

    private int dynPreset = 0;
    private int bodyPreset = 0;
    public override void OnInspectorGUI()
    {
        InitStyles();

        var clothComponent = (CmpClothes) target;
        GUILayout.BeginHorizontal("box");
            var clothPresetOptions = Presets.Clothing.Select(x => x.name).ToArray();
            dynPreset =
                EditorGUILayout.Popup("Dynamic Bone Preset", dynPreset, clothPresetOptions);

            if (GUILayout.Button("Apply"))
                clothComponent.ApplyDynamicBones(Presets.Clothing[dynPreset]);
        GUILayout.EndHorizontal();

        GUILayout.BeginHorizontal("box");
            var bodyPresetOptions = Presets.Body.Select(x => x.name).ToArray();
            bodyPreset =
                EditorGUILayout.Popup("Body Shape Preset", bodyPreset, bodyPresetOptions);

            if (GUILayout.Button("Apply")) AIHSPresetLoader.LoadObject(clothComponent.gameObject, bodyPreset);
        GUILayout.EndHorizontal();

        GUILayout.BeginVertical("box");
            GUILayout.BeginHorizontal();
            if (GUILayout.Button("Re-Initialize Component"))
                clothComponent.ReassignAllObjects();
            if (GUILayout.Button("Sync Default Values to Material"))
                clothComponent.SyncMaterialDefaultValues();
            GUILayout.EndHorizontal();
        GUILayout.EndVertical();

        GUILayout.Space(5);
        
        if (clothComponent.rendCheckVisible != null && clothComponent.rendCheckVisible.Length <= 0)
            EditorGUILayout.HelpBox(
                "Rend Check Visible is EMPTY! Clothing will not rendered if rend check visible is not assigned.",
                MessageType.Error);
        var rendNormalTotal = clothComponent.rendNormal01?.Length + clothComponent.rendNormal02?.Length +
                              clothComponent.rendNormal03?.Length;
        if (rendNormalTotal <= 0)
            EditorGUILayout.HelpBox("Nothing is assigned to Rend Normal!", MessageType.Error);
        if (clothComponent.objTopDef == null && clothComponent.objBotDef == null && clothComponent.objTopHalf == null &&
            clothComponent.objBotHalf == null)
            EditorGUILayout.HelpBox("Nothing is assigned to objTop/objBot - This is critical if you're making top/bottom outfit.", MessageType.Warning);

        var total = clothComponent.GetComponentsInChildren<Renderer>().Length;
        if (clothComponent.rendCheckVisible == null || total != clothComponent.rendCheckVisible.Length)
            EditorGUILayout.HelpBox("Some Mesh Renderer is not assigned to rendCheckVisible List.", MessageType.Warning);
        if (rendNormalTotal != total)
            EditorGUILayout.HelpBox("Some Mesh Renderer is not assigned to rendNormal List.", MessageType.Warning);

        EditorGUI.indentLevel++;
        GUILayout.BeginVertical("box");
        GUILayout.Label("Render Objects", _styles.header);
        EditorGUILayout.PropertyField(serializedObject.FindProperty("rendCheckVisible"), new GUIContent("Visible Renderers"), true);

        for (var index = 1; index <= 3; index++)
        {
            var name = $"Color {index} Render Object";
            EditorGUILayout.PropertyField(serializedObject.FindProperty($"rendNormal0{index}"), new GUIContent(name), true);
        }
        GUILayout.EndVertical();

        GUILayout.Space(5);

        var oldWidth = EditorGUIUtility.labelWidth;
        EditorGUIUtility.labelWidth = 100;
        GUILayout.BeginVertical("box");
            GUILayout.Label("Cloth Object Assignment", _styles.header);
            GUILayout.BeginHorizontal();
            EditorGUILayout.PropertyField(serializedObject.FindProperty("objTopDef"), new GUIContent("Top"));
            EditorGUILayout.PropertyField(serializedObject.FindProperty("objTopHalf"), new GUIContent("Top Half"));
            GUILayout.EndHorizontal();
            GUILayout.BeginHorizontal();
            EditorGUILayout.PropertyField(serializedObject.FindProperty("objBotDef"), new GUIContent("Bottom"));
            EditorGUILayout.PropertyField(serializedObject.FindProperty("objBotHalf"), new GUIContent("Bottom Half"));
            GUILayout.EndHorizontal();
        GUILayout.EndVertical();
        EditorGUIUtility.labelWidth = oldWidth;
        GUILayout.Space(5);

        GUILayout.BeginVertical("box");
        EditorGUIUtility.labelWidth = 100;
        GUILayout.Label("Option Objects", _styles.header);
        GUILayout.BeginHorizontal();
        GUILayout.EndHorizontal();
        EditorGUILayout.PropertyField(serializedObject.FindProperty("objOpt01"), new GUIContent("Option1 Objects"), true);
        EditorGUILayout.PropertyField(serializedObject.FindProperty("objOpt02"), new GUIContent("Option2 Objects"), true);
        GUILayout.EndVertical();
        EditorGUIUtility.labelWidth = oldWidth;
        GUILayout.Space(5);

        GUILayout.BeginVertical("box");
        GUILayout.Label("Cloth Information", _styles.header);
        EditorGUILayout.PropertyField(serializedObject.FindProperty("useBreak"), new GUIContent("Enable Break Texture"));
        EditorGUILayout.PropertyField(serializedObject.FindProperty("uvScalePattern"), new GUIContent("UV Scale Pattern"), true);
        GUILayout.EndVertical();
        GUILayout.Space(5);

        for (var index = 1; index <= 3; index++)
        {
            var name = "Color" + index;
            GUILayout.BeginVertical("box");
                GUILayout.Label($"Cloth {name} Option", _styles.header);
                EditorGUILayout.PropertyField(serializedObject.FindProperty($"useColorN{index:D2}"), new GUIContent($"Use {name}"));
                
                GUILayout.Space(5);
                EditorGUIUtility.labelWidth = 100;
                GUILayout.BeginHorizontal();
                    EditorGUILayout.PropertyField(serializedObject.FindProperty($"defMainColor{index:D2}"), new GUIContent("Color"));
                    EditorGUILayout.PropertyField(serializedObject.FindProperty($"useColorA{index:D2}"), new GUIContent("Use Alpha"));
                GUILayout.EndHorizontal();
                GUILayout.BeginHorizontal();
                    EditorGUILayout.PropertyField(serializedObject.FindProperty($"defGloss{index:D2}"), new GUIContent("Glossiness"));
                    EditorGUILayout.PropertyField(serializedObject.FindProperty($"defMetallic{index:D2}"), new GUIContent("Metallic"));
                GUILayout.EndHorizontal();
                EditorGUIUtility.labelWidth = oldWidth;
                
                GUILayout.Space(5);
                EditorGUILayout.PropertyField(serializedObject.FindProperty($"defLayout{index:D2}"), new GUIContent("Pattern Layout Vector"));
                EditorGUIUtility.labelWidth = 100;
                EditorGUILayout.PropertyField(serializedObject.FindProperty($"defRotation{index:D2}"), new GUIContent("Rotation"));
                GUILayout.BeginHorizontal();
                EditorGUILayout.PropertyField(serializedObject.FindProperty($"defPatternColor{index:D2}"), new GUIContent("Pattern Color"));
                EditorGUILayout.PropertyField(serializedObject.FindProperty($"defPtnIndex{index:D2}"), new GUIContent("Pattern Index"), true);
                GUILayout.EndHorizontal();
                EditorGUIUtility.labelWidth = oldWidth;
            GUILayout.EndVertical();
            GUILayout.Space(5);
        }
        
        serializedObject.ApplyModifiedProperties();
    }
}