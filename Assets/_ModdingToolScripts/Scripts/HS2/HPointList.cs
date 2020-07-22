using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using MyBox;
using UnityEditor;
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

    [ButtonMethod]
    public void InitializeAndSetup()
    {
        HpointGroup = this.GetComponentsInChildren<HPoint>()
            .Where(x => x.name == "hpoint_start")
            .Select(x => new PlaceInfo
            {
                HPoints = x.transform.parent.gameObject,
                Place = x.id,
                Start = x.gameObject
            }).ToArray();
    }
}