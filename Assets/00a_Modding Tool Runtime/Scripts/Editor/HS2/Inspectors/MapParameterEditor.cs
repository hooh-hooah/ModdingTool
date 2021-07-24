using Inspectors.Utilities;
using MyBox;
using UnityEditor;
using UnityEngine;

[CustomEditor(typeof(MapInfo))]
public class MapInfoEditor : CustomComponentBase
{
    private const int labelWidth = 150;


    protected override void AssignProperties()
    {
        RegisterProperty("param");
    }

    protected override void DrawCustomInspector()
    {
        var mapInfo = (MapInfo) target;

        if (GUILayout.Button("Auto-fix Everything")) SetEvent(ButtonAction.AutoFix);
        GUILayout.BeginHorizontal("box");
        GUILayout.Label($"Map List ({mapInfo.param.Count})", Styles.Header);
        if (GUILayout.Button("+", new GUIStyle("button") {fixedWidth = 20f})) SetEvent(ButtonAction.Add);
        if (GUILayout.Button("-", new GUIStyle("button") {fixedWidth = 20f})) SetEvent(ButtonAction.Remove);
        GUILayout.EndHorizontal();

        var property = GetProperty("param");
        if (property == null) return;
        for (var i = 0; i < property.arraySize; i++) EditorGUILayout.PropertyField(property.GetArrayElementAtIndex(i));
    }

    protected override void DoEvent()
    {
        var mapInfo = (MapInfo) target;
        switch (GUIEvent)
        {
            case ButtonAction.Remove:
            {
                if (!mapInfo.param.IsNullOrEmpty()) mapInfo.param.RemoveAt(mapInfo.param.Count - 1);
                UpdateInspector();
                break;
            }
            case ButtonAction.Add:
                mapInfo.param.Add(new MapInfo.Param());
                UpdateInspector();
                break;
            case ButtonAction.None:
                break;
            case ButtonAction.AutoFix:
                mapInfo.AutoFix();
                UpdateInspector();
                break;
        }
    }


    private enum ButtonAction { None, Add, Remove, AutoFix }
}