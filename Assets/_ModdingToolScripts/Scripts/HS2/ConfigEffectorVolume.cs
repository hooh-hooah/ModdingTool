using MyBox;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

namespace CameraEffector
{
    [DisallowMultipleComponent]
    public class ConfigEffectorVolume : MonoBehaviour
    {
        public bool isAo = true;
        public bool isBloom = true;
        public bool isHSceneSettingUse = true;
        public bool isSsr = true;
        public bool isVignette = true;
        public ParticleSystem particle;
        public PostProcessVolume postProcessVolume;
        public ReflectionProbe rp;
        private AmbientOcclusion ao;
        private Bloom bloom;
        private ScreenSpaceReflections ssr;
        private Vignette vignette;

        [ButtonMethod]
        public static void CheckValid()
        {
        }
    }
}