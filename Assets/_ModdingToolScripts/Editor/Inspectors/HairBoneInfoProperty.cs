using System.Collections.Generic;
using AIChara;
using Studio;
using UnityEditor;
using UnityEngine;

#if I_LOEV_SHIT
[CustomPropertyDrawer(typeof(CmpHair.BoneInfo))]
public class HairBoneInfoProperty : PropertyDrawer
{
    private const float wMargin = 5f;
    private const float hMargin = 5f;
    
    public override float GetPropertyHeight(SerializedProperty property, GUIContent label)
    {
        return base.GetPropertyHeight(property, label) * 8 + hMargin * 4;
    }

    public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
    {
        EditorGUI.BeginProperty(position, label, property);
        position = EditorGUI.PrefixLabel(position, GUIUtility.GetControlID(FocusType.Passive), label);
        var indent = EditorGUI.indentLevel;
        EditorGUI.indentLevel = 0;

        // Default Inspector Variables.
        float px = position.x,
            py = position.y,
            width = position.width,
            height = base.GetPropertyHeight(property, label),
            labelRatio = 0.3f,
            valueRatio = 0.7f;

        EditorGUI.LabelField(new Rect(px, py, width * labelRatio, height), "Transform");
        EditorGUI.PropertyField(new Rect(px + width * labelRatio, py, width * valueRatio, height),
            property.FindPropertyRelative("trfCorrect"),
            GUIContent.none);
        py += height + hMargin;
        EditorGUI.LabelField(new Rect(px, py, width * labelRatio, height), "Dynamic Bones");
        var dynamicBones = property.FindPropertyRelative("dynamicBone");
        EditorGUI.PropertyField(new Rect(px + width * labelRatio, py, width * valueRatio, height * dynamicBones.arraySize),
            dynamicBones,
            GUIContent.none,
            true);
        py += height + hMargin;

        float segmentWidth = width / 2f - wMargin/2;
        float tpx = px + segmentWidth + wMargin;
        float tpy = py + height + hMargin;
        EditorGUI.LabelField(new Rect(px, py, segmentWidth, height), "Min Pos");
        EditorGUI.PropertyField(new Rect(px, tpy, segmentWidth, height),
            property.FindPropertyRelative("posMin"),
            GUIContent.none);
        EditorGUI.LabelField(new Rect(tpx, py, segmentWidth, height), "Max Pos");
        EditorGUI.PropertyField(new Rect(tpx, tpy, segmentWidth, height),
            property.FindPropertyRelative("posMax"),
            GUIContent.none);
        
        py += height * 2 + hMargin;
        tpy = py + height + hMargin;
        EditorGUI.LabelField(new Rect(px, py, segmentWidth, height), "Min Rot");
        EditorGUI.PropertyField(new Rect(px, tpy, segmentWidth, height),
            property.FindPropertyRelative("rotMin"),
            GUIContent.none);
        EditorGUI.LabelField(new Rect(tpx, py, segmentWidth, height), "Max Rot");
        EditorGUI.PropertyField(new Rect(tpx, tpy, segmentWidth, height),
            property.FindPropertyRelative("rotMax"),
            GUIContent.none);
        

        EditorGUI.indentLevel = indent;
        EditorGUI.EndProperty();
    }
}
#endif