using System;
using UnityEngine;

// Token: 0x020010D1 RID: 4305
public static class MathfEx
{
    // Token: 0x06008AAA RID: 35498 RVA: 0x0035DBE7 File Offset: 0x0035BFE7
    public static float LerpAccel(float from, float to, float t)
    {
        return Mathf.Lerp(from, to, Mathf.Sqrt(t));
    }

    // Token: 0x06008AAB RID: 35499 RVA: 0x0035DBF6 File Offset: 0x0035BFF6
    public static bool IsRange<T>(T min, T n, T max, bool isEqual) where T : IComparable
    {
        return !isEqual ? RangeEqualOff(min, n, max) : RangeEqualOn(min, n, max);
    }

    // Token: 0x06008AAC RID: 35500 RVA: 0x0035DC13 File Offset: 0x0035C013
    public static bool RangeEqualOn<T>(T min, T n, T max) where T : IComparable
    {
        return n.CompareTo(max) <= 0 && n.CompareTo(min) >= 0;
    }

    // Token: 0x06008AAD RID: 35501 RVA: 0x0035DC4A File Offset: 0x0035C04A
    public static bool RangeEqualOff<T>(T min, T n, T max) where T : IComparable
    {
        return n.CompareTo(max) < 0 && n.CompareTo(min) > 0;
    }

    // Token: 0x06008AAE RID: 35502 RVA: 0x0035DC7E File Offset: 0x0035C07E
    public static float LerpBrake(float from, float to, float t)
    {
        return Mathf.Lerp(from, to, t * (2f - t));
    }

    // Token: 0x06008AAF RID: 35503 RVA: 0x0035DC90 File Offset: 0x0035C090
    public static int LoopValue(ref int value, int start, int end)
    {
        if (value > end)
            value = start;
        else if (value < start) value = end;
        return value;
    }

    // Token: 0x06008AB0 RID: 35504 RVA: 0x0035DCAF File Offset: 0x0035C0AF
    public static int LoopValue(int value, int start, int end)
    {
        return LoopValue(ref value, start, end);
    }

    // Token: 0x06008AB1 RID: 35505 RVA: 0x0035DCBC File Offset: 0x0035C0BC
    public static Rect AspectRect(float baseH = 1280f, float rate = 720f)
    {
        var y = (Screen.height - Screen.width / baseH * rate) * 0.5f / Screen.height;
        var height = rate * Screen.width / baseH / Screen.height;
        return new Rect(0f, y, 1f, height);
    }

    // Token: 0x06008AB2 RID: 35506 RVA: 0x0035DD0B File Offset: 0x0035C10B
    public static long Min(long _a, long _b)
    {
        return _a <= _b ? _a : _b;
    }

    // Token: 0x06008AB3 RID: 35507 RVA: 0x0035DD1B File Offset: 0x0035C11B
    public static long Max(long _a, long _b)
    {
        return _a <= _b ? _b : _a;
    }

    // Token: 0x06008AB4 RID: 35508 RVA: 0x0035DD2B File Offset: 0x0035C12B
    public static long Clamp(long _value, long _min, long _max)
    {
        return Min(Max(_value, _min), _max);
    }

    // Token: 0x06008AB5 RID: 35509 RVA: 0x0035DD3A File Offset: 0x0035C13A
    public static float ToRadian(float degree)
    {
        return degree * 0.0174532924f;
    }

    // Token: 0x06008AB6 RID: 35510 RVA: 0x0035DD43 File Offset: 0x0035C143
    public static float ToDegree(float radian)
    {
        return radian * 57.29578f;
    }

    // Token: 0x06008AB7 RID: 35511 RVA: 0x0035DD4C File Offset: 0x0035C14C
    public static Vector3 GetShapeLerpPositionValue(float shape, Vector3 min, Vector3 max)
    {
        return shape < 0.5f ? Vector3.Lerp(min, Vector3.zero, Mathf.InverseLerp(0f, 0.5f, shape)) : Vector3.Lerp(Vector3.zero, max, Mathf.InverseLerp(0.5f, 1f, shape));
    }

    // Token: 0x06008AB8 RID: 35512 RVA: 0x0035DDA0 File Offset: 0x0035C1A0
    public static Vector3 GetShapeLerpAngleValue(float shape, Vector3 min, Vector3 max)
    {
        var zero = Vector3.zero;
        if (shape >= 0.5f)
        {
            var t = Mathf.InverseLerp(0.5f, 1f, shape);
            for (var i = 0; i < 3; i++) zero[i] = Mathf.LerpAngle(0f, max[i], t);
        }
        else
        {
            var t2 = Mathf.InverseLerp(0f, 0.5f, shape);
            for (var j = 0; j < 3; j++) zero[j] = Mathf.LerpAngle(min[j], 0f, t2);
        }

        return zero;
    }
}