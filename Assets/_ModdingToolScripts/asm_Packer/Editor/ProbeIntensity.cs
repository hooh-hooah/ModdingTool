#if UNITY_EDITOR
using System.Collections.Generic;
using System.Reflection;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

[CanEditMultipleObjects]
public class ProbeIntensity : EditorWindow
{
    private static float sliderValue = 2.0f;
    public static bool noBaked;

    public static List<float> inputValues = new List<float>();
    public static List<float> oldValuesList = new List<float>();

    public static Lightmapping.OnCompletedFunction completed;
    private GUIStyle currentStyle = null;
    public float inputNumber = 2.0f;
    private float maxSliderValue = 5.0f;
    private float minSliderValue = 1.0f;
    private Color textColor = new Color(0.71f, 0.71f, 0.71f);

    private void Update()
    {
        CheckBaking();
    }

    private bool CheckBaking()
    {
        if (Lightmapping.isRunning)
        {
            oldValuesList.Clear();
            return true;
        }

        StoreProbeData();
        return false;
    }

    public static unsafe void ScaleLightProbeData(float scale)
    {
        DisplayWarning();
        inputValues.Add(scale);

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
                    oldValuesList.Add(oldValue);
                }

                probes[j] = probe;
            }

            SetProbeData(probes);
            inputValues.Clear();
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

                *valueAddress = oldValuesList[i];
            }

            probes[j] = probe;
        }

        SetProbeData(probes);
        inputValues.Clear();
    }

    private Texture2D MakeTex(int width, int height, Color col)
    {
        var pix = new Color[width * height];
        for (var i = 0; i < pix.Length; ++i) pix[i] = col;
        var result = new Texture2D(width, height);
        result.SetPixels(pix);
        result.Apply();
        return result;
    }

    public static float MultItems()
    {
        var result = 1.0f;
        for (var i = 0; i < inputValues.Count; i++) result *= inputValues[i];
        return result;
    }

    public static void DisplayWarning()
    {
        var lights = FindObjectsOfType(typeof(Light)) as Light[];

        try
        {
            foreach (var l in lights)
                if (l.bakingOutput.isBaked)
                {
                    noBaked = false;
                    Debug.LogWarning("Realtime light information is not stored in light probes!");
                }
                else
                {
                    noBaked = true;
                }
        }
        finally
        {
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