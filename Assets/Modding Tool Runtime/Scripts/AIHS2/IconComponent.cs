using UnityEngine;

namespace Studio
{
    public class IconComponent : MonoBehaviour
    {
        [SerializeField] private Renderer renderer;

        private Transform transRender;

        private Transform transTarget;

        public bool active
        {
            get => renderer.enabled;
            set => renderer.enabled = value;
        }

        public int Layer
        {
            set => renderer.gameObject.layer = value;
        }
    }
}