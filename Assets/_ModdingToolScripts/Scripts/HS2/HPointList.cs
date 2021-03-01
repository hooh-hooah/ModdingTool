using System;
using System.Collections.Generic;
using System.Linq;
using MyBox;
using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine.SceneManagement;
#endif


#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649
public class HPointList : MonoBehaviour
{
    [SerializeField] private PlaceInfo[] HpointGroup;
    private HPoint[] HPoints;
    public Dictionary<int, List<HPoint>> lst;

#if UNITY_EDITOR
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
        EditorUtility.SetDirty(this);
    }
#endif
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