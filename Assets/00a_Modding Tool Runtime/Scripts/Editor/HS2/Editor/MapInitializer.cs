using System;
using System.Collections.Generic;
using System.Linq;
using Map;
using UnityEditor;
using UnityEngine;
using Object = UnityEngine.Object;

public static partial class MapInitializer
{
    private static readonly string[] PpStrings = {"default", "user", "color"};

    private static readonly List<HPointType> HPointTypes = new List<HPointType>
    {
        new HPointType
        {
            ID = 0,
            Name = "Floor",
            KeyName = "yuka"
        },
        new HPointType
        {
            ID = 1,
            Name = "Standing",
            KeyName = "tachi"
        },
        new HPointType
        {
            ID = 2,
            Name = "Wall",
            KeyName = "kabe"
        },
        new HPointType
        {
            ID = 3,
            Name = "Chair",
            KeyName = "isu"
        },
        new HPointType
        {
            ID = 4,
            NoSpecial = new[]
            {
                5
            },
            Name = "Desk",
            KeyName = "tsukue",
            Comment = "角ｵﾅ"
        },
        new HPointType
        {
            ID = 5,
            Name = "Armchair",
            KeyName = "tesuri_isu",
            Comment = "椅子と同じ"
        },
        new HPointType
        {
            ID = 6,
            Name = "Long Chair",
            KeyName = "naga_isu",
            Comment = "椅子と同じ"
        },
        new HPointType
        {
            ID = 7,
            Name = "Sofa Bed",
            KeyName = "sofa_bed"
        },
        new HPointType
        {
            ID = 8,
            Name = "Sofa Table",
            KeyName = "sofa_table",
            Comment = "そんなものはない"
        },
        new HPointType
        {
            ID = 9,
            Name = "Counter",
            KeyName = "counter"
        },
        new HPointType
        {
            ID = 10,
            Name = "Stairs",
            KeyName = "kaidan"
        },
        new HPointType
        {
            ID = 11,
            Name = "Bath",
            KeyName = "ofuro"
        },
        new HPointType
        {
            ID = 12,
            Name = "Shower",
            KeyName = "shower"
        },
        new HPointType
        {
            ID = 13,
            Name = "Western-style Toilet",
            KeyName = "yoshiki_toire"
        },
        new HPointType
        {
            ID = 14,
            Name = "Japanese-style Toilet",
            KeyName = "washiki_toire"
        },
        new HPointType
        {
            ID = 15,
            Name = "Glory Hole",
            KeyName = "glory_hole"
        },
        new HPointType
        {
            ID = 16,
            Name = "Soap Mattress",
            KeyName = "sopu_matto",
            Comment = "未実装"
        },
        new HPointType
        {
            ID = 17,
            Name = "Triangle Horse",
            KeyName = "mokuba"
        },
        new HPointType
        {
            ID = 18,
            Name = "Inspection Chair",
            KeyName = "bundendai"
        },
        new HPointType
        {
            ID = 19,
            Name = "Restraint",
            KeyName = "kosokudai"
        },
        new HPointType
        {
            ID = 20,
            Name = "Guillotine",
            KeyName = "guillotine"
        },
        new HPointType
        {
            ID = 21,
            Name = "Dildo",
            KeyName = "dildo"
        },
        new HPointType
        {
            ID = 22,
            Name = "Restraint Chair",
            KeyName = "kosokuisu"
        }
    };

    private static readonly string mapName = "map";

    public static GameObject MakeNewWrapper(GameObject root, string name)
    {
        var gameObject = new GameObject {name = name};
        gameObject.transform.parent = root.transform;
        return gameObject;
    }

    [MenuItem("hooh Tools/Initialize AI Map", false)]
    public static void InitializeAIMap()
    {
    }

