using System;
using UnityEngine;

// Token: 0x02001022 RID: 4130
[Serializable]
public class EyeObject
{
    // Token: 0x04006C4D RID: 27725
    public EYE_LR eyeLR;

    // Token: 0x04006C4C RID: 27724
    public Transform eyeTransform;

    // Token: 0x04006C4E RID: 27726
    internal float angleH;

    // Token: 0x04006C4F RID: 27727
    internal float angleV;

    // Token: 0x04006C50 RID: 27728
    internal Vector3 dirUp;

    // Token: 0x04006C53 RID: 27731
    internal Quaternion origRotation;

    // Token: 0x04006C51 RID: 27729
    internal Vector3 referenceLookDir;

    // Token: 0x04006C52 RID: 27730
    internal Vector3 referenceUpDir;
}