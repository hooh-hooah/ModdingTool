using UnityEngine;

namespace Map
{
    public class MapEnvSetting : MonoBehaviour
    {
        [SerializeField] private AudioSource[] audioSources;

        public AudioSource[] AudioSources
        {
            get => audioSources;
            set => audioSources = value;
        }

        // Add initialize button
    }
}