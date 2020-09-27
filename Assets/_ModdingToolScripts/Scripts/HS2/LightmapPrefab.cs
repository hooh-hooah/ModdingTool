using System;
using System.Linq;
using MyBox;
using UnityEngine;


#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649
[ExecuteInEditMode]
public class LightmapPrefab : MonoBehaviour
{
    [SerializeField] private LightmapParameter[] lightmapParameters;

    private void Start()
    {
        Resetup();
    }

    [ButtonMethod]
    private void Setup()
    {
        var array = (from v in GetComponentsInChildren<Renderer>() where v.enabled && v.lightmapIndex >= 0 select v).ToArray();
        lightmapParameters = new LightmapParameter[array.Length];
        for (var i = 0; i < array.Length; i++)
        {
            var renderer = array[i];
            lightmapParameters[i] = new LightmapParameter {lightmapIndex = renderer.lightmapIndex, scaleOffset = renderer.lightmapScaleOffset, renderer = renderer};
        }
    }

    [ButtonMethod]
    public void Resetup()
    {
        if (lightmapParameters == null) return;
        var num = lightmapParameters.Length;
        for (var i = 0; i < num; i++)
            if (lightmapParameters[i] != null)
                lightmapParameters[i].UpdateLightmapUVs();
    }

    [Serializable]
    private class LightmapParameter
    {
        public int lightmapIndex = -1;
        public Renderer renderer;
        public Vector4 scaleOffset = Vector4.zero;

        public void UpdateLightmapUVs()
        {
            if (renderer == null) return;
            if (lightmapIndex < 0) return;
            renderer.lightmapScaleOffset = scaleOffset;
            renderer.lightmapIndex = lightmapIndex;
        }
    }
}