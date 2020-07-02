#if UNITY_EDITOR
using DebugComponents;
using UnityEditor;
using UnityEngine;

[CustomEditor(typeof(DevPreviewHair))]
public class HairPreviewEditor : Editor
{
    private int columns = 4;
    public override void OnInspectorGUI()
    {
        var hairPreviewComponent = (DevPreviewHair) target;

        var previewMainColor= serializedObject.FindProperty($"previewMainColor");
        var previewSpecColor= serializedObject.FindProperty($"previewSpecColor");
        var previewTopColor= serializedObject.FindProperty($"previewTopColor");
        var previewUnderColor= serializedObject.FindProperty($"previewUnderColor");
        GUILayout.BeginVertical("box");
            GUILayout.Label("Colors");
            GUILayout.BeginHorizontal();
            EditorGUILayout.PropertyField(previewMainColor, new GUIContent($"Preview Main Color"));
            EditorGUILayout.PropertyField(previewSpecColor, new GUIContent($"Preview Spec Color"));
            GUILayout.EndHorizontal();
            GUILayout.BeginHorizontal();
            EditorGUILayout.PropertyField(previewTopColor, new GUIContent($"Preview Top Color"));
            EditorGUILayout.PropertyField(previewUnderColor, new GUIContent($"Preview Under Color"));
            GUILayout.EndHorizontal();
        GUILayout.EndVertical();
        
        GUILayout.Space(5);
        
        var mapDiffuse = serializedObject.FindProperty($"mapDiffuse");
        var mapNormal = serializedObject.FindProperty($"mapNormal");
        var mapAO = serializedObject.FindProperty($"mapAO");
        var mapNoise = serializedObject.FindProperty($"mapNoise");
        var mapColormask = serializedObject.FindProperty($"mapColormask");
        var detailScale = serializedObject.FindProperty($"detailScale");
        GUILayout.BeginVertical("box");
        GUILayout.Label("Textures");
            EditorGUILayout.PropertyField(mapDiffuse, new GUIContent($"Map Diffuse"));
            EditorGUILayout.PropertyField(mapNormal, new GUIContent($"Map Normal"));
            EditorGUILayout.PropertyField(mapAO, new GUIContent($"Map Ao"));
            EditorGUILayout.PropertyField(mapNoise, new GUIContent($"Map Noise"));
            EditorGUILayout.PropertyField(mapColormask, new GUIContent($"Map Colormask"));
        GUILayout.EndVertical();
        
        GUILayout.Space(5);
        
        GUILayout.BeginVertical("box");
            GUILayout.Label("Material Parameters");
            EditorGUILayout.PropertyField(detailScale, new GUIContent($"Detail Scale"));
        GUILayout.EndVertical();
        
        GUILayout.Space(5);
        
        GUILayout.BeginHorizontal("box");
        if (GUILayout.Button("Initialize"))
        {
            hairPreviewComponent.LoadAndSetTexture();
        }
        if (GUILayout.Button("Assign Textures"))
        {
            hairPreviewComponent.SetupTextureBasedDirectory();
        }
        GUILayout.EndHorizontal();
        
        serializedObject.ApplyModifiedProperties();
    }
}
#endif