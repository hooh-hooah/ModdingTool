#if UNITY_EDITOR
using UnityEditor;
using UnityEngine;

[CustomEditor(typeof(BaseBoneNavigator))]
public class BaseBoneNavigatorEditor : Editor
{
    private int columns = 4;
    public override void OnInspectorGUI()
    {
        var navigatorComponent = (BaseBoneNavigator) target;

        EditorGUI.indentLevel = 1;
        GUILayout.BeginVertical("box");
            EditorGUILayout.PropertyField(
                serializedObject.FindProperty("baseMesh"), new GUIContent("Base Meshes"), true);
            EditorGUILayout.PropertyField(
                serializedObject.FindProperty("skinnedMesh"), new GUIContent("Clothing Objects"), true);
        GUILayout.EndVertical();

        int index = 0;
        GUILayout.BeginVertical("box");
        foreach (var pairs in BaseBoneNavigator.AccessoryPoints)
        {
            var name = pairs.Key;
            var objectName = pairs.Value;
            var column = index % columns;
            
            if (column == 0) GUILayout.BeginHorizontal();
            if (GUILayout.Button(name, EditorStyles.toolbarButton)) navigatorComponent.NavigateToBone(objectName);
            if (column == columns - 1) GUILayout.EndHorizontal();
            
            index++;
        }
        GUILayout.EndVertical();
        EditorGUI.indentLevel = 0;

        if (GUILayout.Button("Initialize BaseMesh"))
        {
            
        }

        if (GUILayout.Button("Clothing Mesh"))
        {
            
        }
        
        serializedObject.ApplyModifiedProperties();
    }
}
#endif