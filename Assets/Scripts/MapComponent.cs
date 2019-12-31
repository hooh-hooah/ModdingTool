using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using UnityEngine;

namespace Studio
{
	public class MapComponent : MonoBehaviour
	{
		[Serializable]
		public class OptionInfo
		{
			public GameObject[] objectsOn;

			public GameObject[] objectsOff;
		}

		private class  SeaInfo {
			public SeaInfo()
			{
			}
		}
		public MapComponent.OptionInfo[] optionInfos;
		public GameObject objSeaParent;
		public Renderer[] renderersSea;
		private Dictionary<Renderer, MapComponent.SeaInfo> dicSeaInfo;
	}
}
