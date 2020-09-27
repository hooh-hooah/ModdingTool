using System;
using System.Collections.Generic;
using System.Linq;
using MyBox;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

public class HPointList : MonoBehaviour
{
    [SerializeField] private PlaceInfo[] HpointGroup;
    private HPoint[] HPoints;
    public Dictionary<int, List<HPoint>> lst;

    [ButtonMethod]
    public void InitializeAndSetup()
    {
        HpointGroup = GetComponentsInChildren<HPoint>()
            .Where(x => x.name == "hpoint_start")
            .Select(x => new PlaceInfo
            {
                HPoints = x.transform.parent.gameObject,
                Place = x.id,
                Start = x.gameObject
            }).ToArray();

        EditorSceneManager.MarkSceneDirty(SceneManager.GetActiveScene());
    }

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