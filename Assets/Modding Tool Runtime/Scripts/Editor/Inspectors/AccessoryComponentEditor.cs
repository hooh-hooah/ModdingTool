#if UNITY_EDITOR
using System;
using AIChara;
using Inspectors.Utilities;
using UnityEditor;
using UnityEngine;

[CustomEditor(typeof(CmpAccessory))]
public class AccessoryComponentEditor : CustomComponentBase
{
    protected override void AssignProperties()
    {
        RegisterProperty("rendCheckVisible");
        RegisterProperty("rendNormal");
        RegisterProperty("trfMove01");
        RegisterProperty("trfMove02");
        RegisterProperty("typeHair");
        for (var index = 1; index <= 3; index++)
        {
            RegisterProperty($"useColor{index:D2}");
            RegisterProperty($"useGloss{index:D2}");
            RegisterProperty($"useMetallic{index:D2}");
            RegisterProperty($"defColor{index:D2}");
            RegisterProperty($"defGlossPower{index:D2}");
            RegisterProperty($"defMetallicPower{index:D2}");
        }
    }

    protected override void DrawCustomInspector()
    {
        var accComponent = (CmpAccessory) target;

        GUILayout.BeginVertical("box");
        GUILayout.BeginHorizontal();
        if (GUILayout.Button("Re-Initialize Component"))
            SetEvent(AccessoryEvent.ResetComponent);
        if (GUILayout.Button("Sync Default Values to Material"))
            SetEvent(AccessoryEvent.ResetMaterial);
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
            EditorGUILayout.HelpBox("Some Mesh Renderer is not assigned to rendCheckVisible List.",
                MessageType.Warning);
        if (rendNormalTotal != total)
            EditorGUILayout.HelpBox("Some Mesh Renderer is not assigned to rendNormal List.", MessageType.Warning);

        EditorGUI.indentLevel++;
        GUILayout.BeginVertical("box");
        GUILayout.Label("Render Objects", Styles.Header);
        SafeProperty("rendCheckVisible", new GUIContent("Visible Renderers"), true);
        SafeProperty("rendNormal", new GUIContent("Accessory Renderer"), true);
        SafeProperty("trfMove01", new GUIContent("Move Target 1"));
        SafeProperty("trfMove02", new GUIContent("Move Target 2"));
        SafeProperty("typeHair", new GUIContent("Is Hair Type Accessory?"));
        GUILayout.EndVertical();

        GUILayout.Space(5);

        var oldWidth = EditorGUIUtility.labelWidth;
        for (var index = 1; index <= 4; index++)
        {
            var colorName = "Color" + index;
            GUILayout.BeginVertical("box");
            GUILayout.Label($"{colorName} Option", Styles.Header);

            SerializedProperty property = null;
            if (index < 4) property = SafeProperty($"useColor{index:D2}", new GUIContent($"Use Color {index}"));

            if (index >= 4 || property != null && property.boolValue)
            {
                GUILayout.Space(5);
                GUILayout.BeginHorizontal();
                SafeProperty($"useGloss{index:D2}", new GUIContent("Use Gloss"));
                SafeProperty($"useMetallic{index:D2}", new GUIContent("Use Metallic"));
                GUILayout.EndHorizontal();

                GUILayout.Space(5);
                SafeProperty($"defColor{index:D2}", new GUIContent("Default Color"));
                SafeProperty($"defGlossPower{index:D2}", new GUIContent("Default Gloss"));
                SafeProperty($"defMetallicPower{index:D2}", new GUIContent("Default Metallic"));
            }

            EditorGUIUtility.labelWidth = oldWidth;
            GUILayout.EndVertical();
            GUILayout.Space(5);
        }

        serializedObject.ApplyModifiedProperties();
    }

    protected override void DoEvent()
    {
        if (!(GUIEvent is AccessoryEvent accessoryEvent)) return;

        var cmpAccessory = (CmpAccessory) target;
        switch (accessoryEvent)
        {
            case AccessoryEvent.ResetMaterial:
                cmpAccessory.SyncMaterialDefaultValues();
                break;
            case AccessoryEvent.ResetComponent:
                cmpAccessory.ReassignAllObjects();
                break;
            default:
                throw new ArgumentOutOfRangeException();
        }
    }

    private enum AccessoryEvent { ResetMaterial, ResetComponent }
}
#endif