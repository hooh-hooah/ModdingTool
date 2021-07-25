using System.IO;
using UnityEngine;

// Token: 0x02001024 RID: 4132
public class EyeLookCalc : MonoBehaviour
{
    // Token: 0x04006C61 RID: 27745
    public static bool isEnabled = true;

    // Token: 0x04006C67 RID: 27751
    public float[] angleHRate;

    // Token: 0x04006C68 RID: 27752
    public float angleVRate;

    // Token: 0x04006C6C RID: 27756
    public float drawLineLength = 1f;

    // Token: 0x04006C63 RID: 27747
    public EyeObject[] eyeObjs;

    // Token: 0x04006C66 RID: 27750
    public EyeTypeState[] eyeTypeStates;

    // Token: 0x04006C71 RID: 27761
    public Quaternion[] fixAngle = new Quaternion[2];

    // Token: 0x04006C64 RID: 27748
    public Vector3 headLookVector = Vector3.forward;

    // Token: 0x04006C65 RID: 27749
    public Vector3 headUpVector = Vector3.up;

    // Token: 0x04006C6A RID: 27754
    public bool isDebugDraw = true;

    // Token: 0x04006C6B RID: 27755
    public int ptnDraw;

    // Token: 0x04006C62 RID: 27746
    public Transform rootNode;

    // Token: 0x04006C69 RID: 27753
    public float sorasiRate = 1f;

    // Token: 0x04006C6F RID: 27759
    public GameObject targetObj;

    // Token: 0x04006C6E RID: 27758
    private bool initEnd;

    // Token: 0x04006C6D RID: 27757
    private int nowPtnNo;

    // Token: 0x04006C70 RID: 27760

    // Token: 0x17001CBE RID: 7358
    // (get) Token: 0x06008621 RID: 34337 RVA: 0x00346061 File Offset: 0x00344461
    // (set) Token: 0x06008622 RID: 34338 RVA: 0x00346069 File Offset: 0x00344469
    public Vector3 TargetPos { get; set; } = Vector3.zero;

    // Token: 0x06008623 RID: 34339 RVA: 0x00346072 File Offset: 0x00344472
    private void Awake()
    {
        if (!initEnd) Init();
    }

    // Token: 0x06008624 RID: 34340 RVA: 0x00346085 File Offset: 0x00344485
    private void Start()
    {
        if (!initEnd) Init();
    }

