using System;

// Token: 0x02001039 RID: 4153
[Serializable]
public class FBSCtrlEyebrow : FBSBase
{
    // Token: 0x0600868A RID: 34442 RVA: 0x0034A9D5 File Offset: 0x00348DD5
    public void CalcBlend(float blinkRate)
    {
        if (0f <= blinkRate && this.SyncBlink)
        {
            this.openRate = blinkRate;
        }
        base.CalculateBlendShape();
    }

    // Token: 0x04006D09 RID: 27913
    public bool SyncBlink = true;
}