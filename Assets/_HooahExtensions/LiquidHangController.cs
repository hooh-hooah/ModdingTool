using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LiquidHangController : MonoBehaviour
{
    public Transform tStart;
    public Transform tEnd;
    public Transform tMiddle;
    public Transform tOffset;
    // public DynamicBone dynBone;
    // public AnimationCurve distribCurve = new AnimationCurve();
    //
    // public Vector3 offset = new Vector3();
    // public Vector3 dynBoneOffset = new Vector3();
    // public float offsetScale = 0.1f;
    // public float distMax = 1000f;
    // public float distFactor = 0f;

    // Start is called before the first frame update
    // Update is called once per frame
    void FixedUpdate()
    {
        var s = tStart.localPosition;
        var e = tEnd.localPosition;
        var distance = (s - e).sqrMagnitude;
        // distFactor = Mathf.Max(0, Mathf.Min(1, distance / distMax)) * transform.localScale.x;
        tMiddle.localPosition = Vector3.Lerp(s, e, 0.5f);
        // offset.y = -Mathf.Abs(distribCurve.Evaluate(distFactor)) * offsetScale;
        // dynBoneOffset.z = offset.y;
        // dynBone.m_EndOffset = dynBoneOffset;
        // tOffset.localPosition = offset;

        var dir = (s - e).normalized;
        tStart.LookAt(tOffset, dir);
        tEnd.LookAt(tOffset, dir);
    }
}