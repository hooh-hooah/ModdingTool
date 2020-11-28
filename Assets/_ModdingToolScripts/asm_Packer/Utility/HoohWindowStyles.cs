#if UNITY_EDITOR
using System.Diagnostics;
using UnityEditor;
using UnityEngine;

namespace Common
{
    public class HoohWindowStyles
    {
        public static HoohWindowStyles Instance => _instance ?? (_instance = new HoohWindowStyles());
        private static HoohWindowStyles _instance;
        public GUIStyle Button;
        public GUIStyle ButtonDark;
        public GUIStyle ButtonGood;
        public GUIStyle ButtonWarning;
        public GUIStyle Foldout;
        public GUIStyle Header;
        public GUIStyle Medium;
        public GUIStyle Title;
        public GUIStyle ButtonTab;

        public static Color red => new Color(0.91f, 0.3f, 0.24f);
        public static Color green => new Color(0.18f, 0.8f, 0.44f);

        private HoohWindowStyles()
        {
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
            ButtonDark = new GUIStyle(Button) {normal = {textColor = Color.white}, active = {textColor = Color.white}, hover = {textColor = Color.white}};
            ButtonWarning = new GUIStyle(Button);
            ButtonGood = new GUIStyle(Button);
            
            ButtonTab = new GUIStyle(GUI.skin.button)
            {
                fixedHeight = 32,
                margin = new RectOffset(0, 0, 0, 32)
            };
        }
    }
}
#endif