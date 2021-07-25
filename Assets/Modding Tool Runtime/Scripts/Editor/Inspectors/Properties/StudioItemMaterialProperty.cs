using System.Collections.Generic;
using Studio;
using UnityEditor;
using UnityEngine;

[CustomPropertyDrawer(typeof(ItemComponent.MaterialInfo))]
public class StudioMaterialInfoProperty : PropertyDrawer
{
    private const int columns = 3;
    private const float rowHeight = 20;
    private const float labelMargin = 16;

    private static readonly Dictionary<string, string> variableList = new Dictionary<string, string>
    {
        {"isColor1", "Use Color1"},
        {"isPattern1", "Use Pattern1"},
        {"isColor2", "Use Color2"},
        {"isPattern2", "Use Pattern2"},
        {"isColor3", "Use Color3"},
        {"isPattern3", "Use Pattern3"},
        {"isEmission", "Use Emission"},
        {"isAlpha", "Use Alpha"},
        {"isGlass", "Use Glass"}
    };

    public override float GetPropertyHeight(SerializedProperty property, GUIContent label)
    {
        var propertyHeight = base.GetPropertyHeight(property, label);
        return propertyHeight + Mathf.Ceil(variableList.Count / columns) * rowHeight;
    }

    public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
    {
        EditorGUI.BeginProperty(position, label, property);
        position = EditorGUI.PrefixLabel(position, GUIUtility.GetControlID(FocusType.Passive), label);
        var indent = EditorGUI.indentLevel;
        EditorGUI.indentLevel = 0;

        var index = 0;
        float yIncr = 0, xIncr = 0, columnWidth = position.width / columns;
        foreach (var variable in variableList)
        {
            if (index != 0 && index % columns == 0)
            {
                xIncr = 0;
                yIncr += 20;
            }

            float px = position.x + xIncr, py = position.y + yIncr;

            EditorGUI.LabelField(new Rect(px + labelMargin, py, columnWidth, position.height), variable.Value);
            EditorGUI.PropertyField(
                new Rect(px, py, 16, 16),
                property.FindPropertyRelative(variable.Key),
                GUIContent.none);

            xIncr += columnWidth;
            index++;
        }

        EditorGUI.indentLevel = indent;
        EditorGUI.EndProperty();
    }
}