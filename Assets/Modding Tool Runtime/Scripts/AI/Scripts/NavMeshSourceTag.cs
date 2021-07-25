using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using UnityEngine;
using UnityEngine.AI;

// ReSharper disable NotAccessedField.Local
// ReSharper disable InconsistentNaming
#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649

[DefaultExecutionOrder(-200)]
public class NavMeshSourceTag : MonoBehaviour
{
    public static Dictionary<GameObject, Info> m_Meshes = new Dictionary<GameObject, Info>();

    private void OnEnable()
    {
        var component = GetComponent<MeshFilter>();
        if (component == null) return;
        if (!m_Meshes.ContainsKey(gameObject))
        {
            m_Meshes.Add(gameObject,
                new Info {MeshFilter = component, NavMeshModifier = GetComponent<NavMeshModifier>()});
        }
        else
        {
            var info = m_Meshes[gameObject];
            info.MeshFilter = component;
            info.NavMeshModifier = GetComponent<NavMeshModifier>();
        }
    }

    private void OnDisable()
    {
        m_Meshes.Remove(gameObject);
    }

    public static void Collect(ref List<NavMeshBuildSource> sources, int _defaultArea = 0)
    {
        sources.Clear();
        var enumerable = from v in m_Meshes.Values
            where v.MeshFilter != null
            where v.MeshFilter.sharedMesh != null
            where !v.Ignore
            select v;
        foreach (var info in enumerable)
        {
            NavMeshBuildSource item = default;
            item.shape = NavMeshBuildSourceShape.Mesh;
            item.sourceObject = info.MeshFilter.sharedMesh;
            item.transform = info.MeshFilter.transform.localToWorldMatrix;
            item.area = !info.OverrideArea ? _defaultArea : info.Area;
            sources.Add(item);
        }
    }

    public class Info
    {
        public MeshFilter MeshFilter { get; set; }
        public NavMeshModifier NavMeshModifier { get; set; }

        public bool Ignore
        {
            [CompilerGenerated]
            get => NavMeshModifier && NavMeshModifier.isActiveAndEnabled & NavMeshModifier.ignoreFromBuild;
        }

        public bool OverrideArea
        {
            [CompilerGenerated]
            get => NavMeshModifier && NavMeshModifier.isActiveAndEnabled & NavMeshModifier.overrideArea;
        }

        public int Area
        {
            [CompilerGenerated] get => !NavMeshModifier ? 0 : NavMeshModifier.area;
        }
    }
}