    [MenuItem("hooh Tools/Initialize HS2 Map", false)]
    public static void InitializeHS2Map()
    {
        var allMapObjects = Object.FindObjectsOfType<Transform>();

        var root = new GameObject();
        root.name = "Map";
        var mapVisibleList = root.AddComponent<MapVisibleList>();
        var sunLightInfo = root.AddComponent<SunLightInfo>();
        var lightmapPrefab = root.AddComponent<LightmapPrefab>();

        // Reflection Probe
        var lightProbes = MakeNewWrapper(root, "Light Probes");
        var reflectionProbes = MakeNewWrapper(root, "Reflection Probes");
        var ppVolume = MakeNewWrapper(root, $"PostVolume_{mapName}");
        var lightGroup = MakeNewWrapper(root, "Light Group");
        var mapObjectGroup = MakeNewWrapper(root, "Map Object Group");
        var hPointGroup = MakeNewWrapper(root, $"hpoint_{mapName}");
        var fluidCollisionGroup = MakeNewWrapper(root, $"fluidCollsionGroup_{mapName}");
        var collisionGroup = MakeNewWrapper(root, $"colGroup_{mapName}");
        var soundGroup = MakeNewWrapper(root, "env_00");

        // Post Processing Volume
        InitializePostProcessing(ppVolume);

        // HPoint Groups
        var hPointList = hPointGroup.AddComponent<HPointList>();
        foreach (var hpointType in HPointTypes)
        {
            var hPointLocationGroup = new GameObject {name = $"hpoint_{hpointType.KeyName}_gp"};
            hPointLocationGroup.transform.parent = hPointGroup.transform;

            var startPoint = new GameObject {name = "hpoint_start"};
            startPoint.transform.parent = hPointLocationGroup.transform;
            var hPointComponent = startPoint.AddComponent<HPoint>();
            hPointComponent.id = hpointType.ID;
            hPointComponent.Data = new HPoint.HpointData();
            if (hpointType.NoForeplay != null)
                hPointComponent.Data.notMotion[0].motionID = hpointType.NoForeplay.ToList();
            if (hpointType.NoJobs != null) hPointComponent.Data.notMotion[1].motionID = hpointType.NoJobs.ToList();
            if (hpointType.NoInsert != null) hPointComponent.Data.notMotion[2].motionID = hpointType.NoInsert.ToList();
            if (hpointType.NoSpecial != null)
                hPointComponent.Data.notMotion[3].motionID = hpointType.NoSpecial.ToList();
            if (hpointType.NoLesbo != null) hPointComponent.Data.notMotion[4].motionID = hpointType.NoLesbo.ToList();
            if (hpointType.NoVarious != null)
                hPointComponent.Data.notMotion[5].motionID = hpointType.NoVarious.ToList();
        }

        // Sound Group Setting
        var mapEnvSetting = soundGroup.AddComponent<MapEnvSetting>();

        sunLightInfo.RootObjectMaps = new List<GameObject> {soundGroup, mapObjectGroup};

        var audioList = new List<AudioSource>();
        allMapObjects.ToList().ForEach(x =>
        {
            if (x.parent == null) x.parent = mapObjectGroup.transform;

            var audio = x.GetComponent<AudioSource>();
            if (audio != null)
            {
                audioList.Add(audio);
                x.parent = soundGroup.transform;
            }

            var light = x.GetComponent<Light>();
            if (light != null)
                try
                {
                    x.parent = lightGroup.transform;
                }
                catch (Exception)
                {
                    // ignored
                }

            var refProbe = x.GetComponent<ReflectionProbe>();
            if (refProbe != null) x.parent = reflectionProbes.transform;

            var lightProbe = x.GetComponent<LightProbeGroup>();
            if (lightProbe != null) x.parent = lightProbe.transform;
        });

        mapEnvSetting.AudioSources = audioList.ToArray();
    }

    private struct HPointType
    {
#pragma warning disable 649
        public string Name;
        public string KeyName;
        public string Comment;
        public int[] NoForeplay;
        public int[] NoJobs;
        public int[] NoInsert;
        public int[] NoSpecial;
        public int[] NoLesbo;
        public int[] NoVarious;
        public bool HasLimit;
        public int ID;
#pragma warning restore 649
    }
}