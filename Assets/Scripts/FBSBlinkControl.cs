using System;
using UnityEngine;

// Token: 0x02001038 RID: 4152
[Serializable]
public class FBSBlinkControl
{
    // Token: 0x06008681 RID: 34433 RVA: 0x0034A730 File Offset: 0x00348B30
    public void SetFixedFlags(byte flags)
    {
        this.fixedFlags = flags;
    }

    // Token: 0x06008682 RID: 34434 RVA: 0x0034A739 File Offset: 0x00348B39
    public byte GetFixedFlags()
    {
        return this.fixedFlags;
    }

    // Token: 0x06008683 RID: 34435 RVA: 0x0034A744 File Offset: 0x00348B44
    public void SetFrequency(byte value)
    {
        this.BlinkFrequency = value;
        if ((int)this.blinkMode == 0)
        {
            int num = UnityEngine.Random.Range(0, (int)this.BlinkFrequency);
            float num2 = Mathf.InverseLerp(0f, (float)this.BlinkFrequency, (float)num);
            num2 = Mathf.Lerp(0f, (float)this.BlinkFrequency, num2);
            this.blinkTime = Time.time + 0.2f * num2;
        }
    }

    // Token: 0x06008684 RID: 34436 RVA: 0x0034A7AB File Offset: 0x00348BAB
    public void SetSpeed(float value)
    {
        this.BaseSpeed = Mathf.Max(1f, value);
    }

    // Token: 0x06008685 RID: 34437 RVA: 0x0034A7BE File Offset: 0x00348BBE
    public void SetForceOpen()
    {
        this.calcSpeed = this.BaseSpeed + UnityEngine.Random.Range(0f, 0.05f);
        this.blinkTime = Time.time + this.calcSpeed;
        this.blinkMode = -1;
    }

    // Token: 0x06008686 RID: 34438 RVA: 0x0034A7F8 File Offset: 0x00348BF8
    public void SetForceClose()
    {
        this.calcSpeed = this.BaseSpeed + UnityEngine.Random.Range(0f, 0.05f);
        this.blinkTime = Time.time + this.calcSpeed;
        this.count = UnityEngine.Random.Range(0, 3) + 1;
        this.blinkMode = 1;
    }

    // Token: 0x06008687 RID: 34439 RVA: 0x0034A84C File Offset: 0x00348C4C
    public void CalcBlink()
    {
        float num = Mathf.Max(0f, this.blinkTime - Time.time);
        sbyte b = this.blinkMode;
        float num2;
        switch (b + 1)
        {
            case 1:
                num2 = 1f;
                goto IL_88;
            case 2:
                num2 = Mathf.Clamp(num / this.calcSpeed, 0f, 1f);
                goto IL_88;
        }
        num2 = Mathf.Clamp(1f - num / this.calcSpeed, 0f, 1f);
    IL_88:
        if (this.fixedFlags == 0)
        {
            this.openRate = num2;
        }
        if (this.fixedFlags != 0)
        {
            return;
        }
        if (Time.time <= this.blinkTime)
        {
            return;
        }
        sbyte b2 = this.blinkMode;
        switch (b2 + 1)
        {
            case 0:
                {
                    int num3 = UnityEngine.Random.Range(0, (int)this.BlinkFrequency);
                    float num4 = Mathf.InverseLerp(0f, (float)this.BlinkFrequency, (float)num3);
                    num4 = Mathf.Lerp(0f, (float)this.BlinkFrequency, num4);
                    this.blinkTime = Time.time + 0.2f * num4;
                    this.blinkMode = 0;
                    break;
                }
            case 1:
                this.SetForceClose();
                break;
            case 2:
                this.count--;
                if (0 >= this.count)
                {
                    this.SetForceOpen();
                }
                break;
        }
    }

    // Token: 0x06008688 RID: 34440 RVA: 0x0034A9BE File Offset: 0x00348DBE
    public float GetOpenRate()
    {
        return this.openRate;
    }

    // Token: 0x04006D01 RID: 27905
    private byte fixedFlags;

    // Token: 0x04006D02 RID: 27906
    [Range(0f, 255f)]
    public byte BlinkFrequency = 30;

    // Token: 0x04006D03 RID: 27907
    private sbyte blinkMode;

    // Token: 0x04006D04 RID: 27908
    [Range(0f, 0.5f)]
    public float BaseSpeed = 0.15f;

    // Token: 0x04006D05 RID: 27909
    private float calcSpeed;

    // Token: 0x04006D06 RID: 27910
    private float blinkTime;

    // Token: 0x04006D07 RID: 27911
    private int count;

    // Token: 0x04006D08 RID: 27912
    private float openRate = 1f;
}