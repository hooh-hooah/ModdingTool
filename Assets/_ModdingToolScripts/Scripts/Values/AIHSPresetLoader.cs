using System.Collections.Generic;
using UnityEngine;

public struct TransformPreset
{
    public Vector3 localPosition;
    public Vector3 localEulerAngle;
    public Vector3 localScale;

    public TransformPreset(Vector3 localPosition, Vector3 localEulerAngle, Vector3 localScale)
    {
        this.localPosition = localPosition;
        this.localEulerAngle = localEulerAngle;
        this.localScale = localScale;
    }
}

public struct AIHSBodyPreset
{
    public string name;
    public Dictionary<string, TransformPreset> transformPresets;

    public AIHSBodyPreset(string name, Dictionary<string, TransformPreset> transformPresets)
    {
        this.name = name;
        this.transformPresets = transformPresets;
    }
}

public class AIHSPresetLoader
{
    public static AIHSBodyPreset[] presets =
    {
        new AIHSBodyPreset("Body 01", new Dictionary<string, TransformPreset>
        {
            {
                "cf_J_Hips",
                new TransformPreset(new Vector3(0.1f, 11.2f, -0.1f), new Vector3(359.5f, 359.9f, 5.1f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Kosi01",
                new TransformPreset(new Vector3(0.0f, -0.1f, 0.0f), new Vector3(0.1f, 0.5f, 359.5f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Kosi01_s",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.1f, 1.0f, 1.0f))
            },
            {
                "cf_J_Kosi02",
                new TransformPreset(new Vector3(0.0f, -1.0f, -0.2f), new Vector3(359.8f, 0.5f, 359.2f), new Vector3(1.1f, 1.0f, 1.1f))
            },
            {
                "cf_J_Kosi02_s",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.2f, 1.0f, 1.0f))
            },
            {
                "cf_J_Ana",
                new TransformPreset(new Vector3(0.0f, -0.9f, -0.4f), new Vector3(26.1f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Kokan",
                new TransformPreset(new Vector3(0.0f, -0.8f, 0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Kosi03",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.6f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Kosi03_s",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegUp00_L",
                new TransformPreset(new Vector3(-0.9f, -0.5f, -0.1f), new Vector3(350.4f, 18.4f, 354.2f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegKnee_dam_L",
                new TransformPreset(new Vector3(0.0f, -4.1f, 0.3f), new Vector3(9.9f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegKnee_low_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegLow01_L",
                new TransformPreset(new Vector3(0.0f, -4.2f, 0.0f), new Vector3(26.7f, 360.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegLow01_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.1f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegLow03_L",
                new TransformPreset(new Vector3(0.0f, -4.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegLow03_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.9f, 1.0f, 0.9f))
            },
            {
                "cf_J_LegLowRoll_L",
                new TransformPreset(new Vector3(0.0f, -2.3f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Foot01_L",
                new TransformPreset(new Vector3(0.0f, -2.4f, 0.0f), new Vector3(354.6f, 349.3f, 4.1f), new Vector3(1.0f, 1.0f, 0.9f))
            },
            {
                "cf_J_Foot02_L",
                new TransformPreset(new Vector3(0.0f, -0.5f, 0.0f), new Vector3(351.2f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Toes01_L",
                new TransformPreset(new Vector3(0.0f, -0.2f, 1.1f), new Vector3(359.6f, 3.5f, 0.9f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegLow02_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegUp01_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 345.2f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegUp01_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.1f), new Vector3(1.2f, 1.0f, 1.1f))
            },
            {
                "cf_J_LegUp02_L",
                new TransformPreset(new Vector3(0.0f, -2.0f, 0.0f), new Vector3(0.0f, 351.4f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegUp02_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.2f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegUp03_L",
                new TransformPreset(new Vector3(0.0f, -3.4f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegUp03_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegKnee_back_L",
                new TransformPreset(new Vector3(0.0f, 0.5f, 0.0f), new Vector3(19.8f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegKnee_back_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.9f, 1.0f, 0.9f))
            },
            {
                "cf_J_LegUp00_R",
                new TransformPreset(new Vector3(0.9f, -0.5f, -0.1f), new Vector3(350.4f, 355.2f, 355.2f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegKnee_dam_R",
                new TransformPreset(new Vector3(0.0f, -4.1f, 0.3f), new Vector3(6.2f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegKnee_low_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegLow01_R",
                new TransformPreset(new Vector3(0.0f, -4.2f, 0.0f), new Vector3(19.3f, 359.9f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegLow01_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.1f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegLow03_R",
                new TransformPreset(new Vector3(0.0f, -4.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegLow03_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.9f, 1.0f, 0.9f))
            },
            {
                "cf_J_LegLowRoll_R",
                new TransformPreset(new Vector3(0.0f, -2.3f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Foot01_R",
                new TransformPreset(new Vector3(0.0f, -2.4f, 0.0f), new Vector3(355.5f, 352.6f, 4.9f), new Vector3(1.0f, 1.0f, 0.9f))
            },
            {
                "cf_J_Foot02_R",
                new TransformPreset(new Vector3(0.0f, -0.5f, 0.0f), new Vector3(355.4f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Toes01_R",
                new TransformPreset(new Vector3(0.0f, -0.2f, 1.1f), new Vector3(359.9f, 0.4f, 357.1f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegLow02_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegUp01_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(359.8f, 3.6f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegUp01_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 359.9f), new Vector3(1.2f, 1.0f, 1.1f))
            },
            {
                "cf_J_LegUp02_R",
                new TransformPreset(new Vector3(0.0f, -2.0f, 0.0f), new Vector3(359.8f, 2.7f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegUp02_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.2f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegUp03_R",
                new TransformPreset(new Vector3(0.0f, -3.4f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegUp03_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegKnee_back_R",
                new TransformPreset(new Vector3(0.0f, 0.5f, 0.0f), new Vector3(12.4f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegKnee_back_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.9f, 1.0f, 0.9f))
            },
            {
                "cf_J_SiriDam_L",
                new TransformPreset(new Vector3(-0.9f, -0.2f, -0.1f), new Vector3(356.9f, 3.5f, 358.5f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_SiriDam01_L_00",
                new TransformPreset(new Vector3(0.0f, 0.0f, -0.4f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_SiriDam01_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, -0.4f), new Vector3(0.1f, 360.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Siri_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Siri_s_L",
                new TransformPreset(new Vector3(0.0f, 0.1f, -0.5f), new Vector3(2.5f, 0.0f, 0.0f), new Vector3(1.3f, 1.3f, 1.4f))
            },
            {
                "cf_J_Siriopen_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_SiriDam_R",
                new TransformPreset(new Vector3(0.9f, -0.2f, -0.1f), new Vector3(356.7f, 359.1f, 358.8f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_SiriDam01_R_00",
                new TransformPreset(new Vector3(0.0f, 0.0f, -0.4f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_SiriDam01_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, -0.4f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Siri_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Siri_s_R",
                new TransformPreset(new Vector3(0.0f, 0.1f, -0.5f), new Vector3(2.5f, 0.0f, 0.0f), new Vector3(1.3f, 1.3f, 1.4f))
            },
            {
                "cf_J_Siriopen_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegUpDam_L",
                new TransformPreset(new Vector3(-0.9f, 0.0f, -0.3f), new Vector3(353.1f, 0.2f, 356.7f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegUpDam_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.4f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegUpDam_R",
                new TransformPreset(new Vector3(0.9f, 0.0f, -0.3f), new Vector3(354.6f, 0.2f, 355.3f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_LegUpDam_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.4f, 1.0f, 1.0f))
            },
            {
                "cf_J_Spine01",
                new TransformPreset(new Vector3(0.0f, 0.2f, 0.0f), new Vector3(359.9f, 0.0f, 358.3f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Spine01_s",
                new TransformPreset(new Vector3(0.0f, 0.1f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.1f))
            },
            {
                "cf_J_Spine02",
                new TransformPreset(new Vector3(0.0f, 0.7f, 0.0f), new Vector3(2.3f, 0.5f, 357.4f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Spine02_s",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Spine03",
                new TransformPreset(new Vector3(0.0f, 1.1f, -0.1f), new Vector3(2.4f, 0.5f, 357.4f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune00",
                new TransformPreset(new Vector3(0.0f, -0.3f, 0.0f), new Vector3(358.9f, 359.8f, 0.9f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune00_t_L",
                new TransformPreset(new Vector3(-0.4f, 0.0f, 0.0f), new Vector3(350.1f, 341.0f, 0.0f), new Vector3(1.1f, 1.1f, 1.1f))
            },
            {
                "cf_J_Mune00_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune00_L_00",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune00_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune00_d_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.7f), new Vector3(356.7f, 359.5f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune01_L_00",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune01_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune01_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(2.2f, 359.7f, 0.0f), new Vector3(1.1f, 1.1f, 1.1f))
            },
            {
                "cf_J_Mune01_t_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.3f), new Vector3(350.1f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune02_L_00",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune02_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.4f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune02_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(356.2f, 0.0f, 0.0f), new Vector3(1.1f, 1.1f, 1.1f))
            },
            {
                "cf_J_Mune02_t_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.3f), new Vector3(350.1f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune03_L_00",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune03_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune03_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 0.7f))
            },
            {
                "cf_J_Mune04_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune_Nip01_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune_Nip01_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.1f, 1.1f, 1.0f))
            },
            {
                "cf_J_Mune_Nip02_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune_Nip02_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.1f, 1.1f, 1.1f))
            },
            {
                "cf_J_Mune_Nipacs01_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.8f, 0.8f, 1.0f))
            },
            {
                "cf_J_Mune00_t_R",
                new TransformPreset(new Vector3(0.4f, 0.0f, 0.0f), new Vector3(350.1f, 19.0f, 0.0f), new Vector3(1.1f, 1.1f, 1.1f))
            },
            {
                "cf_J_Mune00_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune00_R_00",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune00_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune00_d_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.7f), new Vector3(356.7f, 0.5f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune01_R_00",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune01_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 360.0f, 360.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune01_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(2.2f, 0.3f, 0.0f), new Vector3(1.1f, 1.1f, 1.1f))
            },
            {
                "cf_J_Mune01_t_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.3f), new Vector3(350.1f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune02_R_00",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune02_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.4f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune02_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(356.2f, 0.0f, 0.0f), new Vector3(1.1f, 1.1f, 1.1f))
            },
            {
                "cf_J_Mune02_t_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.3f), new Vector3(350.1f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune03_R_00",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune03_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune03_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 0.7f))
            },
            {
                "cf_J_Mune04_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune_Nip01_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune_Nip01_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.1f, 1.1f, 1.0f))
            },
            {
                "cf_J_Mune_Nip02_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mune_Nip02_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.1f, 1.1f, 1.1f))
            },
            {
                "cf_J_Mune_Nipacs01_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.8f, 0.8f, 1.0f))
            },
            {
                "cf_J_Neck",
                new TransformPreset(new Vector3(0.0f, 1.4f, -0.2f), new Vector3(358.6f, 360.0f, 0.4f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Head",
                new TransformPreset(new Vector3(0.0f, 0.8f, 0.1f), new Vector3(359.3f, 359.6f, 0.8f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Head_s",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_FaceRoot",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_FaceBase",
                new TransformPreset(new Vector3(0.0f, 0.2f, 0.1f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_FaceLowBase",
                new TransformPreset(new Vector3(0.0f, -0.1f, 0.4f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_FaceLow_s",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_CheekLow_L",
                new TransformPreset(new Vector3(-0.4f, 0.1f, 0.1f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.9f, 1.6f, 0.9f))
            },
            {
                "cf_J_CheekLow_R",
                new TransformPreset(new Vector3(0.4f, 0.1f, 0.1f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.9f, 1.6f, 0.9f))
            },
            {
                "cf_J_CheekUp_L",
                new TransformPreset(new Vector3(-0.3f, 0.4f, 0.1f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.2f, 1.0f))
            },
            {
                "cf_J_CheekUp_R",
                new TransformPreset(new Vector3(0.3f, 0.4f, 0.1f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.2f, 1.0f))
            },
            {
                "cf_J_Chin_rs",
                new TransformPreset(new Vector3(0.0f, -0.2f, 0.3f), new Vector3(2.4f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_ChinTip_s",
                new TransformPreset(new Vector3(0.0f, -0.1f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.8f, 0.6f, 0.9f))
            },
            {
                "cf_J_ChinLow",
                new TransformPreset(new Vector3(0.0f, -0.2f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_MouthBase_tr",
                new TransformPreset(new Vector3(0.0f, -0.1f, 0.4f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_MouthBase_s",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.2f, 1.0f))
            },
            {
                "cf_J_MouthMove",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mouth_L",
                new TransformPreset(new Vector3(-0.2f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mouth_R",
                new TransformPreset(new Vector3(0.2f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_MouthLow",
                new TransformPreset(new Vector3(0.0f, -0.1f, 0.1f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mouthup",
                new TransformPreset(new Vector3(0.0f, 0.1f, 0.1f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_MouthCavity",
                new TransformPreset(new Vector3(0.0f, 0.0f, -0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_FaceUp_ty",
                new TransformPreset(new Vector3(0.0f, 0.2f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_EarBase_s_L",
                new TransformPreset(new Vector3(-0.7f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_EarLow_L",
                new TransformPreset(new Vector3(0.0f, -0.2f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_EarRing_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_EarUp_L",
                new TransformPreset(new Vector3(-0.1f, 0.2f, -0.1f), new Vector3(0.2f, 359.8f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_EarBase_s_R",
                new TransformPreset(new Vector3(0.7f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_EarLow_R",
                new TransformPreset(new Vector3(0.0f, -0.2f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_EarRing_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_EarUp_R",
                new TransformPreset(new Vector3(0.1f, 0.2f, -0.1f), new Vector3(0.2f, 0.2f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_FaceUp_tz",
                new TransformPreset(new Vector3(0.0f, 0.2f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Eye_t_L",
                new TransformPreset(new Vector3(-0.3f, 0.0f, 0.5f), new Vector3(0.0f, 0.0f, 3.2f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Eye_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.1f, 1.3f, 1.0f))
            },
            {
                "cf_J_Eye_r_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 355.2f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Eye01_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(3.8f, 35.6f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Eye01_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Eye02_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(339.8f, 1.1f, 0.6f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Eye02_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Eye03_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(2.0f, 319.2f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Eye03_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Eye04_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(19.8f, 1.1f, 0.6f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Eye04_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_EyePos_rz_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 356.8f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_look_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(353.0f, 353.7f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_eye_rs_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_pupil_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Eye_t_R",
                new TransformPreset(new Vector3(0.3f, 0.0f, 0.5f), new Vector3(0.0f, 0.0f, 356.8f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Eye_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.1f, 1.3f, 1.0f))
            },
            {
                "cf_J_Eye_r_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 4.8f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Eye01_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(3.8f, 324.4f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Eye01_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Eye02_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(339.8f, 358.9f, 359.4f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Eye02_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Eye03_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(2.0f, 40.8f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Eye03_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Eye04_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(19.8f, 358.9f, 359.4f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Eye04_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_EyePos_rz_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 3.2f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_look_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(353.1f, 352.3f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_eye_rs_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_pupil_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mayu_L",
                new TransformPreset(new Vector3(-0.3f, 0.2f, 0.8f), new Vector3(0.0f, 350.0f, 0.0f), new Vector3(0.7f, 1.0f, 1.0f))
            },
            {
                "cf_J_MayuMid_s_L",
                new TransformPreset(new Vector3(0.2f, 0.0f, 0.0f), new Vector3(0.0f, 2.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_MayuTip_s_L",
                new TransformPreset(new Vector3(-0.2f, 0.0f, 0.0f), new Vector3(0.0f, 2.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Mayu_R",
                new TransformPreset(new Vector3(0.3f, 0.2f, 0.8f), new Vector3(0.0f, 10.0f, 0.0f), new Vector3(0.7f, 1.0f, 1.0f))
            },
            {
                "cf_J_MayuMid_s_R",
                new TransformPreset(new Vector3(-0.2f, 0.0f, 0.0f), new Vector3(0.0f, 2.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_MayuTip_s_R",
                new TransformPreset(new Vector3(0.2f, 0.0f, 0.0f), new Vector3(0.0f, 2.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_NoseBase_trs",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.7f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.1f, 1.0f))
            },
            {
                "cf_J_NoseBase_s",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(352.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Nose_r",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.1f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Nose_t",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(359.3f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Nose_tip",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.1f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.1f, 1.1f, 1.1f))
            },
            {
                "cf_J_NoseWing_tx_L",
                new TransformPreset(new Vector3(-0.1f, 0.0f, 0.1f), new Vector3(2.0f, 0.0f, 355.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_NoseWing_tx_R",
                new TransformPreset(new Vector3(0.1f, 0.0f, 0.1f), new Vector3(2.0f, 0.0f, 5.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_NoseBridge_t",
                new TransformPreset(new Vector3(0.0f, 0.4f, 0.1f), new Vector3(9.2f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_megane",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(350.8f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_NoseBridge_s",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.8f, 1.0f, 1.0f))
            },
            {
                "cf_J_FaceRoot_s",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Neck_s",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_ShoulderIK_L",
                new TransformPreset(new Vector3(-0.3f, 1.1f, -0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Shoulder_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 8.7f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_ArmUp00_L",
                new TransformPreset(new Vector3(-1.0f, 0.0f, 0.0f), new Vector3(11.9f, 333.5f, 75.7f), new Vector3(1.0f, 1.1f, 1.0f))
            },
            {
                "cf_J_ArmElbo_dam_01_L",
                new TransformPreset(new Vector3(-2.7f, 0.0f, -0.1f), new Vector3(0.0f, 15.2f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_ArmElbo_low_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_ArmLow01_L",
                new TransformPreset(new Vector3(-2.7f, 0.0f, 0.0f), new Vector3(0.0f, 48.6f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_ArmLow01_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.1f, 1.1f))
            },
            {
                "cf_J_ArmLow02_dam_L",
                new TransformPreset(new Vector3(-1.3f, 0.0f, 0.0f), new Vector3(2.8f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_ArmLow02_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.1f, 1.1f))
            },
            {
                "cf_J_Hand_L",
                new TransformPreset(new Vector3(-2.3f, 0.0f, 0.0f), new Vector3(4.0f, 343.5f, 343.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.3f, 1.1f, 1.2f))
            },
            {
                "cf_J_Hand_Index01_L",
                new TransformPreset(new Vector3(-0.5f, 0.0f, 0.2f), new Vector3(359.0f, 359.9f, 5.1f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Index02_L",
                new TransformPreset(new Vector3(-0.3f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 23.1f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Index03_L",
                new TransformPreset(new Vector3(-0.2f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 21.1f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Little01_L",
                new TransformPreset(new Vector3(-0.5f, -0.1f, -0.2f), new Vector3(354.7f, 357.7f, 22.9f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Little02_L",
                new TransformPreset(new Vector3(-0.2f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 23.8f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Little03_L",
                new TransformPreset(new Vector3(-0.1f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 27.9f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Middle01_L",
                new TransformPreset(new Vector3(-0.6f, 0.0f, 0.0f), new Vector3(359.9f, 360.0f, 16.9f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Middle02_L",
                new TransformPreset(new Vector3(-0.3f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 25.6f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Middle03_L",
                new TransformPreset(new Vector3(-0.2f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 22.2f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Ring01_L",
                new TransformPreset(new Vector3(-0.5f, 0.0f, -0.1f), new Vector3(357.6f, 359.0f, 22.8f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Ring02_L",
                new TransformPreset(new Vector3(-0.3f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 24.2f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Ring03_L",
                new TransformPreset(new Vector3(-0.2f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 26.5f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Thumb01_L",
                new TransformPreset(new Vector3(-0.1f, -0.1f, 0.2f), new Vector3(0.1f, 0.3f, 5.6f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Thumb02_L",
                new TransformPreset(new Vector3(-0.2f, -0.1f, 0.1f), new Vector3(358.5f, 0.2f, 2.6f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Thumb03_L",
                new TransformPreset(new Vector3(-0.2f, 0.0f, 0.0f), new Vector3(0.0f, 0.3f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Wrist_dam_L",
                new TransformPreset(new Vector3(-1.8f, 0.0f, 0.0f), new Vector3(5.5f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Wrist_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_dam_L",
                new TransformPreset(new Vector3(-0.2f, 0.0f, 0.0f), new Vector3(359.7f, 357.0f, 348.4f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_ArmUp01_dam_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(12.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_ArmUp01_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 359.4f, 359.7f), new Vector3(1.0f, 1.1f, 1.1f))
            },
            {
                "cf_J_ArmUp02_dam_L",
                new TransformPreset(new Vector3(-1.1f, 0.0f, 0.0f), new Vector3(5.6f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_ArmUp02_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 359.7f, 0.0f), new Vector3(1.0f, 1.1f, 1.1f))
            },
            {
                "cf_J_ArmUp03_dam_L",
                new TransformPreset(new Vector3(-1.9f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_ArmUp03_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.1f, 1.1f))
            },
            {
                "cf_J_ArmElboura_dam_L",
                new TransformPreset(new Vector3(0.2f, 0.0f, 0.0f), new Vector3(0.0f, 16.1f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_ArmElboura_s_L",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Shoulder02_s_L",
                new TransformPreset(new Vector3(-0.7f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.1f, 1.1f, 1.1f))
            },
            {
                "cf_J_ShoulderIK_R",
                new TransformPreset(new Vector3(0.3f, 1.1f, -0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Shoulder_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 351.3f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_ArmUp00_R",
                new TransformPreset(new Vector3(1.0f, 0.0f, 0.0f), new Vector3(3.7f, 25.6f, 288.8f), new Vector3(1.0f, 1.1f, 1.0f))
            },
            {
                "cf_J_ArmElbo_dam_01_R",
                new TransformPreset(new Vector3(2.8f, 0.0f, -0.1f), new Vector3(0.0f, 344.4f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_ArmElbo_low_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_ArmLow01_R",
                new TransformPreset(new Vector3(2.7f, 0.0f, 0.0f), new Vector3(0.0f, 310.9f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_ArmLow01_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.1f, 1.1f))
            },
            {
                "cf_J_ArmLow02_dam_R",
                new TransformPreset(new Vector3(1.3f, 0.0f, 0.0f), new Vector3(0.9f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_ArmLow02_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.1f, 1.1f))
            },
            {
                "cf_J_Hand_R",
                new TransformPreset(new Vector3(2.3f, 0.0f, 0.0f), new Vector3(0.1f, 16.6f, 20.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.3f, 1.1f, 1.2f))
            },
            {
                "cf_J_Hand_Index01_R",
                new TransformPreset(new Vector3(0.5f, 0.0f, 0.2f), new Vector3(359.0f, 0.1f, 354.9f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Index02_R",
                new TransformPreset(new Vector3(0.3f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 336.9f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Index03_R",
                new TransformPreset(new Vector3(0.2f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 338.9f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Little01_R",
                new TransformPreset(new Vector3(0.5f, -0.1f, -0.2f), new Vector3(0.2f, 0.2f, 337.2f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Little02_R",
                new TransformPreset(new Vector3(0.2f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 336.2f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Little03_R",
                new TransformPreset(new Vector3(0.1f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 332.1f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Middle01_R",
                new TransformPreset(new Vector3(0.6f, 0.0f, 0.0f), new Vector3(359.9f, 0.0f, 343.1f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Middle02_R",
                new TransformPreset(new Vector3(0.3f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 334.4f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Middle03_R",
                new TransformPreset(new Vector3(0.2f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 337.8f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Ring01_R",
                new TransformPreset(new Vector3(0.5f, 0.0f, -0.1f), new Vector3(357.6f, 1.0f, 337.2f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Ring02_R",
                new TransformPreset(new Vector3(0.3f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 335.8f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Ring03_R",
                new TransformPreset(new Vector3(0.2f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 333.5f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Thumb01_R",
                new TransformPreset(new Vector3(0.1f, -0.1f, 0.2f), new Vector3(0.1f, 359.7f, 354.4f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Thumb02_R",
                new TransformPreset(new Vector3(0.2f, -0.1f, 0.1f), new Vector3(358.5f, 359.8f, 357.4f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Thumb03_R",
                new TransformPreset(new Vector3(0.2f, 0.0f, 0.0f), new Vector3(0.0f, 359.7f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Wrist_dam_R",
                new TransformPreset(new Vector3(1.8f, 0.0f, 0.0f), new Vector3(1.8f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_Wrist_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Hand_dam_R",
                new TransformPreset(new Vector3(0.2f, 0.0f, 0.0f), new Vector3(359.6f, 3.0f, 13.7f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_ArmUp01_dam_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(15.5f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_ArmUp01_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.3f), new Vector3(1.0f, 1.1f, 1.1f))
            },
            {
                "cf_J_ArmUp02_dam_R",
                new TransformPreset(new Vector3(1.1f, 0.0f, 0.0f), new Vector3(7.2f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_ArmUp02_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.3f, 0.0f), new Vector3(1.0f, 1.1f, 1.1f))
            },
            {
                "cf_J_ArmUp03_dam_R",
                new TransformPreset(new Vector3(1.9f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_ArmUp03_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.1f, 1.1f))
            },
            {
                "cf_J_ArmElboura_dam_R",
                new TransformPreset(new Vector3(-0.2f, 0.0f, 0.0f), new Vector3(0.0f, 343.3f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_ArmElboura_s_R",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_Shoulder02_s_R",
                new TransformPreset(new Vector3(0.7f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.1f, 1.1f, 1.1f))
            },
            {
                "cf_J_Spine03_s",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.1f, 1.0f))
            },
            {
                "cf_J_SpineSk00_dam",
                new TransformPreset(new Vector3(0.0f, 1.3f, 0.3f), new Vector3(48.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_SpineSk00",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_SpineSk01",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.6f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_SpineSk02",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.6f), new Vector3(19.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_SpineSk03",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.6f), new Vector3(19.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_SpineSk04",
                new TransformPreset(new Vector3(0.0f, 0.0f, 0.6f), new Vector3(4.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_SpineSk05",
                new TransformPreset(new Vector3(0.0f, 0.0f, 1.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            },
            {
                "cf_J_SpineSk06",
                new TransformPreset(new Vector3(0.0f, 0.0f, 1.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))
            }
        }),
        new AIHSBodyPreset("Body 02", new Dictionary<string, TransformPreset>
        {
            {"cf_J_Hips", new TransformPreset(new Vector3(0.0f, 11.4f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Kosi01", new TransformPreset(new Vector3(0.0f, -0.1f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Kosi01_s", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.1f, 1.0f, 1.0f))},
            {"cf_J_Kosi02", new TransformPreset(new Vector3(0.0f, -1.0f, -0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.1f, 1.0f, 1.1f))},
            {"cf_J_Kosi02_s", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.2f, 1.0f, 1.0f))},
            {"cf_J_Ana", new TransformPreset(new Vector3(0.0f, -0.9f, -0.4f), new Vector3(26.1f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Kokan", new TransformPreset(new Vector3(0.0f, -0.8f, 0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Kosi03", new TransformPreset(new Vector3(0.0f, 0.0f, 0.6f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Kosi03_s", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_LegUp00_L", new TransformPreset(new Vector3(-0.9f, -0.5f, -0.1f), new Vector3(358.9f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_LegKnee_dam_L", new TransformPreset(new Vector3(0.0f, -4.1f, 0.3f), new Vector3(1.8f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_LegKnee_low_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_LegLow01_L", new TransformPreset(new Vector3(0.0f, -4.2f, 0.0f), new Vector3(3.5f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_LegLow01_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.1f, 1.0f, 1.0f))},
            {"cf_J_LegLow03_L", new TransformPreset(new Vector3(0.0f, -4.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_LegLow03_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.9f, 1.0f, 0.9f))},
            {"cf_J_LegLowRoll_L", new TransformPreset(new Vector3(0.0f, -2.3f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Foot01_L", new TransformPreset(new Vector3(0.0f, -2.4f, 0.0f), new Vector3(357.6f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 0.9f))},
            {"cf_J_Foot02_L", new TransformPreset(new Vector3(0.0f, -0.5f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Toes01_L", new TransformPreset(new Vector3(0.0f, -0.2f, 1.1f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_LegLow02_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_LegUp01_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_LegUp01_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.1f), new Vector3(1.2f, 1.0f, 1.1f))},
            {"cf_J_LegUp02_L", new TransformPreset(new Vector3(0.0f, -2.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_LegUp02_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.2f, 1.0f, 1.0f))},
            {"cf_J_LegUp03_L", new TransformPreset(new Vector3(0.0f, -3.4f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_LegUp03_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_LegKnee_back_L", new TransformPreset(new Vector3(0.0f, 0.5f, 0.0f), new Vector3(3.5f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_LegKnee_back_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.9f, 1.0f, 0.9f))},
            {"cf_J_LegUp00_R", new TransformPreset(new Vector3(0.9f, -0.5f, -0.1f), new Vector3(358.9f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_LegKnee_dam_R", new TransformPreset(new Vector3(0.0f, -4.1f, 0.3f), new Vector3(1.8f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_LegKnee_low_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_LegLow01_R", new TransformPreset(new Vector3(0.0f, -4.2f, 0.0f), new Vector3(3.5f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_LegLow01_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.1f, 1.0f, 1.0f))},
            {"cf_J_LegLow03_R", new TransformPreset(new Vector3(0.0f, -4.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_LegLow03_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.9f, 1.0f, 0.9f))},
            {"cf_J_LegLowRoll_R", new TransformPreset(new Vector3(0.0f, -2.3f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Foot01_R", new TransformPreset(new Vector3(0.0f, -2.4f, 0.0f), new Vector3(357.6f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 0.9f))},
            {"cf_J_Foot02_R", new TransformPreset(new Vector3(0.0f, -0.5f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Toes01_R", new TransformPreset(new Vector3(0.0f, -0.2f, 1.1f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_LegLow02_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_LegUp01_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(359.8f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_LegUp01_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 359.9f), new Vector3(1.2f, 1.0f, 1.1f))},
            {"cf_J_LegUp02_R", new TransformPreset(new Vector3(0.0f, -2.0f, 0.0f), new Vector3(359.8f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_LegUp02_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.2f, 1.0f, 1.0f))},
            {"cf_J_LegUp03_R", new TransformPreset(new Vector3(0.0f, -3.4f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_LegUp03_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_LegKnee_back_R", new TransformPreset(new Vector3(0.0f, 0.5f, 0.0f), new Vector3(3.5f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_LegKnee_back_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.9f, 1.0f, 0.9f))},
            {"cf_J_SiriDam_L", new TransformPreset(new Vector3(-0.9f, -0.2f, -0.1f), new Vector3(359.4f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_SiriDam01_L_00", new TransformPreset(new Vector3(0.0f, 0.0f, -0.4f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_SiriDam01_L", new TransformPreset(new Vector3(0.0f, 0.0f, -0.4f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Siri_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Siri_s_L", new TransformPreset(new Vector3(0.0f, 0.1f, -0.5f), new Vector3(2.5f, 0.0f, 0.0f), new Vector3(1.3f, 1.3f, 1.4f))},
            {"cf_J_Siriopen_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_SiriDam_R", new TransformPreset(new Vector3(0.9f, -0.2f, -0.1f), new Vector3(359.4f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_SiriDam01_R_00", new TransformPreset(new Vector3(0.0f, 0.0f, -0.4f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_SiriDam01_R", new TransformPreset(new Vector3(0.0f, 0.0f, -0.4f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Siri_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Siri_s_R", new TransformPreset(new Vector3(0.0f, 0.1f, -0.5f), new Vector3(2.5f, 0.0f, 0.0f), new Vector3(1.3f, 1.3f, 1.4f))},
            {"cf_J_Siriopen_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_LegUpDam_L", new TransformPreset(new Vector3(-0.9f, 0.0f, -0.3f), new Vector3(359.2f, 0.0f, 359.8f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_LegUpDam_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.4f, 1.0f, 1.0f))},
            {"cf_J_LegUpDam_R", new TransformPreset(new Vector3(0.9f, 0.0f, -0.3f), new Vector3(359.2f, 0.0f, 0.2f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_LegUpDam_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.4f, 1.0f, 1.0f))},
            {"cf_J_Spine01", new TransformPreset(new Vector3(0.0f, 0.2f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Spine01_s", new TransformPreset(new Vector3(0.0f, 0.1f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.1f))},
            {"cf_J_Spine02", new TransformPreset(new Vector3(0.0f, 0.7f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Spine02_s", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Spine03", new TransformPreset(new Vector3(0.0f, 1.1f, -0.1f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mune00", new TransformPreset(new Vector3(0.0f, -0.3f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mune00_t_L", new TransformPreset(new Vector3(-0.4f, 0.0f, 0.0f), new Vector3(350.1f, 341.0f, 0.0f), new Vector3(1.1f, 1.1f, 1.1f))},
            {"cf_J_Mune00_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mune00_L_00", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mune00_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.1f, 1.1f, 1.1f))},
            {"cf_J_Mune00_d_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.7f), new Vector3(356.7f, 359.5f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mune01_L_00", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mune01_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.2f, 360.0f, 0.1f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mune01_s_L", new TransformPreset(new Vector3(0.0f, -0.1f, 0.0f), new Vector3(7.1f, 358.0f, 0.0f), new Vector3(1.2f, 1.2f, 1.2f))},
            {"cf_J_Mune01_t_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.3f), new Vector3(350.1f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mune02_L_00", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mune02_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.2f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mune02_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.1f), new Vector3(348.7f, 0.0f, 0.0f), new Vector3(1.3f, 1.3f, 1.3f))},
            {"cf_J_Mune02_t_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.3f), new Vector3(350.1f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mune03_L_00", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mune03_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mune03_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.9f, 0.9f, 0.6f))},
            {"cf_J_Mune04_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mune_Nip01_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mune_Nip01_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 0.9f))},
            {"cf_J_Mune_Nip02_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mune_Nip02_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.1f, 1.1f, 1.1f))},
            {"cf_J_Mune_Nipacs01_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.7f, 0.7f, 0.9f))},
            {"cf_J_Mune00_t_R", new TransformPreset(new Vector3(0.4f, 0.0f, 0.0f), new Vector3(350.1f, 19.0f, 0.0f), new Vector3(1.1f, 1.1f, 1.1f))},
            {"cf_J_Mune00_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mune00_R_00", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mune00_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.1f, 1.1f, 1.1f))},
            {"cf_J_Mune00_d_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.7f), new Vector3(356.7f, 0.5f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mune01_R_00", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mune01_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.2f, 0.0f, 359.9f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mune01_s_R", new TransformPreset(new Vector3(0.0f, -0.1f, 0.0f), new Vector3(7.1f, 2.0f, 0.0f), new Vector3(1.2f, 1.2f, 1.2f))},
            {"cf_J_Mune01_t_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.3f), new Vector3(350.1f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mune02_R_00", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mune02_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.2f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mune02_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.1f), new Vector3(348.7f, 0.0f, 0.0f), new Vector3(1.3f, 1.3f, 1.3f))},
            {"cf_J_Mune02_t_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.3f), new Vector3(350.1f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mune03_R_00", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mune03_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mune03_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.9f, 0.9f, 0.6f))},
            {"cf_J_Mune04_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mune_Nip01_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mune_Nip01_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 0.9f))},
            {"cf_J_Mune_Nip02_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mune_Nip02_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.1f, 1.1f, 1.1f))},
            {"cf_J_Mune_Nipacs01_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.7f, 0.7f, 0.8f))},
            {"cf_J_Neck", new TransformPreset(new Vector3(0.0f, 1.4f, -0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Head", new TransformPreset(new Vector3(0.0f, 0.8f, 0.1f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Head_s", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_FaceRoot", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_FaceBase", new TransformPreset(new Vector3(0.0f, 0.2f, 0.1f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_FaceLowBase", new TransformPreset(new Vector3(0.0f, -0.1f, 0.4f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_FaceLow_s", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_CheekLow_L", new TransformPreset(new Vector3(-0.4f, 0.1f, 0.1f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.9f, 1.6f, 0.9f))},
            {"cf_J_CheekLow_R", new TransformPreset(new Vector3(0.4f, 0.1f, 0.1f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.9f, 1.6f, 0.9f))},
            {"cf_J_CheekUp_L", new TransformPreset(new Vector3(-0.3f, 0.4f, 0.1f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.2f, 1.0f))},
            {"cf_J_CheekUp_R", new TransformPreset(new Vector3(0.3f, 0.4f, 0.1f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.2f, 1.0f))},
            {"cf_J_Chin_rs", new TransformPreset(new Vector3(0.0f, -0.2f, 0.3f), new Vector3(2.4f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_ChinTip_s", new TransformPreset(new Vector3(0.0f, -0.1f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.8f, 0.6f, 0.9f))},
            {"cf_J_ChinLow", new TransformPreset(new Vector3(0.0f, -0.2f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_MouthBase_tr", new TransformPreset(new Vector3(0.0f, -0.1f, 0.4f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_MouthBase_s", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.2f, 1.0f))},
            {"cf_J_MouthMove", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mouth_L", new TransformPreset(new Vector3(-0.2f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mouth_R", new TransformPreset(new Vector3(0.2f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_MouthLow", new TransformPreset(new Vector3(0.0f, -0.1f, 0.1f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mouthup", new TransformPreset(new Vector3(0.0f, 0.1f, 0.1f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_MouthCavity", new TransformPreset(new Vector3(0.0f, 0.0f, -0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_FaceUp_ty", new TransformPreset(new Vector3(0.0f, 0.2f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_EarBase_s_L", new TransformPreset(new Vector3(-0.7f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_EarLow_L", new TransformPreset(new Vector3(0.0f, -0.2f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_EarRing_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_EarUp_L", new TransformPreset(new Vector3(-0.1f, 0.2f, -0.1f), new Vector3(0.2f, 359.8f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_EarBase_s_R", new TransformPreset(new Vector3(0.7f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_EarLow_R", new TransformPreset(new Vector3(0.0f, -0.2f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_EarRing_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_EarUp_R", new TransformPreset(new Vector3(0.1f, 0.2f, -0.1f), new Vector3(0.2f, 0.2f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_FaceUp_tz", new TransformPreset(new Vector3(0.0f, 0.2f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Eye_t_L", new TransformPreset(new Vector3(-0.3f, 0.0f, 0.5f), new Vector3(0.0f, 0.0f, 3.2f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Eye_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.1f, 1.3f, 1.0f))},
            {"cf_J_Eye_r_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 355.2f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Eye01_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(3.8f, 35.6f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Eye01_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Eye02_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(339.8f, 1.1f, 0.6f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Eye02_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Eye03_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(2.0f, 319.2f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Eye03_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Eye04_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(19.8f, 1.1f, 0.6f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Eye04_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_EyePos_rz_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 356.8f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_look_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.1f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_eye_rs_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_pupil_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Eye_t_R", new TransformPreset(new Vector3(0.3f, 0.0f, 0.5f), new Vector3(0.0f, 0.0f, 356.8f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Eye_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.1f, 1.3f, 1.0f))},
            {"cf_J_Eye_r_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 4.8f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Eye01_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(3.8f, 324.4f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Eye01_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Eye02_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(339.8f, 358.9f, 359.4f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Eye02_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Eye03_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(2.0f, 40.8f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Eye03_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Eye04_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(19.8f, 358.9f, 359.4f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Eye04_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_EyePos_rz_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 3.2f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_look_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 359.9f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_eye_rs_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_pupil_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mayu_L", new TransformPreset(new Vector3(-0.3f, 0.2f, 0.8f), new Vector3(0.0f, 350.0f, 0.0f), new Vector3(0.7f, 1.0f, 1.0f))},
            {"cf_J_MayuMid_s_L", new TransformPreset(new Vector3(0.2f, 0.0f, 0.0f), new Vector3(0.0f, 2.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_MayuTip_s_L", new TransformPreset(new Vector3(-0.2f, 0.0f, 0.0f), new Vector3(0.0f, 2.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Mayu_R", new TransformPreset(new Vector3(0.3f, 0.2f, 0.8f), new Vector3(0.0f, 10.0f, 0.0f), new Vector3(0.7f, 1.0f, 1.0f))},
            {"cf_J_MayuMid_s_R", new TransformPreset(new Vector3(-0.2f, 0.0f, 0.0f), new Vector3(0.0f, 2.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_MayuTip_s_R", new TransformPreset(new Vector3(0.2f, 0.0f, 0.0f), new Vector3(0.0f, 2.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_NoseBase_trs", new TransformPreset(new Vector3(0.0f, 0.0f, 0.7f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.1f, 1.0f))},
            {"cf_J_NoseBase_s", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(352.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Nose_r", new TransformPreset(new Vector3(0.0f, 0.0f, 0.1f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Nose_t", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(359.3f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Nose_tip", new TransformPreset(new Vector3(0.0f, 0.0f, 0.1f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.1f, 1.1f, 1.1f))},
            {"cf_J_NoseWing_tx_L", new TransformPreset(new Vector3(-0.1f, 0.0f, 0.1f), new Vector3(2.0f, 0.0f, 355.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_NoseWing_tx_R", new TransformPreset(new Vector3(0.1f, 0.0f, 0.1f), new Vector3(2.0f, 0.0f, 5.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_NoseBridge_t", new TransformPreset(new Vector3(0.0f, 0.4f, 0.1f), new Vector3(9.2f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_megane", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(350.8f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_NoseBridge_s", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.8f, 1.0f, 1.0f))},
            {"cf_J_FaceRoot_s", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Neck_s", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_ShoulderIK_L", new TransformPreset(new Vector3(-0.3f, 1.1f, -0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Shoulder_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_ArmUp00_L", new TransformPreset(new Vector3(-1.0f, 0.0f, 0.0f), new Vector3(0.0f, 358.5f, 0.0f), new Vector3(1.0f, 1.1f, 1.0f))},
            {"cf_J_ArmElbo_dam_01_L", new TransformPreset(new Vector3(-2.8f, 0.0f, -0.1f), new Vector3(0.0f, 1.7f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_ArmElbo_low_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_ArmLow01_L", new TransformPreset(new Vector3(-2.7f, 0.0f, 0.0f), new Vector3(0.0f, 2.8f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_ArmLow01_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.1f, 1.1f))},
            {"cf_J_ArmLow02_dam_L", new TransformPreset(new Vector3(-1.3f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_ArmLow02_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.1f, 1.1f))},
            {"cf_J_Hand_L", new TransformPreset(new Vector3(-2.3f, 0.0f, 0.0f), new Vector3(0.0f, 358.7f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.3f, 1.1f, 1.2f))},
            {"cf_J_Hand_Index01_L", new TransformPreset(new Vector3(-0.5f, 0.0f, 0.2f), new Vector3(0.0f, 0.0f, 1.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Index02_L", new TransformPreset(new Vector3(-0.3f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.1f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Index03_L", new TransformPreset(new Vector3(-0.2f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.1f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Little01_L", new TransformPreset(new Vector3(-0.5f, -0.1f, -0.2f), new Vector3(0.0f, 0.0f, 1.5f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Little02_L", new TransformPreset(new Vector3(-0.2f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.1f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Little03_L", new TransformPreset(new Vector3(-0.1f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.1f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Middle01_L", new TransformPreset(new Vector3(-0.6f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 2.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Middle02_L", new TransformPreset(new Vector3(-0.3f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.1f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Middle03_L", new TransformPreset(new Vector3(-0.2f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.1f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Ring01_L", new TransformPreset(new Vector3(-0.5f, 0.0f, -0.1f), new Vector3(0.0f, 0.0f, 2.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Ring02_L", new TransformPreset(new Vector3(-0.3f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.1f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Ring03_L", new TransformPreset(new Vector3(-0.2f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.1f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Thumb01_L", new TransformPreset(new Vector3(-0.1f, -0.1f, 0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Thumb02_L", new TransformPreset(new Vector3(-0.2f, -0.1f, 0.1f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Thumb03_L", new TransformPreset(new Vector3(-0.2f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Wrist_dam_L", new TransformPreset(new Vector3(-1.8f, 0.0f, 0.0f), new Vector3(0.0f, 0.1f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Wrist_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_dam_L", new TransformPreset(new Vector3(-0.2f, 0.0f, 0.0f), new Vector3(0.0f, 1.9f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_ArmUp01_dam_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_ArmUp01_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 359.4f, 359.7f), new Vector3(1.0f, 1.1f, 1.1f))},
            {"cf_J_ArmUp02_dam_L", new TransformPreset(new Vector3(-1.1f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_ArmUp02_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 359.7f, 0.0f), new Vector3(1.0f, 1.1f, 1.1f))},
            {"cf_J_ArmUp03_dam_L", new TransformPreset(new Vector3(-1.9f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_ArmUp03_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.1f, 1.1f))},
            {"cf_J_ArmElboura_dam_L", new TransformPreset(new Vector3(0.2f, 0.0f, 0.0f), new Vector3(0.0f, 1.7f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_ArmElboura_s_L", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Shoulder02_s_L", new TransformPreset(new Vector3(-0.7f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.1f, 1.1f, 1.1f))},
            {"cf_J_ShoulderIK_R", new TransformPreset(new Vector3(0.3f, 1.1f, -0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Shoulder_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_ArmUp00_R", new TransformPreset(new Vector3(1.0f, 0.0f, 0.0f), new Vector3(0.0f, 1.5f, 0.0f), new Vector3(1.0f, 1.1f, 1.0f))},
            {"cf_J_ArmElbo_dam_01_R", new TransformPreset(new Vector3(2.8f, 0.0f, -0.1f), new Vector3(0.0f, 358.3f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_ArmElbo_low_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_ArmLow01_R", new TransformPreset(new Vector3(2.7f, 0.0f, 0.0f), new Vector3(0.0f, 357.2f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_ArmLow01_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.1f, 1.1f))},
            {"cf_J_ArmLow02_dam_R", new TransformPreset(new Vector3(1.3f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_ArmLow02_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.1f, 1.1f))},
            {"cf_J_Hand_R", new TransformPreset(new Vector3(2.3f, 0.0f, 0.0f), new Vector3(0.0f, 1.3f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.3f, 1.1f, 1.2f))},
            {"cf_J_Hand_Index01_R", new TransformPreset(new Vector3(0.5f, 0.0f, 0.2f), new Vector3(0.0f, 0.0f, 359.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Index02_R", new TransformPreset(new Vector3(0.3f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 360.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Index03_R", new TransformPreset(new Vector3(0.2f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 360.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Little01_R", new TransformPreset(new Vector3(0.5f, -0.1f, -0.2f), new Vector3(0.0f, 0.0f, 358.5f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Little02_R", new TransformPreset(new Vector3(0.2f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 360.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Little03_R", new TransformPreset(new Vector3(0.1f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 360.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Middle01_R", new TransformPreset(new Vector3(0.6f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 358.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Middle02_R", new TransformPreset(new Vector3(0.3f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 360.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Middle03_R", new TransformPreset(new Vector3(0.2f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 360.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Ring01_R", new TransformPreset(new Vector3(0.5f, 0.0f, -0.1f), new Vector3(0.0f, 0.0f, 358.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Ring02_R", new TransformPreset(new Vector3(0.3f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 360.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Ring03_R", new TransformPreset(new Vector3(0.2f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 360.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Thumb01_R", new TransformPreset(new Vector3(0.1f, -0.1f, 0.2f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Thumb02_R", new TransformPreset(new Vector3(0.2f, -0.1f, 0.1f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Thumb03_R", new TransformPreset(new Vector3(0.2f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Wrist_dam_R", new TransformPreset(new Vector3(1.8f, 0.0f, 0.0f), new Vector3(0.0f, 359.9f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_Wrist_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Hand_dam_R", new TransformPreset(new Vector3(0.2f, 0.0f, 0.0f), new Vector3(0.0f, 358.1f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_ArmUp01_dam_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_ArmUp01_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.3f), new Vector3(1.0f, 1.1f, 1.1f))},
            {"cf_J_ArmUp02_dam_R", new TransformPreset(new Vector3(1.1f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_ArmUp02_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.3f, 0.0f), new Vector3(1.0f, 1.1f, 1.1f))},
            {"cf_J_ArmUp03_dam_R", new TransformPreset(new Vector3(1.9f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_ArmUp03_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.1f, 1.1f))},
            {"cf_J_ArmElboura_dam_R", new TransformPreset(new Vector3(-0.2f, 0.0f, 0.0f), new Vector3(0.0f, 358.3f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_ArmElboura_s_R", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_Shoulder02_s_R", new TransformPreset(new Vector3(0.7f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.1f, 1.1f, 1.1f))},
            {"cf_J_Spine03_s", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.1f, 1.0f))},
            {"cf_J_SpineSk00_dam", new TransformPreset(new Vector3(0.0f, 1.3f, 0.3f), new Vector3(48.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_SpineSk00", new TransformPreset(new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_SpineSk01", new TransformPreset(new Vector3(0.0f, 0.0f, 0.6f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_SpineSk02", new TransformPreset(new Vector3(0.0f, 0.0f, 0.6f), new Vector3(19.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_SpineSk03", new TransformPreset(new Vector3(0.0f, 0.0f, 0.6f), new Vector3(19.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_SpineSk04", new TransformPreset(new Vector3(0.0f, 0.0f, 0.6f), new Vector3(4.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_SpineSk05", new TransformPreset(new Vector3(0.0f, 0.0f, 1.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))},
            {"cf_J_SpineSk06", new TransformPreset(new Vector3(0.0f, 0.0f, 1.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(1.0f, 1.0f, 1.0f))}
        })
    };

    public static void LoadObject(GameObject gameObject, int index = 0)
    {
        var preset = presets[index];
        foreach (var child in gameObject.GetComponentsInChildren<Transform>())
        {
            TransformPreset pp;
            if (preset.transformPresets.TryGetValue(child.name, out pp))
            {
                child.transform.localPosition = pp.localPosition;
                child.transform.localEulerAngles = pp.localEulerAngle;
                child.transform.localScale = pp.localScale;
            }
        }
    }
}