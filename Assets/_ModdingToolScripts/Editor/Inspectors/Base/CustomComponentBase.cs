using System;
using System.Collections.Generic;
using MyBox;
using UnityEditor;
using UnityEngine;

public abstract class CustomComponentBase : Editor
{
    private readonly Dictionary<string, SerializedProperty> _fields = new Dictionary<string, SerializedProperty>();
    protected Enum GUIEvent;

    private void OnEnable()
    {
        _fields.Clear();
        AssignProperties();
    }

    protected void RegisterProperty(string propertyName)
    {
        _fields.Add(propertyName, serializedObject.FindProperty(propertyName));
    }

    protected SerializedProperty GetProperty(string propertyName)
    {
        return _fields[propertyName];
    }

    private bool TryGetProperty(string propertyName, out SerializedProperty property)
    {
        property = default;
        if (!_fields.ContainsKey(propertyName)) return false;
        property = _fields[propertyName];
        return true;
    }

    protected abstract void AssignProperties();

    protected abstract void DrawCustomInspector();

    protected virtual void DrawTopElements()
    {
    }

    protected virtual void DrawBottomElements()
    {
    }

    protected virtual void UpdateInspector()
    {
        serializedObject.ApplyModifiedProperties();
        Repaint();
    }

    public override void OnInspectorGUI()
    {
        // When some shit happened. Mostly my fault.
        if (_fields.IsNullOrEmpty())
        {
            GUILayout.Label("This component does not have any properties to edit.");
            return;
        }

        // Detect changes and repaint them only when detect changes.
        // Thanks for unity forum to alert me this 
        EditorGUI.BeginChangeCheck();
        DrawCustomInspector();
        if (EditorGUI.EndChangeCheck()) UpdateInspector();

        // It will restore gui layout as possible.
        if (GUIEvent == null) return;
        DoEvent();
        GUIEvent = null;
    }

    protected abstract void DoEvent();

    protected virtual void SetEvent<T>(T selectedEvent) where T : Enum
    {
        GUIEvent = selectedEvent;
    }

    protected SerializedProperty SafeProperty(string propertyName, GUIContent label, bool includeChildren = false)
    {
        if (!TryGetProperty(propertyName, out var property)) return default;
        EditorGUILayout.PropertyField(property, label, includeChildren);
        return property;
    }
}