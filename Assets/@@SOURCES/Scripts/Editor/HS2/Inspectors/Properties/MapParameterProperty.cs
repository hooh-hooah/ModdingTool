using Inspectors.Utilities;
using UnityEditor;
using UnityEngine;

[CustomPropertyDrawer(typeof(MapInfo.Param))]
public class MapParameterEditor : PropertyDrawer
{
    private const int labelWidth = 200;

    public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
    {
        GUILayout.BeginVertical("box");

        GUILayout.BeginVertical();
        GUILayout.Label("Map Information", Styles.Header);

        var numberProperty = property.FindPropertyRelative("No");
        EditorGUILayout.PropertyField(numberProperty);

        GUILayout.Label("Map Name");
        GUILayout.BeginHorizontal();
        var mapNamesProperty = property.FindPropertyRelative("MapNames");
        var japaneseNameProperty = mapNamesProperty.GetArrayElementAtIndex(0);
        var englishNameProperty = mapNamesProperty.GetArrayElementAtIndex(1);
        EditorGUILayout.PropertyField(japaneseNameProperty, GUIContent.none);
        EditorGUILayout.PropertyField(englishNameProperty, GUIContent.none);
        GUILayout.EndHorizontal();

        var oldWidth = EditorGUIUtility.labelWidth;
        EditorGUI.indentLevel = 0;
        EditorGUIUtility.labelWidth = labelWidth;
        var assetBundleProperty = property.FindPropertyRelative("AssetBundleName");
        var assetName = property.FindPropertyRelative("AssetName");
        EditorGUILayout.PropertyField(assetBundleProperty);
        EditorGUILayout.PropertyField(assetName);
        EditorGUIUtility.labelWidth = oldWidth;
        GUILayout.EndVertical();

        GUILayout.BeginVertical();
        GUILayout.Label("Map Flags", Styles.Header);
        EditorGUIUtility.labelWidth = labelWidth;
        var stateProperty = property.FindPropertyRelative("State");
        var drawProperty = property.FindPropertyRelative("Draw");
        var isOutdoorsProperty = property.FindPropertyRelative("isOutdoors");
        var isADVProperty = property.FindPropertyRelative("isADV");
        EditorGUILayout.PropertyField(stateProperty);
        EditorGUILayout.PropertyField(drawProperty);
        EditorGUILayout.PropertyField(isOutdoorsProperty);
        EditorGUILayout.PropertyField(isADVProperty);
        // get event dropdown
        EditorGUIUtility.labelWidth = oldWidth;
        GUILayout.EndVertical();

        GUILayout.BeginVertical();
        GUILayout.Label("Thumbnails", Styles.Header);

        var ltProperty = property.FindPropertyRelative("ThumbnailManifest_S");
        var stProperty = property.FindPropertyRelative("ThumbnailManifest_L");
        EditorGUILayout.PropertyField(ltProperty);
        stProperty.stringValue = ltProperty.stringValue;

        var lbProperty = property.FindPropertyRelative("ThumbnailBundle_S");
        var sbProperty = property.FindPropertyRelative("ThumbnailBundle_L");
        EditorGUILayout.PropertyField(lbProperty);
        sbProperty.stringValue = lbProperty.stringValue;

        var liProperty = property.FindPropertyRelative("ThumbnailAsset_S");
        var siProperty = property.FindPropertyRelative("ThumbnailAsset_L");
        EditorGUILayout.PropertyField(liProperty);
        EditorGUILayout.PropertyField(siProperty);
        GUILayout.EndVertical();

        GUILayout.EndVertical();
    }
}