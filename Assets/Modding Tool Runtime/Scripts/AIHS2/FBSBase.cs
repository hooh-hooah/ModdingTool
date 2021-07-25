using System;
using System.Collections.Generic;
using AIProject;
using FBSAssist;
using UnityEngine;

// Token: 0x02001035 RID: 4149
[Serializable]
public class FBSBase
{
    // Token: 0x04006CF3 RID: 27891
    public FBSTargetInfo[] FBSTarget;

    // Token: 0x04006CF9 RID: 27897
    [Range(-0.1f, 1f)] public float FixedRate = -0.1f;

    // Token: 0x04006CF8 RID: 27896
    [Range(0f, 1f)] public float OpenMax = 1f;

    // Token: 0x04006CF7 RID: 27895
    [Range(0f, 1f)] public float OpenMin;

    // Token: 0x04006CFB RID: 27899
    protected TimeProgressCtrl blendTimeCtrl;

    // Token: 0x04006CFA RID: 27898
    private float correctOpenMax = -1f;

    // Token: 0x04006CF4 RID: 27892
    protected Dictionary<int, float> dictBackFace = new Dictionary<int, float>();

    // Token: 0x04006CF5 RID: 27893
    protected Dictionary<int, float> dictNowFace = new Dictionary<int, float>();

    // Token: 0x04006CF6 RID: 27894
    protected float openRate;

    // Token: 0x06008673 RID: 34419 RVA: 0x0034A02C File Offset: 0x0034842C
    public bool Init()
    {
        blendTimeCtrl = new TimeProgressCtrl();
        blendTimeCtrl.End();
        for (var i = 0; i < FBSTarget.Length; i++) FBSTarget[i].SetSkinnedMeshRenderer();
        dictBackFace.Clear();
        dictBackFace[0] = 1f;
        dictNowFace.Clear();
        dictNowFace[0] = 1f;
        return true;
    }

    // Token: 0x06008674 RID: 34420 RVA: 0x0034A0B3 File Offset: 0x003484B3
    public void SetOpenRateForce(float rate)
    {
        openRate = rate;
    }

    // Token: 0x06008675 RID: 34421 RVA: 0x0034A0BC File Offset: 0x003484BC
    public int GetMaxPtn()
    {
        if (FBSTarget.Length == 0) return 0;
        return FBSTarget[0].PtnSet.Length;
    }

    // Token: 0x06008676 RID: 34422 RVA: 0x0034A0DC File Offset: 0x003484DC
    public void ChangePtn(int ptn, bool blend)
    {
        if (GetMaxPtn() <= ptn) return;
        if (dictNowFace.Count == 1 && dictNowFace.ContainsKey(ptn) && dictNowFace[ptn] == 1f) return;
        var dictionary = new Dictionary<int, float>();
        dictionary[ptn] = 1f;
        ChangeFace(dictionary, blend);
    }

    // Token: 0x06008677 RID: 34423 RVA: 0x0034A14C File Offset: 0x0034854C
    public void ChangeFace(Dictionary<int, float> dictFace, bool blend)
    {
        var flag = false;
        byte b = 0;
        var num = 0f;
        foreach (var fbstargetInfo in FBSTarget)
        {
            var skinnedMeshRenderer = fbstargetInfo.GetSkinnedMeshRenderer();
            foreach (var num2 in dictFace.Keys)
            {
                if (skinnedMeshRenderer.sharedMesh.blendShapeCount <= fbstargetInfo.PtnSet[num2].Close)
                {
                    b = 1;
                    break;
                }

                if (skinnedMeshRenderer.sharedMesh.blendShapeCount <= fbstargetInfo.PtnSet[num2].Open)
                {
                    b = 1;
                    break;
                }

                num += dictFace[num2];
            }

            if (b != 0) break;
            if (!flag && num > 1f)
            {
                b = 2;
                break;
            }

            flag = true;
        }

        if (b == 1) return;
        if (b == 2) return;
        dictBackFace.Clear();
        foreach (var key in dictNowFace.Keys) dictBackFace[key] = dictNowFace[key];
        dictNowFace.Clear();
        foreach (var key2 in dictFace.Keys) dictNowFace[key2] = dictFace[key2];
        if (!blend)
            blendTimeCtrl.End();
        else
            blendTimeCtrl.Start();
    }

    // Token: 0x06008678 RID: 34424 RVA: 0x0034A360 File Offset: 0x00348760
    public void SetFixedRate(float value)
    {
        FixedRate = value;
    }

    // Token: 0x06008679 RID: 34425 RVA: 0x0034A369 File Offset: 0x00348769
    public void SetCorrectOpenMax(float value)
    {
        correctOpenMax = value;
    }

    // Token: 0x0600867A RID: 34426 RVA: 0x0034A374 File Offset: 0x00348774
    public void CalculateBlendShape()
    {
        if (FBSTarget.Length == 0) return;
        var b = correctOpenMax >= 0f ? correctOpenMax : OpenMax;
        var num = Mathf.Lerp(OpenMin, b, openRate);
        if (0f <= FixedRate) num = FixedRate;
        var num2 = 0f;
        if (blendTimeCtrl != null) num2 = blendTimeCtrl.Calculate();
        foreach (var fbstargetInfo in FBSTarget)
        {
            var skinnedMeshRenderer = fbstargetInfo.GetSkinnedMeshRenderer();
            var dictionary = DictionaryPool<int, float>.Get();
            for (var j = 0; j < fbstargetInfo.PtnSet.Length; j++)
            {
                dictionary[fbstargetInfo.PtnSet[j].Close] = 0f;
                dictionary[fbstargetInfo.PtnSet[j].Open] = 0f;
            }

            var num3 = (int) Mathf.Clamp(num * 100f, 0f, 100f);
            if (num2 != 1f)
                foreach (var num4 in dictBackFace.Keys)
                {
                    dictionary[fbstargetInfo.PtnSet[num4].Close] = dictionary[fbstargetInfo.PtnSet[num4].Close] +
                                                                   dictBackFace[num4] * (100 - num3) * (1f - num2);
                    dictionary[fbstargetInfo.PtnSet[num4].Open] = dictionary[fbstargetInfo.PtnSet[num4].Open] +
                                                                  dictBackFace[num4] * num3 * (1f - num2);
                }

            foreach (var num5 in dictNowFace.Keys)
            {
                dictionary[fbstargetInfo.PtnSet[num5].Close] = dictionary[fbstargetInfo.PtnSet[num5].Close] +
                                                               dictNowFace[num5] * (100 - num3) * num2;
                dictionary[fbstargetInfo.PtnSet[num5].Open] =
                    dictionary[fbstargetInfo.PtnSet[num5].Open] + dictNowFace[num5] * num3 * num2;
            }

            foreach (var keyValuePair in dictionary)
                if (keyValuePair.Key != -1)
                    skinnedMeshRenderer.SetBlendShapeWeight(keyValuePair.Key, keyValuePair.Value);
            DictionaryPool<int, float>.Release(dictionary);
        }
    }
}