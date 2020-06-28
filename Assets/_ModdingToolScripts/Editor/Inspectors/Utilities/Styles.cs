using UnityEngine;

namespace Inspectors.Utilities
{
    public class Styles
    {
        public readonly GUIStyle header;
        public readonly GUIStyle medium;

        public Styles()
        {
            header = new GUIStyle(GUI.skin.label)
            {
                alignment = TextAnchor.MiddleLeft,
                fontSize = 13,
                fontStyle = FontStyle.Bold
            };
            medium = new GUIStyle(GUI.skin.label)
            {
                alignment = TextAnchor.MiddleLeft,
                fontSize = 11
            };
        }
    }
}