using System;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

[Serializable]
public class HPoint : MonoBehaviour
{
    private static Vector3 size = new Vector3(4, 12, 4);
    private static Vector3 center = new Vector3(0, size.y / 2, 0);
    private static Vector3 sizeDir = new Vector3(1, 1, 6);
    private static Vector3 centerDir = new Vector3(0, size.y / 2, -3);
    // private static Texture pof = Resources.Load<Texture2D>("gizmo_icon_pof");

    private static List<HScene.AnimationListInfo>[] animationLists;

    private static bool showerMasturbation;

    // Some OBI Collider
    private Dictionary<int, ObiCollider[]> colHide = new Dictionary<int, ObiCollider[]>();
    private Dictionary<int, ObiCollider[]> colShow = new Dictionary<int, ObiCollider[]>();

    [SerializeField] private HpointData data;

    // Map Objects
    [SerializeField]
    // Hide those object when this hpoint is active.
    private GameObject[] hideObj;

    [SerializeField]
    // Hide those object for shower event.
    private GameObject[] hideShower;

    [Tooltip("Registered ID")] public int id;

    private bool nowUsing;

    [SerializeField]
    // Show those object when this hpoint is active.
    private GameObject[] showObj;

    public bool NowUsing
    {
        get => nowUsing;
        set => nowUsing = value;
    }

    public HpointData Data
    {
        get => data;
        set => data = value;
    }

    public void OnDrawGizmos()
    {
        Gizmos.color = Color.red;
        Gizmos.matrix = transform.localToWorldMatrix;
        Gizmos.DrawWireCube(center, size);
        Gizmos.DrawWireCube(centerDir, sizeDir);
        // Gizmos.DrawIcon(center, "gizmo_icon_pof", true);
    }

    public int CheckVisible(GameObject obj)
    {
        return 1;
    }

    [Serializable]
    public struct NotMotionInfo
    {
        [HideInInspector] public List<int> motionID;
    }

    [Serializable]
        public class HpointData
    {
        public NotMotionInfo[] notMotion = new NotMotionInfo[6];

            public HpointData()
        {
            notMotion = new NotMotionInfo[6];
            for (var i = 0; i < notMotion.Length; i++) notMotion[i].motionID = new List<int>();
        }
    }
}