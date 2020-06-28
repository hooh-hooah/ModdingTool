using System;
using System.Collections.Generic;
using UnityEngine;

public class HPointList : MonoBehaviour
{
    [SerializeField] private PlaceInfo[] HpointGroup;
    private HPoint[] HPoints;
    public Dictionary<int, List<HPoint>> lst;

    [Serializable]
    private class PlaceInfo
    {
        [Header("Hポイントグループ")] public GameObject HPoints;
        [Header("場所")] public int Place;
        [Header("開始ポイント")] public GameObject Start;
    }

    [Serializable]
    public class LoadInfo
    {
        public string Manifest;
        public string Name;
        public string Path;
    }
}