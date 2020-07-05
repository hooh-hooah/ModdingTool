#if UNITY_EDITOR
using UnityEditor;
using UnityEngine;

namespace Common
{
    public class Styles
    {
        public GUIStyle Button;
        public GUIStyle ButtonDark;
        public GUIStyle ButtonGood;
        public GUIStyle ButtonWarning;
        public GUIStyle Foldout;

        // fuck me
        public GUIStyle Header;
        private bool init;
        public GUIStyle Medium;
        public GUIStyle Title;

        public static Color red => new Color(0.91f, 0.3f, 0.24f);

        public static Color green => new Color(0.18f, 0.8f, 0.44f);

        public void Init()
        {
            if (init) return;
            Medium = new GUIStyle(GUI.skin.label)
            {
                alignment = TextAnchor.MiddleLeft,
                fontSize = 11
            };
            Header = new GUIStyle(GUI.skin.label)
            {
                alignment = TextAnchor.MiddleLeft,
                fontSize = 12,
                fontStyle = FontStyle.Bold
            };
            Title = new GUIStyle(GUI.skin.label) {fontSize = 15, margin = new RectOffset(10, 10, 0, 10)};
            Foldout = new GUIStyle(EditorStyles.foldout) {fontSize = 15, margin = new RectOffset(10, 10, 0, 10)};
            Button = new GUIStyle(EditorStyles.toolbarButton)
            {
                fontSize = 11, margin = new RectOffset(2, 2, 2, 2), padding = new RectOffset(5, 5, 5, 5), fixedHeight = 23
            };
            ButtonDark = new GUIStyle(Button);
            ButtonDark.normal.textColor = Color.white;
            ButtonDark.active.textColor = Color.white;
            ButtonDark.hover.textColor = Color.white;
            ButtonWarning = new GUIStyle(Button);
            ButtonGood = new GUIStyle(Button);
            init = true;
        }
    }
}
#endif