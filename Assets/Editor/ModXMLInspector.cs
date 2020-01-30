using System.Collections;
using System.Xml.Linq;
using UnityEditor;
using UnityEngine;

/// <summary>
/// Inspector for .SVG assets
/// </summary>
[CustomEditor(typeof(TextAsset))]
public class SVGEditor : Editor {
    private GUIStyle foldoutStyle;
    private GUIStyle titleStyle;
    private Vector2 scrollPos;

    public override void OnInspectorGUI() {
        // .svg files are imported as a DefaultAsset.
        // Need to determine that this default asset is an .svg file
        var path = AssetDatabase.GetAssetPath(target);

        if (path.EndsWith("mod.xml")) {
            SVGInspectorGUI();
        } else {
            base.OnInspectorGUI();
        }
    }

    void InitStyle() {
        titleStyle = new GUIStyle();
        titleStyle.fontSize = 15;
        titleStyle.margin = new RectOffset(10, 10, 0, 10);
        foldoutStyle = new GUIStyle(EditorStyles.foldout);
        foldoutStyle.fontSize = 15;
        foldoutStyle.margin = new RectOffset(10, 10, 0, 10);
    }

    public static void DrawUILine(Color color, int thickness = 1, int padding = 15) {
        Rect r = EditorGUILayout.GetControlRect(GUILayout.Height(padding + thickness));
        r.height = thickness;
        r.y += padding / 2;
        r.x -= 2;
        r.width += 6;
        EditorGUI.DrawRect(r, color);
    }

    private void SVGInspectorGUI() {
        InitStyle();
        
        // TODO: Check if XML is valid 

        GUI.enabled = true;
        EditorGUILayout.BeginVertical();
        scrollPos = EditorGUILayout.BeginScrollView(scrollPos, GUILayout.Width(0), GUILayout.Height(0));

        if (GUILayout.Button("Generate Item List")) {
            Debug.Log("The fuck");
        }

        if (GUILayout.Button("Generate Bone List")) {
        }

        EditorGUILayout.EndScrollView();
        EditorGUILayout.EndVertical();
    }
}