    // Token: 0x06008625 RID: 34341 RVA: 0x00346098 File Offset: 0x00344498
    private void OnDrawGizmos()
    {
        if (!isDebugDraw) return;
        if (rootNode)
        {
            Gizmos.color = new Color(1f, 1f, 1f, 0.8f);
            if (eyeTypeStates.Length > ptnDraw)
            {
                var eyeTypeState = eyeTypeStates[ptnDraw];
                Gizmos.color = new Color(0f, 1f, 1f, 0.8f);
                var vector =
                    rootNode.TransformDirection(Quaternion.Euler(0f, eyeTypeState.hAngleLimit, 0f) * Vector3.forward *
                                                drawLineLength) + rootNode.position;
                Gizmos.DrawLine(rootNode.position, vector);
                var vector2 =
                    rootNode.TransformDirection(Quaternion.Euler(0f, -eyeTypeState.hAngleLimit, 0f) * Vector3.forward *
                                                drawLineLength) + rootNode.position;
                Gizmos.DrawLine(rootNode.position, vector2);
                var vector3 =
                    rootNode.TransformDirection(Quaternion.Euler(eyeTypeState.vAngleLimit, 0f, 0f) * Vector3.forward *
                                                drawLineLength) + rootNode.position;
                Gizmos.DrawLine(rootNode.position, vector3);
                var vector4 =
                    rootNode.TransformDirection(Quaternion.Euler(-eyeTypeState.vAngleLimit, 0f, 0f) * Vector3.forward *
                                                drawLineLength) + rootNode.position;
                Gizmos.DrawLine(rootNode.position, vector4);
                Gizmos.DrawLine(vector, vector4);
                Gizmos.DrawLine(vector4, vector2);
                Gizmos.DrawLine(vector2, vector3);
                Gizmos.DrawLine(vector3, vector);
                Gizmos.color = new Color(1f, 0f, 1f, 0.8f);
                for (var i = 0; i < eyeObjs.Length; i++)
                {
                    vector = eyeObjs[i].eyeTransform.TransformDirection(
                        Quaternion.Euler(0f, eyeTypeState.minBendingAngle * (eyeObjs[i].eyeLR != EYE_LR.EYE_R ? -1 : 1),
                            0f) *
                        Vector3.forward * drawLineLength) + eyeObjs[i].eyeTransform.position;
                    Gizmos.DrawLine(eyeObjs[i].eyeTransform.position, vector);
                    vector2 = eyeObjs[i].eyeTransform.TransformDirection(
                        Quaternion.Euler(0f, eyeTypeState.maxBendingAngle * (eyeObjs[i].eyeLR != EYE_LR.EYE_R ? -1 : 1),
                            0f) *
                        Vector3.forward * drawLineLength) + eyeObjs[i].eyeTransform.position;
                    Gizmos.DrawLine(eyeObjs[i].eyeTransform.position, vector2);
                    vector3 = eyeObjs[i].eyeTransform.TransformDirection(
                                  Quaternion.Euler(eyeTypeState.upBendingAngle, 0f, 0f) * Vector3.forward *
                                  drawLineLength) +
                              eyeObjs[i].eyeTransform.position;
                    Gizmos.DrawLine(eyeObjs[i].eyeTransform.position, vector3);
                    vector4 = eyeObjs[i].eyeTransform.TransformDirection(
                                  Quaternion.Euler(eyeTypeState.downBendingAngle, 0f, 0f) * Vector3.forward *
                                  drawLineLength) +
                              eyeObjs[i].eyeTransform.position;
                    Gizmos.DrawLine(eyeObjs[i].eyeTransform.position, vector4);
                    Gizmos.DrawLine(vector, vector4);
                    Gizmos.DrawLine(vector4, vector2);
                    Gizmos.DrawLine(vector2, vector3);
                    Gizmos.DrawLine(vector3, vector);
                }
            }

            Gizmos.color = new Color(1f, 1f, 0f, 0.8f);
            for (var j = 0; j < eyeObjs.Length; j++)
                Gizmos.DrawLine(eyeObjs[j].eyeTransform.position,
                    eyeObjs[j].eyeTransform.position + eyeObjs[j].eyeTransform.forward * drawLineLength);
        }

        Gizmos.color = Color.white;
    }

    // Token: 0x06008626 RID: 34342 RVA: 0x00346580 File Offset: 0x00344980
    public void Init()
    {
        if (rootNode == null) rootNode = transform;
        foreach (var eyeObject in eyeObjs)
            if (!(eyeObject.eyeTransform == null))
            {
                var rotation = eyeObject.eyeTransform.parent.rotation;
                var lhs = Quaternion.Inverse(rotation);
                eyeObject.referenceLookDir = lhs * rootNode.rotation * headLookVector.normalized;
                eyeObject.referenceUpDir = lhs * rootNode.rotation * headUpVector.normalized;
                eyeObject.angleH = 0f;
                eyeObject.angleV = 0f;
                eyeObject.dirUp = eyeObject.referenceUpDir;
                eyeObject.origRotation = default;
                eyeObject.origRotation = eyeObject.eyeTransform.localRotation;
                angleHRate = new float[2];
            }

        initEnd = true;
    }

