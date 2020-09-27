using System;
using UnityEngine;
using Random = UnityEngine.Random;

// Token: 0x02001038 RID: 4152
[Serializable]
public class FBSBlinkControl
{
    // Token: 0x04006D04 RID: 27908
    [Range(0f, 0.5f)] public float BaseSpeed = 0.15f;

    // Token: 0x04006D02 RID: 27906
    [Range(0f, 255f)] public byte BlinkFrequency = 30;

    // Token: 0x04006D03 RID: 27907
    private sbyte blinkMode;

    // Token: 0x04006D06 RID: 27910
    private float blinkTime;

    // Token: 0x04006D05 RID: 27909
    private float calcSpeed;

    // Token: 0x04006D07 RID: 27911
    private int count;

    // Token: 0x04006D01 RID: 27905
    private byte fixedFlags;

    // Token: 0x04006D08 RID: 27912
    private float openRate = 1f;

    // Token: 0x06008681 RID: 34433 RVA: 0x0034A730 File Offset: 0x00348B30
    public void SetFixedFlags(byte flags)
    {
        fixedFlags = flags;
    }

    // Token: 0x06008682 RID: 34434 RVA: 0x0034A739 File Offset: 0x00348B39
    public byte GetFixedFlags()
    {
        return fixedFlags;
    }

    // Token: 0x06008683 RID: 34435 RVA: 0x0034A744 File Offset: 0x00348B44
    public void SetFrequency(byte value)
    {
        BlinkFrequency = value;
        if (blinkMode == 0)
        {
            var num = Random.Range(0, BlinkFrequency);
            var num2 = Mathf.InverseLerp(0f, BlinkFrequency, num);
            num2 = Mathf.Lerp(0f, BlinkFrequency, num2);
            blinkTime = Time.time + 0.2f * num2;
        }
    }

    // Token: 0x06008684 RID: 34436 RVA: 0x0034A7AB File Offset: 0x00348BAB
    public void SetSpeed(float value)
    {
        BaseSpeed = Mathf.Max(1f, value);
    }

    // Token: 0x06008685 RID: 34437 RVA: 0x0034A7BE File Offset: 0x00348BBE
    public void SetForceOpen()
    {
        calcSpeed = BaseSpeed + Random.Range(0f, 0.05f);
        blinkTime = Time.time + calcSpeed;
        blinkMode = -1;
    }

    // Token: 0x06008686 RID: 34438 RVA: 0x0034A7F8 File Offset: 0x00348BF8
    public void SetForceClose()
    {
        calcSpeed = BaseSpeed + Random.Range(0f, 0.05f);
        blinkTime = Time.time + calcSpeed;
        count = Random.Range(0, 3) + 1;
        blinkMode = 1;
    }

    // Token: 0x06008687 RID: 34439 RVA: 0x0034A84C File Offset: 0x00348C4C
    public void CalcBlink()
    {
        var num = Mathf.Max(0f, blinkTime - Time.time);
        var b = blinkMode;
        float num2;
        switch (b + 1)
        {
            case 1:
                num2 = 1f;
                goto IL_88;
            case 2:
                num2 = Mathf.Clamp(num / calcSpeed, 0f, 1f);
                goto IL_88;
        }

        num2 = Mathf.Clamp(1f - num / calcSpeed, 0f, 1f);
        IL_88:
        if (fixedFlags == 0) openRate = num2;
        if (fixedFlags != 0) return;
        if (Time.time <= blinkTime) return;
        var b2 = blinkMode;
        switch (b2 + 1)
        {
            case 0:
            {
                var num3 = Random.Range(0, BlinkFrequency);
                var num4 = Mathf.InverseLerp(0f, BlinkFrequency, num3);
                num4 = Mathf.Lerp(0f, BlinkFrequency, num4);
                blinkTime = Time.time + 0.2f * num4;
                blinkMode = 0;
                break;
            }
            case 1:
                SetForceClose();
                break;
            case 2:
                count--;
                if (0 >= count) SetForceOpen();
                break;
        }
    }

    // Token: 0x06008688 RID: 34440 RVA: 0x0034A9BE File Offset: 0x00348DBE
    public float GetOpenRate()
    {
        return openRate;
    }
}