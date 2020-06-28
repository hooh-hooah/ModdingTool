using System;
using UnityEngine;

namespace FBSAssist
{
    // Token: 0x02001033 RID: 4147
    public class TimeProgressCtrlRandom : TimeProgressCtrl
    {
        // Token: 0x0600866B RID: 34411 RVA: 0x00349E0A File Offset: 0x0034820A
        public TimeProgressCtrlRandom() : base(0.15f)
        {
        }

        // Token: 0x0600866C RID: 34412 RVA: 0x00349E2D File Offset: 0x0034822D
        public void Init(float min, float max)
        {
            this.minTime = min;
            this.maxTime = max;
            base.SetProgressTime(UnityEngine.Random.Range(this.minTime, this.maxTime));
            base.Start();
        }

        // Token: 0x0600866D RID: 34413 RVA: 0x00349E5C File Offset: 0x0034825C
        public new float Calculate()
        {
            float num = base.Calculate();
            if (num == 1f)
            {
                base.SetProgressTime(UnityEngine.Random.Range(this.minTime, this.maxTime));
                base.Start();
            }
            return num;
        }

        // Token: 0x0600866E RID: 34414 RVA: 0x00349E99 File Offset: 0x00348299
        public float Calculate(float _minTime, float _maxTime)
        {
            this.minTime = _minTime;
            this.maxTime = _maxTime;
            return this.Calculate();
        }

        // Token: 0x04006CEF RID: 27887
        private float minTime = 0.1f;

        // Token: 0x04006CF0 RID: 27888
        private float maxTime = 0.2f;
    }
}