    // Token: 0x06008627 RID: 34343 RVA: 0x003466A0 File Offset: 0x00344AA0
    public void EyeUpdateCalc(Vector3 target, int ptnNo)
    {
        if (!initEnd)
        {
            if (targetObj != null && targetObj.activeSelf) targetObj.SetActive(false);
            return;
        }

        nowPtnNo = ptnNo;
        if (!isEnabled)
        {
            if (targetObj != null && targetObj.activeSelf) targetObj.SetActive(false);
            return;
        }

        if (Time.deltaTime == 0f)
        {
            if (targetObj != null && targetObj.activeSelf) targetObj.SetActive(false);
            return;
        }

        var eyeTypeState = eyeTypeStates[ptnNo];
        var eye_LOOK_TYPE = eyeTypeStates[ptnNo].lookType;
        if (eye_LOOK_TYPE == EYE_LOOK_TYPE.NO_LOOK)
        {
            eyeObjs[0].eyeTransform.localRotation = fixAngle[0];
            eyeObjs[1].eyeTransform.localRotation = fixAngle[1];
            if (targetObj != null && targetObj.activeSelf) targetObj.SetActive(false);
            return;
        }

        var position = rootNode.InverseTransformPoint(target);
        var magnitude = position.magnitude;
        if (magnitude < eyeTypeStates[ptnNo].nearDis)
        {
            position = position.normalized * eyeTypeStates[ptnNo].nearDis;
            target = rootNode.TransformPoint(position);
        }

        var vector = new Vector3(position.x, 0f, position.z);
        var num = Vector3.Dot(vector, Vector3.forward);
        var num2 = Vector3.Angle(vector, Vector3.forward);
        vector = new Vector3(0f, position.y, position.z);
        var num3 = Vector3.Dot(vector, Vector3.forward);
        var num4 = Vector3.Angle(vector, Vector3.forward);
        if (num < 0f || num3 < 0f || num2 > eyeTypeStates[ptnNo].hAngleLimit || num4 > eyeTypeStates[ptnNo].vAngleLimit)
            eye_LOOK_TYPE = EYE_LOOK_TYPE.FORWARD;
        if (eye_LOOK_TYPE == EYE_LOOK_TYPE.FORWARD)
            target = rootNode.position + rootNode.forward * eyeTypeStates[ptnNo].forntTagDis;
        if (eye_LOOK_TYPE == EYE_LOOK_TYPE.CONTROL || eyeTypeStates[ptnNo].lookType == EYE_LOOK_TYPE.CONTROL)
        {
            if (targetObj != null)
            {
                if (!targetObj.activeSelf) targetObj.SetActive(true);
                target = Vector3.MoveTowards(rootNode.transform.position, targetObj.transform.position,
                    eyeTypeStates[ptnNo].forntTagDis);
                targetObj.transform.position = Vector3.MoveTowards(rootNode.transform.position, target, 0.5f);
            }
        }
        else if (targetObj != null)
        {
            targetObj.transform.position = Vector3.MoveTowards(rootNode.transform.position, target, 0.5f);
            if (targetObj.activeSelf) targetObj.SetActive(false);
        }

        var num5 = -1f;
        foreach (var eyeObject in eyeObjs)
        {
            eyeObject.eyeTransform.localRotation = eyeObject.origRotation;
            var rotation = eyeObject.eyeTransform.parent.rotation;
            var rotation2 = Quaternion.Inverse(rotation);
            var normalized = (target - eyeObject.eyeTransform.position).normalized;
            var vector2 = rotation2 * normalized;
            var num6 = AngleAroundAxis(eyeObject.referenceLookDir, vector2, eyeObject.referenceUpDir);
            var axis = Vector3.Cross(eyeObject.referenceUpDir, vector2);
            var dirA = vector2 - Vector3.Project(vector2, eyeObject.referenceUpDir);
            var num7 = AngleAroundAxis(dirA, vector2, axis);
            var f = Mathf.Max(0f, Mathf.Abs(num6) - eyeTypeState.thresholdAngleDifference) * Mathf.Sign(num6);
            var f2 = Mathf.Max(0f, Mathf.Abs(num7) - eyeTypeState.thresholdAngleDifference) * Mathf.Sign(num7);
            num6 = Mathf.Max(Mathf.Abs(f) * Mathf.Abs(eyeTypeState.bendingMultiplier),
                       Mathf.Abs(num6) - eyeTypeState.maxAngleDifference) * Mathf.Sign(num6) *
                   Mathf.Sign(eyeTypeState.bendingMultiplier);
            num7 = Mathf.Max(Mathf.Abs(f2) * Mathf.Abs(eyeTypeState.bendingMultiplier),
                       Mathf.Abs(num7) - eyeTypeState.maxAngleDifference) * Mathf.Sign(num7) *
                   Mathf.Sign(eyeTypeState.bendingMultiplier);
            var max = eyeTypeState.maxBendingAngle;
            var min = eyeTypeState.minBendingAngle;
            if (eyeObject.eyeLR == EYE_LR.EYE_R)
            {
                max = -eyeTypeState.minBendingAngle;
                min = -eyeTypeState.maxBendingAngle;
            }

            num6 = Mathf.Clamp(num6, min, max);
            num7 = Mathf.Clamp(num7, eyeTypeState.upBendingAngle, eyeTypeState.downBendingAngle);
            var axis2 = Vector3.Cross(eyeObject.referenceUpDir, eyeObject.referenceLookDir);
            if (eye_LOOK_TYPE == EYE_LOOK_TYPE.AWAY)
            {
                if (num5 == -1f)
                {
                    var num8 = Mathf.Lerp(-1f, 1f,
                        Mathf.InverseLerp(-eyeTypeStates[nowPtnNo].maxBendingAngle,
                            -eyeTypeStates[nowPtnNo].minBendingAngle, eyeObject.angleH));
                    var num9 = Mathf.Lerp(-1f, 1f,
                        Mathf.InverseLerp(-eyeTypeStates[nowPtnNo].maxBendingAngle,
                            -eyeTypeStates[nowPtnNo].minBendingAngle, num6));
                    var num10 = num8 - num9;
                    if (Mathf.Abs(num10) < sorasiRate)
                    {
                        if (num10 < 0f)
                        {
                            if (num9 < -sorasiRate)
                                num8 = num9 + sorasiRate;
                            else
                                num8 = num9 - sorasiRate;
                        }
                        else if (num10 > 0f)
                        {
                            if (num9 > sorasiRate)
                                num8 = num9 - sorasiRate;
                            else
                                num8 = num9 + sorasiRate;
                        }
                        else
                        {
                            num8 = num9 + sorasiRate;
                        }

                        num5 = Mathf.InverseLerp(-1f, 1f, num8);
                        num6 = Mathf.Lerp(-eyeTypeStates[nowPtnNo].maxBendingAngle,
                            -eyeTypeStates[nowPtnNo].minBendingAngle, num5);
                    }
                    else
                    {
                        num5 = Mathf.InverseLerp(-1f, 1f, num8);
                        num6 = eyeObject.angleH;
                    }
                }
                else
                {
                    num6 = Mathf.Lerp(-eyeTypeStates[nowPtnNo].maxBendingAngle,
                        -eyeTypeStates[nowPtnNo].minBendingAngle, num5);
                }

                num7 = -num7;
            }

            eyeObject.angleH = Mathf.Lerp(eyeObject.angleH, num6, Time.deltaTime * eyeTypeState.leapSpeed);
            eyeObject.angleV = Mathf.Lerp(eyeObject.angleV, num7, Time.deltaTime * eyeTypeState.leapSpeed);
            vector2 = Quaternion.AngleAxis(eyeObject.angleH, eyeObject.referenceUpDir) *
                      Quaternion.AngleAxis(eyeObject.angleV, axis2) * eyeObject.referenceLookDir;
            var referenceUpDir = eyeObject.referenceUpDir;
            Vector3.OrthoNormalize(ref vector2, ref referenceUpDir);
            var forward = vector2;
            eyeObject.dirUp = Vector3.Slerp(eyeObject.dirUp, referenceUpDir, Time.deltaTime * 5f);
            Vector3.OrthoNormalize(ref forward, ref eyeObject.dirUp);
            var lhs = rotation * Quaternion.LookRotation(forward, eyeObject.dirUp) *
                      Quaternion.Inverse(rotation *
                                         Quaternion.LookRotation(eyeObject.referenceLookDir, eyeObject.referenceUpDir));
            eyeObject.eyeTransform.rotation = lhs * eyeObject.eyeTransform.rotation;
        }

        TargetPos = target;
        fixAngle[0] = eyeObjs[0].eyeTransform.localRotation;
        fixAngle[1] = eyeObjs[1].eyeTransform.localRotation;
        AngleHRateCalc();
        angleVRate = AngleVRateCalc();
    }

