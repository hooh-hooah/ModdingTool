#if UNITY_EDITOR
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

[CanEditMultipleObjects]
public class ProbeIntensity : Editor
{
    private static readonly List<float> InputValues = new List<float>();
    private static readonly List<float> OldValuesList = new List<float>();

    public static unsafe void ScaleLightProbeData(float scale)
    {
        DisplayWarning();
        InputValues.Add(scale);

        var probes = LightmapSettings.lightProbes ? LightmapSettings.lightProbes.bakedProbes : null;
        if (probes == null)
        {
            Debug.LogError("There is no light probe in the scene.");
            return;
        }

        var probeType = typeof(SphericalHarmonicsL2);
        var allFields = probeType.GetFields(BindingFlags.NonPublic | BindingFlags.Public | BindingFlags.Instance);

        for (var j = 0; j < probes.Length; j++)
        {
            var probe = probes[j];

            var probePointer = (float*) &probe;

            //Currently all of these are floats. If this changes, the code should be re-evaluated.
            for (var i = 0; i < allFields.Length; i++)
            {
                var valueAddress = probePointer + i;
                var oldValue = *valueAddress;
                *valueAddress = oldValue * scale;
            }

            probes[j] = probe;
        }

        SetProbeData(probes);
    }


    public static unsafe void StoreProbeData()
    {
        if (LightmapSettings.lightProbes != null)
        {
            var probes = LightmapSettings.lightProbes.bakedProbes;
            var probeType = typeof(SphericalHarmonicsL2);
            var allFields = probeType.GetFields(BindingFlags.NonPublic | BindingFlags.Public | BindingFlags.Instance);

            for (var j = 0; j < probes.Length; j++)
            {
                var probe = probes[j];

                var probePointer = (float*) &probe;

                //Currently all of these are floats. If this changes, the code should be re-evaluated.
                for (var i = 0; i < allFields.Length; i++)
                {
                    var valueAddress = probePointer + i;
                    var oldValue = *valueAddress;
                    OldValuesList.Add(oldValue);
                }

                probes[j] = probe;
            }

            SetProbeData(probes);
            InputValues.Clear();
        }
    }

    public static unsafe void ResetProbeData()
    {
        DisplayWarning();
        var probes = LightmapSettings.lightProbes.bakedProbes;
        var probeType = typeof(SphericalHarmonicsL2);
        var allFields = probeType.GetFields(BindingFlags.NonPublic | BindingFlags.Public | BindingFlags.Instance);

        StoreProbeData();

        for (var j = 0; j < probes.Length; j++)
        {
            var probe = probes[j];

            var probePointer = (float*) &probe;

            //Currently all of these are floats. If this changes, the code should be re-evaluated.
            for (var i = 0; i < allFields.Length; i++)
            {
                var valueAddress = probePointer + i;

                *valueAddress = OldValuesList[i];
            }

            probes[j] = probe;
        }

        SetProbeData(probes);
        InputValues.Clear();
    }

    public static float MultItems()
    {
        return InputValues.Aggregate(1.0f, (current, t) => current * t);
    }

    public static void DisplayWarning()
    {
        var lights = FindObjectsOfType(typeof(Light)) as Light[];

        try
        {
            if (lights == null) return;
            foreach (var l in lights)
                if (l.bakingOutput.isBaked)
                {
                    Debug.LogWarning("Realtime light information is not stored in light probes!");
                }
        }
        finally
        {
            if (lights != null)
                foreach (var l in lights)
                    if (l.bakingOutput.isBaked == false)
                        Debug.LogWarning("No lights in the scene");
        }
    }

    public static void SetProbeData(SphericalHarmonicsL2[] probeData)
    {
        var lightProbes = LightmapSettings.lightProbes;

        lightProbes.bakedProbes = probeData;
        LightmapSettings.lightProbes = lightProbes;
        EditorUtility.SetDirty(lightProbes);
        SceneView.RepaintAll();
    }
}
#endif