using System;

// Token: 0x0200103A RID: 4154
[Serializable]
public class FBSCtrlEyes : FBSBase
{
    // Token: 0x0600868C RID: 34444 RVA: 0x0034AA02 File Offset: 0x00348E02
    public void CalcBlend(float blinkRate)
    {
        if (0f <= blinkRate) openRate = blinkRate;
        CalculateBlendShape();
    }
}