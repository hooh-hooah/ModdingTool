using Studio;
using UnityEditor;
using UnityEngine;

[CustomPropertyDrawer(typeof(ItemComponent.AnimeInfo))]
public class StudioAnimeProperty : PropertyDrawer
{
    public override float GetPropertyHeight(SerializedProperty property, GUIContent label)
    {
        return base.GetPropertyHeight(property, label) * 2;
    }

    public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
    {
        EditorGUI.BeginProperty(position, label, property);
        position = EditorGUI.PrefixLabel(position, GUIUtility.GetControlID(FocusType.Passive), label);
        float height = base.GetPropertyHeight(property, label),
            padding = 10f,
            width = position.width / 2 - padding / 2,
            px = position.x;
        var indent = EditorGUI.indentLevel;
        EditorGUI.indentLevel = 0;

        EditorGUI.LabelField(new Rect(px, position.y, width, height), "Display Name");
        EditorGUI.PropertyField(new Rect(px, position.y + height, width, height),
            property.FindPropertyRelative("name"), GUIContent.none);

        px += width + padding;
        EditorGUI.LabelField(new Rect(px, position.y, width, height), "Animation Name");
        EditorGUI.PropertyField(new Rect(px, position.y + height, width, height),
            property.FindPropertyRelative("state"), GUIContent.none);

        EditorGUI.indentLevel = indent;
        EditorGUI.EndProperty();
    }
}