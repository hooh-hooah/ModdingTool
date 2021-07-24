using System;
using UnityEngine;

#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649
namespace ADV.EventCG
{
    public class Data : MonoBehaviour
    {
        public string mapName;

        public Scene[] scenes;

        [Serializable]
        public class Scene
        {
        }
    }
}