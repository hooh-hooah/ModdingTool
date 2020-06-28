using System;
using UnityEngine;

namespace AIChara
{
    // Token: 0x020007C2 RID: 1986
    [DisallowMultipleComponent]
    public class CmpFace : CmpBase
    {
        // Token: 0x06003108 RID: 12552 RVA: 0x00120DE1 File Offset: 0x0011F1E1
        public CmpFace() : base(false)
        {
        }

        // Token: 0x06003109 RID: 12553 RVA: 0x00120E00 File Offset: 0x0011F200
        public override void SetReferenceObject()
        {
            FindAssist findAssist = new FindAssist();
            findAssist.Initialize(base.transform);
            this.targetCustom.rendEyes = new Renderer[2];
            GameObject objectFromName = findAssist.GetObjectFromName("o_eyebase_L");
            if (objectFromName)
            {
                this.targetCustom.rendEyes[0] = objectFromName.GetComponent<Renderer>();
            }
            objectFromName = findAssist.GetObjectFromName("o_eyebase_R");
            if (objectFromName)
            {
                this.targetCustom.rendEyes[1] = objectFromName.GetComponent<Renderer>();
            }
            objectFromName = findAssist.GetObjectFromName("o_eyelashes");
            if (objectFromName)
            {
                this.targetCustom.rendEyelashes = objectFromName.GetComponent<Renderer>();
            }
            objectFromName = findAssist.GetObjectFromName("o_eyeshadow");
            if (objectFromName)
            {
                this.targetCustom.rendShadow = objectFromName.GetComponent<Renderer>();
            }
            objectFromName = findAssist.GetObjectFromName("o_head");
            if (objectFromName)
            {
                this.targetCustom.rendHead = objectFromName.GetComponent<Renderer>();
            }
            objectFromName = findAssist.GetObjectFromName("o_namida");
            if (objectFromName)
            {
                this.targetEtc.rendTears = objectFromName.GetComponent<Renderer>();
            }
            this.targetEtc.objTongue = findAssist.GetObjectFromName("o_tang");
        }

        // Token: 0x04002F5F RID: 12127
        [Header("Custom use")]
        public CmpFace.TargetCustom targetCustom = new CmpFace.TargetCustom();

        // Token: 0x04002F60 RID: 12128
        [Header("Other")]
        public CmpFace.TargetEtc targetEtc = new CmpFace.TargetEtc();

        // Token: 0x020007C3 RID: 1987
        [Serializable]
        public class TargetCustom
        {
            // Token: 0x04002F61 RID: 12129
            public Renderer[] rendEyes;

            // Token: 0x04002F62 RID: 12130
            public Renderer rendEyelashes;

            // Token: 0x04002F63 RID: 12131
            public Renderer rendShadow;

            // Token: 0x04002F64 RID: 12132
            public Renderer rendHead;
        }

        // Token: 0x020007C4 RID: 1988
        [Serializable]
        public class TargetEtc
        {
            // Token: 0x04002F65 RID: 12133
            public Renderer rendTears;

            // Token: 0x04002F66 RID: 12134
            public GameObject objTongue;
        }
    }
}