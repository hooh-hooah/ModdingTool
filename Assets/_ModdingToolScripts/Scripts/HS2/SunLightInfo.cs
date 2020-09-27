using System;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using MyBox;
using UnityEngine;

[SuppressMessage("ReSharper", "InconsistentNaming")]
[SuppressMessage("ReSharper", "IdentifierTypo")]
[SuppressMessage("ReSharper", "MemberCanBePrivate.Global")]
#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649
public class SunLightInfo : MonoBehaviour
{
    [SerializeField] private Info _info;
    [SerializeField] private List<GameObject> environmentLightObjects;
    [SerializeField] private List<GameObject> rootObjectMaps;
    public Info info => _info;

    public List<GameObject> RootObjectMaps
    {
        get => rootObjectMaps;
        set => rootObjectMaps = value;
    }

    public List<GameObject> EnvironmentLightObjects => environmentLightObjects;

    [ButtonMethod]
    public void Initialize()
    {
        var sunObject = GameObject.Find("n_sun");
        if (sunObject != null) info.sunShaftsTransform = sunObject.transform;
    }

    [Serializable]
    public class Info
    {
        [Header("Back Color")] public Color charaLightADVBackColor = Color.white;
        [Header("Back Strength")] public float charaLightADVBackintensity = 0.1f;

        [Header("Adv Character Light Setting")]
        public Color charaLightADVFrontColor = Color.white;

        [Header("Front (Key) Strength")] public float charaLightADVFrontintensity = 1f;
        [Header("Back Color")] public Color charaLightBackColor = Color.gray;
        [Header("Back Strength")] public float charaLightBackintensity = 0.1f;
        [Header("H Character Light Setting")] public Color charaLightFrontColor = Color.white;
        [Header("Front (Key) Strength")] public float charaLightFrontintensity = 1f;
        [Header("Aperture")] public float dofAperture;
        [Header("Focal Width")] public float dofFocalSize;
        [Header("Setting The Depth Of Field")] public bool dofUse;
        [Header("Color")] public Color fogColor;
        [Header("Fog Strength")] public float fogDensity;
        [Header("Background Fog")] public bool fogExcludeFarPixels;
        [Header("Fog Height")] public float fogHeight;
        [Header("Fog Height Density")] public float fogHeightDensity;
        [Header("Fog Settings")] public bool fogUse;
        [Header("Strength")] public float reflectProbeintensity;
        [Header("Reflect Probe Settings")] public Texture reflectProbeTexture;
        [Header("Growth")] public float sunShaftsBlurSize;
        [Header("Color")] public Color sunShaftsColor;
        [Header("Strength")] public float sunShaftsIntensity;
        [Header("Range")] public float sunShaftsMaxRadius;
        [Header("Threshold Color")] public Color sunShaftsThresholdColor;
        [Header("Shafts Caster")] public Transform sunShaftsTransform;
        [Header("Camera Sun Shafts Settings")] public bool sunShaftsUse;
        [Header("Display Object Settings")] public List<GameObject> visibleList = new List<GameObject>();
    }
}