    // Token: 0x06008628 RID: 34344 RVA: 0x00346F5C File Offset: 0x0034535C
    public static float AngleAroundAxis(Vector3 dirA, Vector3 dirB, Vector3 axis)
    {
        dirA -= Vector3.Project(dirA, axis);
        dirB -= Vector3.Project(dirB, axis);
        var num = Vector3.Angle(dirA, dirB);
        return num * (Vector3.Dot(axis, Vector3.Cross(dirA, dirB)) >= 0f ? 1 : -1);
    }

    // Token: 0x06008629 RID: 34345 RVA: 0x00346FB0 File Offset: 0x003453B0
    public void setEnable(bool setFlag)
    {
        isEnabled = setFlag;
    }

    // Token: 0x0600862A RID: 34346 RVA: 0x00346FB8 File Offset: 0x003453B8
    private void AngleHRateCalc()
    {
        for (var i = 0; i < 2; i++)
            if (eyeObjs[i] != null)
            {
                if (eyeObjs[i].eyeLR == EYE_LR.EYE_R)
                    angleHRate[i] = Mathf.Lerp(-1f, 1f,
                        Mathf.InverseLerp(-eyeTypeStates[nowPtnNo].maxBendingAngle,
                            -eyeTypeStates[nowPtnNo].minBendingAngle, eyeObjs[i].angleH));
                else
                    angleHRate[i] = Mathf.Lerp(-1f, 1f,
                        Mathf.InverseLerp(eyeTypeStates[nowPtnNo].minBendingAngle,
                            eyeTypeStates[nowPtnNo].maxBendingAngle, eyeObjs[i].angleH));
            }
    }

