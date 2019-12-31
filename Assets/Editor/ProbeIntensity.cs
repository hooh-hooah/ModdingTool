using UnityEngine;
using UnityEditor;
using System;
using System.Collections.Generic;
using UnityEngine.Rendering;

[CanEditMultipleObjects]
public class ProbeIntensity : EditorWindow {
    private float maxSliderValue = 5.0f;
    static private float sliderValue = 2.0f;
    private float minSliderValue = 1.0f;
    private GUIStyle currentStyle = null;
    private Color textColor = new Color(0.71f, 0.71f, 0.71f);
    public float inputNumber = 2.0f;
    static public bool noBaked = false;

    public static List<float> inputValues = new List<float>();
    public static List<float> oldValuesList = new List<float>();

    public static Lightmapping.OnCompletedFunction completed;

    void Update() {
        CheckBaking();
    }

    bool CheckBaking() {
        if (Lightmapping.isRunning) {
            oldValuesList.Clear();
            return true;
        } else {
            StoreProbeData();
            return false;
        }
    }

    unsafe private static void ScaleLightProbeData(float scale) {
        DisplayWarning();
        inputValues.Add(scale);

        var probes = LightmapSettings.lightProbes.bakedProbes;
        if (probes == null) {
            Debug.LogError("No probes in the scene!");
            return;
        }

        var probeType = typeof(UnityEngine.Rendering.SphericalHarmonicsL2);
        var allFields = probeType.GetFields(System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.Instance);

        for (int j = 0; j < probes.Length; j++) {
            var probe = probes[j];

            float* probePointer = (float*)&probe;

            //Currently all of these are floats. If this changes, the code should be re-evaluated.
            for (int i = 0; i < allFields.Length; i++) {
                float* valueAddress = probePointer + i;
                float oldValue = *valueAddress;
                *valueAddress = oldValue * scale;
            }

            probes[j] = probe;
        }

        SetProbeData(probes);
    }


    unsafe private static void StoreProbeData() {
        if (LightmapSettings.lightProbes != null) {
            var probes = LightmapSettings.lightProbes.bakedProbes;
            var probeType = typeof(UnityEngine.Rendering.SphericalHarmonicsL2);
            var allFields = probeType.GetFields(System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.Instance);

            for (int j = 0; j < probes.Length; j++) {
                var probe = probes[j];

                float* probePointer = (float*)&probe;

                //Currently all of these are floats. If this changes, the code should be re-evaluated.
                for (int i = 0; i < allFields.Length; i++) {

                    float* valueAddress = probePointer + i;
                    float oldValue = *valueAddress;
                    oldValuesList.Add(oldValue);
                }

                probes[j] = probe;
            }

            SetProbeData(probes);
            inputValues.Clear();
        }
    }

    unsafe private static void ResetProbeData() {
        DisplayWarning();
        var probes = LightmapSettings.lightProbes.bakedProbes;
        var probeType = typeof(UnityEngine.Rendering.SphericalHarmonicsL2);
        var allFields = probeType.GetFields(System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.Instance);

        try {
            StoreProbeData();

        } finally {
        }

        for (int j = 0; j < probes.Length; j++) {
            var probe = probes[j];

            float* probePointer = (float*)&probe;

            //Currently all of these are floats. If this changes, the code should be re-evaluated.
            for (int i = 0; i < allFields.Length; i++) {
                float* valueAddress = probePointer + i;

                *valueAddress = oldValuesList[i];
            }

            probes[j] = probe;
        }

        SetProbeData(probes);
        inputValues.Clear();

    }

    [MenuItem("Tools/Light Probe Intensity")]
    public static void ShowWindow() {
        EditorWindow window = GetWindow(typeof(ProbeIntensity));
        window.Show();
    }

    public void OnGUI() {
        if (inputNumber > 5.0f) {
            sliderValue = 5.0f;
        } else if (inputNumber < 1) {
            sliderValue = 1;
        }

        InitStyles();
        GUILayout.Label(" Adjust the brightness of light probes");

        string inputText = " ";

        // Wrap everything in the designated GUI Area
        GUILayout.BeginArea(new Rect(10, 20, 260, 60));

        // Begin the singular Horizontal Group
        GUILayout.BeginHorizontal();

        GUILayout.Box("Scale Value ", currentStyle);

        if (inputNumber != sliderValue) {
            if (Single.TryParse(inputText, out inputNumber)) {
                sliderValue = Mathf.Clamp(inputNumber, minSliderValue, maxSliderValue);
            } else if (inputText == " ") {
                inputNumber = sliderValue;
            }
        }

        sliderValue = EditorGUILayout.Slider(sliderValue, minSliderValue, maxSliderValue);

        // End the Groups and Area
        GUILayout.EndHorizontal();
        GUILayout.EndArea();
        GUILayout.Space(70);
        GUILayout.BeginArea(new Rect(10, 60, 260, 60));

        GUILayout.BeginHorizontal();

        if (GUILayout.Button("Increase Intensity")) {

            ScaleLightProbeData(sliderValue);
            DisplayWarning();
        }

        if (GUILayout.Button("Decrease Intensity")) {
            ScaleLightProbeData(1 / Mathf.Abs(sliderValue));
        }

        GUILayout.EndHorizontal();
        GUILayout.EndArea();
        GUILayout.BeginArea(new Rect(10, 80, 260, 60));
        GUILayout.BeginHorizontal();

        if (GUILayout.Button("Reset Intensity")) {
            ResetProbeData();
            DisplayWarning();
        }

        GUILayout.EndHorizontal();
        GUILayout.EndArea();

    }

    private void InitStyles() {
        if (currentStyle == null) {
            currentStyle = new GUIStyle(GUI.skin.box);
            currentStyle.alignment = TextAnchor.MiddleLeft;
            currentStyle.normal.textColor = textColor;
        }
    }

    private Texture2D MakeTex(int width, int height, Color col) {
        Color[] pix = new Color[width * height];
        for (int i = 0; i < pix.Length; ++i) {
            pix[i] = col;
        }
        Texture2D result = new Texture2D(width, height);
        result.SetPixels(pix);
        result.Apply();
        return result;
    }

    public static float MultItems() {
        float result = 1.0f;
        for (int i = 0; i < inputValues.Count; i++) {
            result *= inputValues[i];
        }
        return result;
    }

    public static void DisplayWarning() {
        Light[] lights = FindObjectsOfType(typeof(Light)) as Light[];

        try {
            foreach (Light l in lights) {
                if (l.bakingOutput.isBaked == true) {
                    noBaked = false;
                    Debug.LogWarning("Realtime light information is not stored in light probes!");
                } else {
                    noBaked = true;
                }
            }
        } finally {
            foreach (Light l in lights) {
                if (l.bakingOutput.isBaked == false) {
                    Debug.LogWarning("No lights in the scene");
                }
            }
        }
    }

    public static void SetProbeData(UnityEngine.Rendering.SphericalHarmonicsL2[] probeData) {
        var lightProbes = LightmapSettings.lightProbes;

        lightProbes.bakedProbes = probeData;
        LightmapSettings.lightProbes = lightProbes;
        EditorUtility.SetDirty(lightProbes);
        SceneView.RepaintAll();
    }

}