using System;
using System.Collections.Generic;
using MyBox;
using UnityEditor;
using UnityEngine;
using Object = UnityEngine.Object;

#if UNITY_EDITOR
public partial class HoohTools
{
    public void DrawLightProbeSetting(SerializedObject serializedObject)
    {
        foldoutProbeset = EditorGUILayout.Foldout(foldoutProbeset, "LightProbe Adjustment", true, _styles.Foldout);
        if (!foldoutProbeset) return;

        GUILayout.BeginHorizontal("box");
        if (inputNumber > 5.0f)
            sliderValue = 5.0f;
        else if (inputNumber < 1) sliderValue = 1;

        const string inputText = " ";
        sliderValue = EditorGUILayout.Slider(sliderValue, minSliderValue, maxSliderValue);

        if (Math.Abs(inputNumber - sliderValue) > 0.01f)
        {
            if (float.TryParse(inputText, out inputNumber))
                sliderValue = Mathf.Clamp(inputNumber, minSliderValue, maxSliderValue);
            else if (inputText.IsNullOrEmpty()) inputNumber = sliderValue;
        }

        EditorPrefs.SetFloat("hoohTool_probeStrength", sliderValue);

        if (GUILayout.Button(_icons["plus"], smallButton))
            _guiEventAction = () =>
            {
                ProbeIntensity.ScaleLightProbeData(sliderValue);
                ProbeIntensity.DisplayWarning();
            };

        if (GUILayout.Button(_icons["minus"], smallButton))
            _guiEventAction = () => { ProbeIntensity.ScaleLightProbeData(1 / Mathf.Abs(sliderValue)); };

        if (GUILayout.Button(_icons["reset"], smallButton))
            _guiEventAction = () =>
            {
                ProbeIntensity.ResetProbeData();
                ProbeIntensity.DisplayWarning();
            };

        GUILayout.EndHorizontal();
    }

    public static void ScaleLightsAndProbes()
    {
        var reflectionProbes = Resources.FindObjectsOfTypeAll<ReflectionProbe>();
        var lights = Resources.FindObjectsOfTypeAll<Light>();
        var undoObjects = new List<Object>();
        // Scale all lights by X.
        foreach (var light in lights)
        {
            undoObjects.Add(light);
            switch (light.type)
            {
                case LightType.Area:
                    light.areaSize = new Vector2(light.areaSize.x, light.areaSize.y) * LightScaleSize;
                    break;

                case LightType.Point:
                    light.range *= LightScaleSize;
                    break;

                case LightType.Spot:
                    light.range *= LightScaleSize;
                    break;
            }
        }

        // Scale all reflection probes by X.
        foreach (var probe in reflectionProbes)
        {
            undoObjects.Add(probe);
            probe.size = new Vector3(probe.size.x, probe.size.y, probe.size.z) * LightScaleSize;
        }

        Undo.RecordObjects(undoObjects.ToArray(), "Undo Light Scalings");
    }
}
#endif