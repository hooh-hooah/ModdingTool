using System.Runtime.CompilerServices;
using CameraEffector;
using MyBox;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

public static partial class MapInitializer
{
    private readonly struct VolumeInfo
    {
        public readonly string name;
        public readonly VolumeType type;
        public readonly int priority;
        public readonly int weight;

        public VolumeInfo(string name, VolumeType type, int priority, int weight)
        {
            this.name = name;
            this.type = type;
            this.priority = priority;
            this.weight = weight;
        }
    }

    private enum VolumeType
    {
        Default,
        Color
    }

    private static readonly VolumeInfo[] VolumeNames =
    {
        new VolumeInfo("default", VolumeType.Default, 0, 1),
        new VolumeInfo("user", VolumeType.Default, 1, 1),
        new VolumeInfo("color", VolumeType.Color, 2, 0),
    };

    private static PostProcessProfile GetDefaultPostProcessingProfile(VolumeType volumeType)
    {
        return Resources.Load<PostProcessProfile>(volumeType == VolumeType.Default ? "hs2_default" : "hs2_default_color")
               ?? ScriptableObject.CreateInstance<PostProcessProfile>();
    }

    private static void CreateDefaultPostProcessingVolume(GameObject postProcessingWrapper, VolumeInfo volumeInfo)
    {
        var gameObject = new GameObject {name = $"PostProcessVolume ({volumeInfo.name})", layer = 8};
        // Assign Post Processing 

        var postProcessVolume = gameObject.AddComponent<PostProcessVolume>();
        gameObject.transform.parent = postProcessingWrapper.transform;
        postProcessVolume.isGlobal = true;
        postProcessVolume.sharedProfile = GetDefaultPostProcessingProfile(volumeInfo.type);
        postProcessVolume.profile = GetDefaultPostProcessingProfile(volumeInfo.type);
        postProcessVolume.weight = volumeInfo.weight;
        postProcessVolume.priority = volumeInfo.priority;

        if (volumeInfo.type != VolumeType.Default) return;
        var effectorVolume = gameObject.AddComponent<ConfigEffectorVolume>();
        effectorVolume.postProcessVolume = postProcessVolume;
        var reflectionProbe = Object.FindObjectOfType<ReflectionProbe>();
        if (reflectionProbe != null)
        {
            effectorVolume.rp = reflectionProbe;
        }
    }

    private static void InitializePostProcessing(GameObject postProcessingWrapper)
    {
        foreach (var volumeInfo in VolumeNames)
        {
            CreateDefaultPostProcessingVolume(postProcessingWrapper, volumeInfo);
        }
    }
}