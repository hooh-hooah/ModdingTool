using System;
using System.Collections.Generic;
using UnityEngine;

public class SunLightInfo : MonoBehaviour
{
    [SerializeField] private Info _info;
    [SerializeField] private List<GameObject> environmentLightObjects;
    [SerializeField] private List<GameObject> rootObjectMaps;
    public Info info => _info;
    public List<GameObject> RootObjectMaps => rootObjectMaps;
    public List<GameObject> EnvironmentLightObjects => environmentLightObjects;

    [Serializable]
    public class Info
    {
        [Header("Backの色")] public Color charaLightADVBackColor;
        [Header("Backの強さ")] public float charaLightADVBackintensity = 1f;
        [Header("ADVキャラライト設定")] public Color charaLightADVFrontColor;
        [Header("Front(Key)の強さ")] public float charaLightADVFrontintensity = 1f;
        [Header("Backの色")] public Color charaLightBackColor;
        [Header("Backの強さ")] public float charaLightBackintensity = 1f;
        [Header("Hキャラライト設定")] public Color charaLightFrontColor;
        [Header("Front(Key)の強さ")] public float charaLightFrontintensity = 1f;
        [Header("絞り")] public float dofAperture;
        [Header("焦点幅")] public float dofFocalSize;
        [Header("被写界深度の設定")] public bool dofUse;
        [Header("色")] public Color fogColor;
        [Header("フォグ強さ")] public float fogDensity;
        [Header("背景フォグ")] public bool fogExcludeFarPixels;
        [Header("フォグ高さ")] public float fogHeight;
        [Header("フォグ高さ濃度")] public float fogHeightDensity;
        [Header("フォグの設定")] public bool fogUse;
        [Header("強さ")] public float reflectProbeintensity;
        [Header("ReflectProbe設定")] public Texture reflectProbeTexture;
        [Header("伸び")] public float sunShaftsBlurSize;
        [Header("色")] public Color sunShaftsColor;
        [Header("強さ")] public float sunShaftsIntensity;
        [Header("範囲")] public float sunShaftsMaxRadius;
        [Header("しきい色")] public Color sunShaftsThresholdColor;
        [Header("Shafts caster")] public Transform sunShaftsTransform;
        [Header("カメラのサンシャフト(SunShafts)設定")] public bool sunShaftsUse;
        [Header("表示オブジェクトの設定")] public List<GameObject> visibleList = new List<GameObject>();
    }
}