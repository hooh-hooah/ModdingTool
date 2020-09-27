using System;
using System.Collections.Generic;
using ModdingTool;
using UnityEngine;

[Serializable]
public class HPoint : MonoBehaviour
{
    private const float wallThickness = .4f;
    private const float deskThickness = 6f;

    private const float counterThickness = 9.05f;

    private const float chairThickness = 4.07f;
    private static Vector3 size = new Vector3(4, 12, 4);
    private static Vector3 center = new Vector3(0, size.y / 2, 0);
    private static Vector3 sizeDir = new Vector3(1, 1, 6);

    private static Vector3 centerDir = new Vector3(0, size.y / 2, -3);
    // private static Texture pof = Resources.Load<Texture2D>("gizmo_icon_pof");

    private static List<HScene.AnimationListInfo>[] animationLists;

    private static bool showerMasturbation;
    private static Vector3 wallSize = new Vector3(4, 12, wallThickness);
    private static Vector3 floorSize = new Vector3(4, wallThickness, 4);
    private static Vector3 deskSize = new Vector3(4, 6.67f, deskThickness);
    private static Vector3 stairsSize = new Vector3(4, 2, 4);
    private static Vector3 wallOffset = wallSize.FilterAxis(0).MulValue(1, .5f).MulValue(2, -.5f);
    private static Vector3 floorOffset = floorSize.FilterAxis(0, 2).MulValue(1, -.5f);
    private static Vector3 deskOffset = deskSize.FilterAxis(0).MulValue(1, .5f).MulValue(2, -.5f);
    private static Color guideColor = new Color(0.61f, 0.35f, 0.71f, 0.5f);
    private static Vector3 counterSize = new Vector3(4, counterThickness, 4);
    private static Vector3 counterOffset = counterSize.FilterAxis(0).MulValue(1, .5f).MulValue(2, -.5f);
    private static Vector3 chairSize = new Vector3(4, chairThickness, 4);
    private static Vector3 chairOffset = chairSize.FilterAxis(0, 2).MulValue(1, .5f);

    [SerializeField] private HpointData data;

    // Map Objects
    [SerializeField]
    // Hide those object when this hpoint is active.
    private GameObject[] hideObj;

    [SerializeField]
    // Hide those object for shower event.
    private GameObject[] hideShower;

    [Tooltip("Registered ID")] public int id;

    [SerializeField]
    // Show those object when this hpoint is active.
    private GameObject[] showObj;

    // Some OBI Collider
    private Dictionary<int, ObiCollider[]> colHide = new Dictionary<int, ObiCollider[]>();
    private Dictionary<int, ObiCollider[]> colShow = new Dictionary<int, ObiCollider[]>();

    private bool nowUsing;

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

        Gizmos.color = guideColor;
        switch (id)
        {
            case 0:
                Gizmos.DrawCube(floorOffset + Vector3.forward * -2, floorSize + Vector3.forward * 4 + Vector3.right * 4);
                break;
            case 3:
                Gizmos.DrawCube(chairOffset, chairSize);
                Gizmos.DrawCube(floorOffset + Vector3.forward * 4, floorSize);
                break;
            case 2: // Wall
                Gizmos.DrawCube(wallOffset, wallSize);
                Gizmos.DrawCube(floorOffset, floorSize);
                break;
            case 4:
                Gizmos.DrawCube(deskOffset, deskSize);
                Gizmos.DrawCube(floorOffset, floorSize);
                break;
            case 9:
                Gizmos.DrawCube(counterOffset, counterSize);
                Gizmos.DrawCube(floorOffset, floorSize);
                break;
            case 10:
                var offset = new Vector3();
                Gizmos.DrawCube(offset + floorOffset, floorSize);
                offset[2] -= 3f;
                offset[1] += 1f;
                Gizmos.DrawCube(offset, stairsSize);
                offset[2] -= 3f;
                offset[1] += 2f;
                Gizmos.DrawCube(offset, stairsSize);
                break;
            default:
                Gizmos.DrawCube(floorOffset, floorSize);
                break;
        }

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