    // Token: 0x0600862B RID: 34347 RVA: 0x00347098 File Offset: 0x00345498
    private float AngleVRateCalc()
    {
        if (eyeObjs[0] == null) return 0f;
        if (eyeTypeStates[nowPtnNo].downBendingAngle <= eyeTypeStates[nowPtnNo].upBendingAngle)
        {
            if (0f <= eyeObjs[0].angleV)
                return -Mathf.InverseLerp(0f, eyeTypeStates[nowPtnNo].upBendingAngle, eyeObjs[0].angleV);
            return Mathf.InverseLerp(0f, eyeTypeStates[nowPtnNo].downBendingAngle, eyeObjs[0].angleV);
        }

        if (0f <= eyeObjs[0].angleV)
            return -Mathf.InverseLerp(0f, eyeTypeStates[nowPtnNo].downBendingAngle, eyeObjs[0].angleV);
        return Mathf.InverseLerp(0f, eyeTypeStates[nowPtnNo].upBendingAngle, eyeObjs[0].angleV);
    }

    // Token: 0x0600862C RID: 34348 RVA: 0x003471B8 File Offset: 0x003455B8
    public float GetAngleHRate(EYE_LR eyeLR)
    {
        if (eyeLR == EYE_LR.EYE_L) return angleHRate[0];
        return angleHRate[1];
    }

    // Token: 0x0600862D RID: 34349 RVA: 0x003471D1 File Offset: 0x003455D1
    public float GetAngleVRate()
    {
        return angleVRate;
    }

    // Token: 0x0600862E RID: 34350 RVA: 0x003471DC File Offset: 0x003455DC
    public void SaveAngle(BinaryWriter writer)
    {
        fixAngle[0] = eyeObjs[0].eyeTransform.localRotation;
        fixAngle[1] = eyeObjs[1].eyeTransform.localRotation;
        writer.Write(fixAngle[0].x);
        writer.Write(fixAngle[0].y);
        writer.Write(fixAngle[0].z);
        writer.Write(fixAngle[0].w);
        writer.Write(fixAngle[1].x);
        writer.Write(fixAngle[1].y);
        writer.Write(fixAngle[1].z);
        writer.Write(fixAngle[1].w);
    }

    // Token: 0x0600862F RID: 34351 RVA: 0x003472E8 File Offset: 0x003456E8
    public void LoadAngle(BinaryReader reader)
    {
        fixAngle[0] = new Quaternion(reader.ReadSingle(), reader.ReadSingle(), reader.ReadSingle(),
            reader.ReadSingle());
        fixAngle[1] = new Quaternion(reader.ReadSingle(), reader.ReadSingle(), reader.ReadSingle(),
            reader.ReadSingle());
        eyeObjs[0].eyeTransform.localRotation = fixAngle[0];
        eyeObjs[1].eyeTransform.localRotation = fixAngle[1];
    }
}