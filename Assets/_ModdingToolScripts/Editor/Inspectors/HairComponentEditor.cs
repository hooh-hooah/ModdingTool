using System;
using System.Linq;
using AIChara;
using Inspectors.Utilities;
using ModdingTool;
using UnityEditor;
using UnityEngine;

[CustomEditor(typeof(CmpHair))]
public class HairComponentEditor : CustomComponentBase
{
    protected override void AssignProperties()
    {
        RegisterProperty("rendCheckVisible");
        RegisterProperty("rendHair");
        RegisterProperty("boneInfo");
        RegisterProperty("useTopColor");
        RegisterProperty("useUnderColor");
        RegisterProperty("rendAccessory");
        RegisterProperty("useAcsColor01");
        RegisterProperty("useAcsColor02");
        RegisterProperty("useAcsColor03");
        RegisterProperty("acsDefColor");
    }

    protected override void DrawCustomInspector()
    {
        float oldLabelWidth = EditorGUIUtility.labelWidth,
            oldFieldWWidth = EditorGUIUtility.fieldWidth;
        EditorGUIUtility.labelWidth = oldLabelWidth;
        EditorGUIUtility.fieldWidth = oldFieldWWidth;

        var hairComponent = (CmpHair) target;
        GUILayout.BeginHorizontal("box");
        var clothPresetOptions = Presets.Hairs.Select(x => x.Name).ToArray();
        hairComponent.dynamicBonePreset =
            EditorGUILayout.Popup("Dynamic Bone Preset", hairComponent.dynamicBonePreset, clothPresetOptions);

        if (GUILayout.Button("Apply"))
            SetEvent(HairEvent.AssignDynamicBone);
        GUILayout.EndHorizontal();

        GUILayout.BeginVertical("box");
        GUILayout.BeginHorizontal();
        if (GUILayout.Button("Re-Initialize Component"))
            SetEvent(HairEvent.ResetComponent);
        if (GUILayout.Button("Sync Default Values to Material"))
            SetEvent(HairEvent.ResetMaterial);
        GUILayout.EndHorizontal();
        GUILayout.EndVertical();
        GUILayout.Space(5);

        var total = hairComponent.GetComponentsInChildren<Renderer>().Length;
        var rendNormalTotal = hairComponent.rendHair.Length;
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
        GUILayout.Label("Main Hair Information", Styles.Header);
        SafeProperty("rendCheckVisible", new GUIContent("Visible Renderers"), true);
        SafeProperty("rendHair", new GUIContent("Hair Renderers"), true);
        SafeProperty("boneInfo", new GUIContent("Bone Information"), true);
        GUILayout.Space(5);
        GUILayout.Label("Main Color Information", Styles.Header);
        GUILayout.BeginHorizontal();
        EditorGUIUtility.labelWidth = 130;
        EditorGUIUtility.fieldWidth = 40;
        SafeProperty("useTopColor", new GUIContent("Top Color"));
        SafeProperty("useUnderColor", new GUIContent("Bottom Color"));
        EditorGUIUtility.labelWidth = oldLabelWidth;
        EditorGUIUtility.fieldWidth = oldFieldWWidth;
        GUILayout.EndHorizontal();
        GUILayout.EndVertical();

        GUILayout.Space(5);
        GUILayout.BeginVertical("box");
        GUILayout.Label("Accessory Information", Styles.Header);
        SafeProperty("rendAccessory", new GUIContent("Accessory Renderers"), true);
        GUILayout.BeginHorizontal();
        EditorGUIUtility.labelWidth = 130;
        EditorGUIUtility.fieldWidth = 40;
        SafeProperty("useAcsColor01", new GUIContent("Use Color 1"));
        SafeProperty("useAcsColor02", new GUIContent("Use Color 2"));
        SafeProperty("useAcsColor03", new GUIContent("Use Color 3"));
        EditorGUIUtility.labelWidth = oldLabelWidth;
        EditorGUIUtility.fieldWidth = oldFieldWWidth;
        GUILayout.EndHorizontal();
        SafeProperty("acsDefColor", new GUIContent("Default Material Parameters"), true);
        GUILayout.EndVertical();

        serializedObject.ApplyModifiedProperties();
    }


    protected override void DoEvent()
    {
        if (!(GUIEvent is HairEvent hairEvent)) return;

        var hairComponent = (CmpHair) target;
        switch (hairEvent)
        {
            case HairEvent.AssignDynamicBone:
                hairComponent.ApplyDynamicBones(Presets.Clothing[hairComponent.dynamicBonePreset]);
                break;
            case HairEvent.ResetMaterial:
                hairComponent.SyncMaterialDefaultValues();
                break;
            case HairEvent.ResetComponent:
                hairComponent.ReassignAllObjects();
                break;
            default:
                throw new ArgumentOutOfRangeException();
        }
    }

    private enum HairEvent
    {
        ResetMaterial,
        ResetComponent,
        AssignDynamicBone
    }
}