using UnityEngine;

namespace Inspectors.Utilities
{
    public static class Styles
    {
        private static GUIStyle _header;
        private static GUIStyle _medium;
        public static GUIStyle Header => GetHeaderStyle();
        public static GUIStyle Medium => GetMediumStyle();

        private static GUIStyle GetHeaderStyle()
        {
            return _header ?? (_header = new GUIStyle(GUI.skin.label)
            {
                alignment = TextAnchor.MiddleLeft,
                fontSize = 13,
                fontStyle = FontStyle.Bold
            });
        }

        private static GUIStyle GetMediumStyle()
        {
            return _medium ?? (_medium = new GUIStyle(GUI.skin.label)
            {
                alignment = TextAnchor.MiddleLeft,
                fontSize = 13,
                fontStyle = FontStyle.Bold
            });
        }
    }
}