using System;
using UnityEngine;

// Token: 0x02001023 RID: 4131
[Serializable]
public class EyeTypeState
{
    // Token: 0x04006C55 RID: 27733
    [Range(0f, 10f)] public float bendingMultiplier = 0.4f;

    // Token: 0x04006C58 RID: 27736
    [Range(0f, 100f)] public float downBendingAngle = 6f;

    // Token: 0x04006C5C RID: 27740
    [Range(0f, 100f)] public float forntTagDis = 50f;

    // Token: 0x04006C5E RID: 27742
    [Range(0f, 180f)] public float hAngleLimit = 110f;

    // Token: 0x04006C5B RID: 27739
    [Range(0f, 100f)] public float leapSpeed = 2.5f;

    // Token: 0x04006C60 RID: 27744
    public EYE_LOOK_TYPE lookType = EYE_LOOK_TYPE.TARGET;

    // Token: 0x04006C56 RID: 27734
    [Range(0f, 100f)] public float maxAngleDifference = 10f;

    // Token: 0x04006C5A RID: 27738
    [Range(0f, 100f)] public float maxBendingAngle = 6f;

    // Token: 0x04006C59 RID: 27737
    [Range(-100f, 0f)] public float minBendingAngle = -6f;

    // Token: 0x04006C5D RID: 27741
    [Range(0f, 100f)] public float nearDis = 2f;

    // Token: 0x04006C54 RID: 27732
    [Range(-10f, 10f)] public float thresholdAngleDifference;

    // Token: 0x04006C57 RID: 27735
    [Range(-100f, 0f)] public float upBendingAngle = -1f;

    // Token: 0x04006C5F RID: 27743
    [Range(0f, 180f)] public float vAngleLimit = 80f;
}