using System;
using System.Threading;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

namespace CameraEffector
{
	[DisallowMultipleComponent]
	public class ConfigEffectorVolume : MonoBehaviour
	{
		public PostProcessVolume postProcessVolume;
		private Bloom bloom;
		private AmbientOcclusion ao;
		private ScreenSpaceReflections ssr;
		private Vignette vignette;
		public bool isBloom = true;
		public bool isAo = true;
		public bool isSsr = true;
		public bool isVignette = true;
		public ReflectionProbe rp;
		public bool isHSceneSettingUse = true;
		public ParticleSystem particle;
	}
}
