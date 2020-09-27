using System;
using FBSAssist;
using UnityEngine;
using Random = UnityEngine.Random;

// Token: 0x0200103B RID: 4155
[Serializable]
public class FBSCtrlMouth : FBSBase
{
    // Token: 0x04006D0C RID: 27916
    public GameObject objAdjustWidthScale;

    // Token: 0x04006D11 RID: 27921
    [Range(0f, 1f)] public float openRefValue = 0.2f;

    // Token: 0x04006D10 RID: 27920
    [Range(0.1f, 2f)] public float randScaleMax = 1f;

    // Token: 0x04006D0F RID: 27919
    [Range(0.1f, 2f)] public float randScaleMin = 0.65f;

    // Token: 0x04006D0E RID: 27918
    [Range(0.01f, 1f)] public float randTimeMax = 0.2f;

    // Token: 0x04006D0D RID: 27917
    [Range(0.01f, 1f)] public float randTimeMin = 0.1f;

    // Token: 0x04006D0A RID: 27914
    public bool useAjustWidthScale;

    // Token: 0x04006D15 RID: 27925
    private float adjustWidthScale = 1f;

    // Token: 0x04006D14 RID: 27924
    private float sclEnd = 1f;

    // Token: 0x04006D12 RID: 27922
    private float sclNow = 1f;

    // Token: 0x04006D13 RID: 27923
    private float sclStart = 1f;

    // Token: 0x04006D0B RID: 27915
    private TimeProgressCtrlRandom tpcRand;

    // Token: 0x0600868E RID: 34446 RVA: 0x0034AA92 File Offset: 0x00348E92
    public float GetAdjustWidthScale()
    {
        return adjustWidthScale;
    }

    // Token: 0x0600868F RID: 34447 RVA: 0x0034AA9A File Offset: 0x00348E9A
    public new void Init()
    {
        base.Init();
        tpcRand = new TimeProgressCtrlRandom();
        tpcRand.Init(randTimeMin, randTimeMax);
    }

    // Token: 0x06008690 RID: 34448 RVA: 0x0034AAC5 File Offset: 0x00348EC5
    public void CalcBlend(float openValue)
    {
        openRate = openValue;
        CalculateBlendShape();
        if (useAjustWidthScale) AdjustWidthScale();
    }

    // Token: 0x06008691 RID: 34449 RVA: 0x0034AAE6 File Offset: 0x00348EE6
    public void UseAdjustWidthScale(bool useFlags)
    {
        useAjustWidthScale = useFlags;
    }

    // Token: 0x06008692 RID: 34450 RVA: 0x0034AAF0 File Offset: 0x00348EF0
    public bool AdjustWidthScale()
    {
        adjustWidthScale = 1f;
        var flag = false;
        var num = tpcRand.Calculate(randTimeMin, randTimeMax);
        if (num == 1f)
        {
            sclStart = sclNow = sclEnd;
            sclEnd = Random.Range(randScaleMin, randScaleMax);
            flag = true;
        }

        if (flag) num = 0f;
        sclNow = Mathf.Lerp(sclStart, sclEnd, num);
        sclNow = Mathf.Max(0f, sclNow - openRefValue * openRate);
        if (0.2f < openRate) adjustWidthScale = sclNow;
        if (null != objAdjustWidthScale) objAdjustWidthScale.transform.localScale = new Vector3(adjustWidthScale, 1f, 1f);
        return true;
    }
}