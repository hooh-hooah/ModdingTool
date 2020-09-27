using UnityEngine;

// Token: 0x0200103C RID: 4156
public class FaceBlendShape : MonoBehaviour
{
    // Token: 0x04006D17 RID: 27927
    public FBSBlinkControl BlinkCtrl;

    // Token: 0x04006D18 RID: 27928
    public FBSCtrlEyebrow EyebrowCtrl;

    // Token: 0x04006D1C RID: 27932
    public EyeLookController EyeLookController;

    // Token: 0x04006D1E RID: 27934
    [Range(0f, 1f)] public float EyeLookDownCorrect = 0.3f;

    // Token: 0x04006D1F RID: 27935
    [Range(0f, 1f)] public float EyeLookSideCorrect = 0.1f;

    // Token: 0x04006D1D RID: 27933
    [Range(0f, 1f)] public float EyeLookUpCorrect = 0.1f;

    // Token: 0x04006D19 RID: 27929
    public FBSCtrlEyes EyesCtrl;

    // Token: 0x04006D1A RID: 27930
    public FBSCtrlMouth MouthCtrl;

    // Token: 0x04006D16 RID: 27926
    private FBSBlinkControl BlinkCtrlEx;

    // Token: 0x04006D1B RID: 27931
    private float voiceValue;

    // Token: 0x06008694 RID: 34452 RVA: 0x0034AC1F File Offset: 0x0034901F
    private void Awake()
    {
        EyebrowCtrl.Init();
        EyesCtrl.Init();
        MouthCtrl.Init();
    }

    // Token: 0x06008696 RID: 34454 RVA: 0x0034AC4D File Offset: 0x0034904D
    private void Start()
    {
    }

    // Token: 0x06008695 RID: 34453 RVA: 0x0034AC44 File Offset: 0x00349044
    public void SetBlinkControlEx(FBSBlinkControl ctrl)
    {
        BlinkCtrlEx = ctrl;
    }

    // Token: 0x06008697 RID: 34455 RVA: 0x0034AC84 File Offset: 0x00349084
    private void OnLateUpdate()
    {
        BlinkCtrl.CalcBlink();
        var fbsblinkControl = BlinkCtrl;
        if (BlinkCtrlEx != null) fbsblinkControl = BlinkCtrlEx;
        float blinkRate;
        if (fbsblinkControl.GetFixedFlags() == 0)
        {
            blinkRate = fbsblinkControl.GetOpenRate();
            if (EyeLookController)
            {
                var angleHRate = EyeLookController.eyeLookScript.GetAngleHRate(EYE_LR.EYE_L);
                var angleVRate = EyeLookController.eyeLookScript.GetAngleVRate();
                var min = -Mathf.Max(EyeLookDownCorrect, EyeLookSideCorrect);
                var num = 1f - EyeLookUpCorrect;
                if (num > EyesCtrl.OpenMax) num = EyesCtrl.OpenMax;
                float num2;
                if (angleVRate > 0f)
                    num2 = MathfEx.LerpAccel(0f, EyeLookUpCorrect, angleVRate);
                else
                    num2 = -MathfEx.LerpAccel(0f, EyeLookDownCorrect, -angleVRate);
                if (angleHRate > 0f)
                    num2 -= MathfEx.LerpAccel(0f, EyeLookSideCorrect, angleHRate);
                else
                    num2 -= MathfEx.LerpAccel(0f, EyeLookSideCorrect, -angleHRate);
                num2 = Mathf.Clamp(num2, min, EyeLookUpCorrect);
                num2 *= 1f - (1f - EyesCtrl.OpenMax);
                EyesCtrl.SetCorrectOpenMax(num + num2);
            }
        }
        else
        {
            blinkRate = -1f;
        }

        EyebrowCtrl.CalcBlend(blinkRate);
        EyesCtrl.CalcBlend(blinkRate);
        MouthCtrl.CalcBlend(voiceValue);
    }

    // Token: 0x06008698 RID: 34456 RVA: 0x0034AE2E File Offset: 0x0034922E
    public void SetVoiceVaule(float value)
    {
        voiceValue = value;
    }
}