using UnityEngine;

#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649
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