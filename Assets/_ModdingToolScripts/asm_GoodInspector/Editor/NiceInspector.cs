#if UNITY_EDITOR
using System;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public abstract class NiceInspector : Editor
{
    private GUIEventAction _eventAction;

    private readonly Dictionary<string, SerializedProperty> _propertyCache = new Dictionary<string, SerializedProperty>();

    public void OnEnable()
    {
        InitializeProperties();
    }

    protected T GetTarget<T>() where T : MonoBehaviour
    {
        return Convert.ChangeType(target, typeof(T)) as T;
    }

    protected abstract void DrawInspectorGUI();
    protected abstract void InitializeProperties();

    protected virtual void OnChange()
    {
    }

    public override void OnInspectorGUI()
    {
        base.OnInspectorGUI();

        EditorGUI.BeginChangeCheck();
        DrawInspectorGUI();
        var endChangeCheck = EditorGUI.EndChangeCheck();

        try
        {
            _eventAction?.Invoke();
        }
        catch (Exception e)
        {
            Debug.LogError(e);
            // ignored
        }
        finally
        {
            _eventAction = null;
        }

        if (!endChangeCheck) return;
        OnChange();
        serializedObject.ApplyModifiedProperties();
    }

    protected void Run(GUIEventAction dEventAction)
    {
        _eventAction = dEventAction;
    }

    protected void RegisterProperty(string key)
    {
        var property = serializedObject.FindProperty("name");
        if (property != null) _propertyCache.Add(key, property);
    }

    protected bool TryGetProperty(string key, out SerializedProperty property)
    {
        return _propertyCache.TryGetValue(key, out property);
    }

    protected delegate void GUIEventAction();
}
#endif