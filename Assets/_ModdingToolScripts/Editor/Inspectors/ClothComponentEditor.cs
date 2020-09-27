using System;
using System.Linq;
using AIChara;
using Inspectors.Utilities;
using ModdingTool;
using UnityEditor;
using UnityEngine;

[CustomEditor(typeof(CmpClothes))]
public class ClothComponentEditor : CustomComponentBase
{
    private int _dynPreset;

    protected override void AssignProperties()
    {
        RegisterProperty("rendCheckVisible");
        RegisterProperty("objTopDef");
        RegisterProperty("objTopHalf");
        RegisterProperty("objBotDef");
        RegisterProperty("objBotHalf");
        RegisterProperty("objOpt01");
        RegisterProperty("objOpt02");
        RegisterProperty("useBreak");
        RegisterProperty("uvScalePattern");
        for (var index = 1; index <= 3; index++)
        {
            RegisterProperty($"rendNormal0{index}");
            RegisterProperty($"useColorN{index:D2}");
            RegisterProperty($"defMainColor{index:D2}");
            RegisterProperty($"useColorA{index:D2}");
            RegisterProperty($"defGloss{index:D2}");
            RegisterProperty($"defMetallic{index:D2}");
            RegisterProperty($"defLayout{index:D2}");
            RegisterProperty($"defRotation{index:D2}");
            RegisterProperty($"defPatternColor{index:D2}");
            RegisterProperty($"defPtnIndex{index:D2}");
        }
    }

    protected override void DrawCustomInspector()
    {
        var clothComponent = (CmpClothes) target;
        GUILayout.BeginHorizontal("box");
        var clothPresetOptions = Presets.Clothing.Select(x => x.Name).ToArray();
        _dynPreset =
            EditorGUILayout.Popup("Dynamic Bone Preset", _dynPreset, clothPresetOptions);

        if (GUILayout.Button("Apply"))
            SetEvent(ClothEvent.AssignDynamicBone);
        GUILayout.EndHorizontal();

        GUILayout.BeginVertical("box");
        GUILayout.BeginHorizontal();
        if (GUILayout.Button("Re-Initialize Component"))
            SetEvent(ClothEvent.ResetComponent);
        if (GUILayout.Button("Sync Default Values to Material"))
            SetEvent(ClothEvent.ResetMaterial);
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
        GUILayout.Label("Render Objects", Styles.Header);
        SafeProperty("rendCheckVisible", new GUIContent("Visible Renderers"), true);

        for (var index = 1; index <= 3; index++)
        {
            var propertyName = $"Texture {index} Render Object";
            SafeProperty($"rendNormal0{index}", new GUIContent(propertyName), true);
        }

        GUILayout.EndVertical();

        GUILayout.Space(5);

        var oldWidth = EditorGUIUtility.labelWidth;
        EditorGUIUtility.labelWidth = 100;
        GUILayout.BeginVertical("box");
        GUILayout.Label("Cloth Object Assignment", Styles.Header);
        GUILayout.BeginHorizontal();
        SafeProperty("objTopDef", new GUIContent("Top"));
        SafeProperty("objTopHalf", new GUIContent("Top Half"));
        GUILayout.EndHorizontal();
        GUILayout.BeginHorizontal();
        SafeProperty("objBotDef", new GUIContent("Bottom"));
        SafeProperty("objBotHalf", new GUIContent("Bottom Half"));
        GUILayout.EndHorizontal();
        GUILayout.EndVertical();
        EditorGUIUtility.labelWidth = oldWidth;
        GUILayout.Space(5);

        GUILayout.BeginVertical("box");
        EditorGUIUtility.labelWidth = 100;
        GUILayout.Label("Option Objects", Styles.Header);
        GUILayout.BeginHorizontal();
        GUILayout.EndHorizontal();
        SafeProperty("objOpt01", new GUIContent("Option1 Objects"), true);
        SafeProperty("objOpt02", new GUIContent("Option2 Objects"), true);
        GUILayout.EndVertical();
        EditorGUIUtility.labelWidth = oldWidth;
        GUILayout.Space(5);

        GUILayout.BeginVertical("box");
        GUILayout.Label("Cloth Information", Styles.Header);
        SafeProperty("useBreak", new GUIContent("Enable Break Texture"));
        SafeProperty("uvScalePattern", new GUIContent("UV Scale Pattern"), true);
        GUILayout.EndVertical();
        GUILayout.Space(5);

        for (var index = 1; index <= 3; index++)
        {
            var propertyName = "Color" + index;
            GUILayout.BeginVertical("box");
            GUILayout.Label($"Cloth {propertyName} Option", Styles.Header);
            SafeProperty($"useColorN{index:D2}", new GUIContent($"Use {propertyName}"));

            GUILayout.Space(5);
            EditorGUIUtility.labelWidth = 100;
            GUILayout.BeginHorizontal();
            SafeProperty($"defMainColor{index:D2}", new GUIContent("Color"));
            SafeProperty($"useColorA{index:D2}", new GUIContent("Use Alpha"));
            GUILayout.EndHorizontal();
            GUILayout.BeginHorizontal();
            SafeProperty($"defGloss{index:D2}", new GUIContent("Glossiness"));
            SafeProperty($"defMetallic{index:D2}", new GUIContent("Metallic"));
            GUILayout.EndHorizontal();
            EditorGUIUtility.labelWidth = oldWidth;

            GUILayout.Space(5);
            SafeProperty($"defLayout{index:D2}", new GUIContent("Pattern Layout Vector"));
            EditorGUIUtility.labelWidth = 100;
            SafeProperty($"defRotation{index:D2}", new GUIContent("Rotation"));
            GUILayout.BeginHorizontal();
            SafeProperty($"defPatternColor{index:D2}", new GUIContent("Pattern Color"));
            SafeProperty($"defPtnIndex{index:D2}", new GUIContent("Pattern Index"), true);
            GUILayout.EndHorizontal();
            EditorGUIUtility.labelWidth = oldWidth;
            GUILayout.EndVertical();
            GUILayout.Space(5);
        }
    }

    protected override void DoEvent()
    {
        if (!(GUIEvent is ClothEvent clothGUIEvent)) return;

        var clothComponent = (CmpClothes) target;
        switch (clothGUIEvent)
        {
            case ClothEvent.ResetMaterial:
                clothComponent.SyncMaterialDefaultValues();
                break;
            case ClothEvent.ResetComponent:
                clothComponent.ReassignAllObjects();
                break;
            case ClothEvent.AssignDynamicBone:
                clothComponent.ApplyDynamicBones(Presets.Clothing[_dynPreset]);
                break;
            default:
                throw new ArgumentOutOfRangeException();
        }
    }

    private enum ClothEvent
    {
        ResetMaterial,
        ResetComponent,
        AssignDynamicBone
    }
}