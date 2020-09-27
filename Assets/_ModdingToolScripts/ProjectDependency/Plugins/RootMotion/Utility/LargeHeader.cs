using UnityEngine;

namespace RootMotion
{
    /// <summary>
    ///     Large header attribute for Editor.
    /// </summary>
    public class LargeHeader : PropertyAttribute
    {
        public string color = "white";

        public string name;

        public LargeHeader(string name)
        {
            this.name = name;
            color = "white";
        }

        public LargeHeader(string name, string color)
        {
            this.name = name;
            this.color = color;
        }
    }
}