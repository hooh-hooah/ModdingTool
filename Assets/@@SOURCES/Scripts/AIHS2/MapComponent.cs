using System;
using MyBox;
using UnityEngine;

namespace Studio
{
    public class MapComponent : MonoBehaviour
    {
        [Header("ライト")] public OptionInfo[] lightInfos;

        [Header("海面関係")] public GameObject objSeaParent;
        [Header("オプション")] public OptionInfo[] optionInfos;
        public Renderer[] renderersSea;


        public bool CheckOption => !optionInfos.IsNullOrEmpty();


        public bool IsLight => !lightInfos.IsNullOrEmpty();

        public void SetOptionVisible(bool _value)
        {
        }

        public void SetOptionVisible(int _idx, bool _value)
        {
        }

        public void SetSeaRenderer()
        {
        }

        public void SetupSea()
        {
        }

        public void SetLightVisible(bool _value)
        {
        }

        [Serializable]
        public class OptionInfo
        {
            public GameObject[] objectsOff;
            public GameObject[] objectsOn;


            public bool Visible
            {
                set
                {
                    if (value)
                    {
                        SetVisible(objectsOff, false);
                        SetVisible(objectsOn, true);
                        return;
                    }

                    SetVisible(objectsOn, false);
                    SetVisible(objectsOff, true);
                }
            }

            private void SetVisible(GameObject[] _objects, bool _value)
            {
            }
        }

        private class SeaInfo
        {
            public SeaInfo(Collider _collider, LuxWater_WaterVolume _waterVolume)
            {
                Collider = _collider;
                WaterVolume = _waterVolume;
            }


            public Collider Collider { get; }


            public LuxWater_WaterVolume WaterVolume { get; }


            public bool Enable
            {
                set
                {
                    if (Collider != null) Collider.enabled = value;
                    if (WaterVolume != null) WaterVolume.enabled = value;
                }
            }
        }
    }
}