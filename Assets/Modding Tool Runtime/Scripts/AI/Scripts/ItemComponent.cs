using System;
using System.Collections.Generic;
using System.Linq;
using AIProject;
using AIProject.Animal;
using MyBox;
using UnityEditor;
using UnityEngine;

namespace Housing
{
    [AddComponentMenu("AI Furniture ItemComponent")]
    [DisallowMultipleComponent]
    public class ItemComponent : MonoBehaviour
    {
        [Header("Colorable Renderer Information")]
        public Info[] renderers;

        public Color defColor1 = Color.white;
        public Color defColor2 = Color.white;
        public Color defColor3 = Color.white;
        [ColorUsage(false, true)] public Color defEmissionColor = Color.clear;
        [Header("Activity Points")] public ActionPoint[] actionPoints;
        public FarmPoint[] farmPoints;
        public PetHomePoint[] petHomePoints;
        public JukePoint[] jukePoints;
        public CraftPoint[] craftPoints;
        public LightSwitchPoint[] lightSwitchPoints;
        public HPoint[] hPoints;
        [Header("Option GameObjects")] public GameObject[] objOption;
        [Header("Collision Information")] public ColInfo[] colInfos;
        [Header("Adjustable Size")] public bool autoSize = true;
        public Vector3 min = Vector3.zero;
        public Vector3 max = Vector3.zero;
        [Header("Detect Overlap")] public bool overlap;
        public Collider[] overlapColliders;
        [Header("Initial Position")] public Vector3 initPos = Vector3.zero;

        [Serializable]
        public class MaterialInfo
        {
            public bool isColor1;
            public bool isColor2;
            public bool isColor3;
            public bool isEmission;
        }

        [Serializable]
        public class ColInfo
        {
            public Collider[] colliders;
            public Renderer[] renderers;
        }

        [Serializable]
        public class Info
        {
            public MeshRenderer meshRenderer;
            public MaterialInfo[] materialInfos;
        }

#if UNITY_EDITOR
        [ButtonMethod]
        public void InitializeItemMultiple()
        {
            Selection.objects
                .OfType<GameObject>()
                .Select(o => o.GetComponent<ItemComponent>())
                .ToList()
                .ForEach(i => { i.InitializeItem(); });
        }

        [ButtonMethod]
        public void InitializeItem()
        {
            gameObject.layer = 11;
            if (gameObject == null) return;
            var findAssist = new FindAssist(transform);

            colInfos = new[]
            {
                new ColInfo
                {
                    renderers = findAssist.Renderers.Values.ToArray(),
                    colliders = findAssist.Colliders.Values.ToArray()
                }
            };

            var renderersList = new List<Info>();
            findAssist.Renderers.Values.ForEach(x =>
            {
                if (x is MeshRenderer meshRenderer)
                    renderersList.Add(new Info
                    {
                        meshRenderer = meshRenderer,
                        materialInfos = meshRenderer.sharedMaterials.Select(mat =>
                        {
                            var shader = mat.shader;
                            return new MaterialInfo
                            {
                                isColor1 = shader.HasProperty("_Color"),
                                isColor2 = shader.HasProperty("_Color2"),
                                isColor3 = shader.HasProperty("_Color3"),
                                isEmission = shader.HasProperty("_Emission") && mat.GetColor("_Emission") != Color.black
                            };
                        }).ToArray()
                    });

                x.gameObject.layer = 11;
            });
            renderers = renderersList.ToArray();

            InitializePoints(findAssist);

            overlap = false;
            autoSize = true;
            min = Vector3.one * -2;
            max = Vector3.one * 2;
            defColor1 = Color.white;
            defColor2 = Color.white;
            defColor3 = Color.white;
            defEmissionColor = Color.black;

            EditorUtility.SetDirty(this);
        }

        [ButtonMethod]
        public void RecalculatePoints()
        {
            InitializePoints(new FindAssist(transform));
            EditorUtility.SetDirty(this);
        }

        public void InitializePoints(FindAssist findAssist)
        {
            if (findAssist == null) findAssist = new FindAssist(transform);

            var typeGroups = findAssist.Points.Values
                .GroupBy(x => x.GetType(), x => x)
                .ToDictionary(x => x.Key, x => x.ToArray());

            if (typeGroups.TryGetValue(typeof(ActionPoint), out var aPoints))
                actionPoints = (ActionPoint[]) aPoints;
            if (typeGroups.TryGetValue(typeof(FarmPoint), out var fPoints))
                farmPoints = (FarmPoint[]) fPoints;
            if (typeGroups.TryGetValue(typeof(PetHomePoint), out var pPoints))
                petHomePoints = (PetHomePoint[]) pPoints;
            if (typeGroups.TryGetValue(typeof(JukePoint), out var jPoints))
                jukePoints = (JukePoint[]) jPoints;
            if (typeGroups.TryGetValue(typeof(CraftPoint), out var cPoints))
                craftPoints = (CraftPoint[]) cPoints;
            if (typeGroups.TryGetValue(typeof(LightSwitchPoint), out var lPoints))
                lightSwitchPoints = (LightSwitchPoint[]) lPoints;
        }
#endif
    }
}