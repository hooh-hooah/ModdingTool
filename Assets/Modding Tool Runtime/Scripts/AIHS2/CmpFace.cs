using System;
using UnityEngine;

namespace AIChara
{
    // Token: 0x020007C2 RID: 1986
    [DisallowMultipleComponent]
    public class CmpFace : CmpBase
    {
        // Token: 0x04002F5F RID: 12127
        [Header("Custom use")] public TargetCustom targetCustom = new TargetCustom();

        // Token: 0x04002F60 RID: 12128
        [Header("Other")] public TargetEtc targetEtc = new TargetEtc();

        // Token: 0x06003108 RID: 12552 RVA: 0x00120DE1 File Offset: 0x0011F1E1
        public CmpFace() : base(false)
        {
        }
#if UNITY_EDITOR
        // Token: 0x06003109 RID: 12553 RVA: 0x00120E00 File Offset: 0x0011F200
        public override void SetReferenceObject()
        {
            var findAssist = new FindAssist(transform);
            targetCustom.rendEyes = new Renderer[2];
            var objectFromName = findAssist.GetObjectFromName("o_eyebase_L");
            if (objectFromName) targetCustom.rendEyes[0] = objectFromName.GetComponent<Renderer>();
            objectFromName = findAssist.GetObjectFromName("o_eyebase_R");
            if (objectFromName) targetCustom.rendEyes[1] = objectFromName.GetComponent<Renderer>();
            objectFromName = findAssist.GetObjectFromName("o_eyelashes");
            if (objectFromName) targetCustom.rendEyelashes = objectFromName.GetComponent<Renderer>();
            objectFromName = findAssist.GetObjectFromName("o_eyeshadow");
            if (objectFromName) targetCustom.rendShadow = objectFromName.GetComponent<Renderer>();
            objectFromName = findAssist.GetObjectFromName("o_head");
            if (objectFromName) targetCustom.rendHead = objectFromName.GetComponent<Renderer>();
            objectFromName = findAssist.GetObjectFromName("o_namida");
            if (objectFromName) targetEtc.rendTears = objectFromName.GetComponent<Renderer>();
            targetEtc.objTongue = findAssist.GetObjectFromName("o_tang");
        }
#endif

        [Serializable]
        public class TargetCustom
        {
            public Renderer rendEyelashes;

            public Renderer[] rendEyes;

            public Renderer rendHead;

            public Renderer rendShadow;
        }

        [Serializable]
        public class TargetEtc
        {
            public GameObject objTongue;

            public Renderer rendTears;
        }
    }
}