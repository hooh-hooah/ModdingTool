#if UNITY_EDITOR
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using AIProject;
using hooh_ModdingTool.asm_Packer.Utility;
using MyBox;
using UnityEngine;

public class FindAssist
{
    public FindAssist(Transform transform)
    {
        Recalculate(transform);
    }

    public Dictionary<string, GameObject> DictObjName { get; private set; }
    public Dictionary<string, List<GameObject>> DictTagName { get; private set; }
    public Dictionary<string, SkinnedMeshRenderer> SkinnedMeshRenderers { get; private set; }
    public Dictionary<string, Renderer> Renderers { get; private set; }
    public Dictionary<string, MeshRenderer> MeshRenderers { get; private set; }
    public Dictionary<string, Collider> Colliders { get; private set; }
    
    public Dictionary<string, Point> Points { get; private set; }

    public void Recalculate(Transform transform)
    {
        SkinnedMeshRenderers = new Dictionary<string, SkinnedMeshRenderer>();
        MeshRenderers = new Dictionary<string, MeshRenderer>();
        Renderers = new Dictionary<string, Renderer>();
        Colliders = new Dictionary<string, Collider>();
        Points = new Dictionary<string, Point>();
        DictObjName = new Dictionary<string, GameObject>();
        DictTagName = new Dictionary<string, List<GameObject>>();

        foreach (var component in transform.GetComponentsInChildren<Component>(true))
        {
            var componentName = component.name;

            switch (component)
            {
                case SkinnedMeshRenderer skinnedMeshRenderer:
                    SkinnedMeshRenderers.Add(componentName, skinnedMeshRenderer);
                    break;
                case MeshRenderer meshRenderer:
                    MeshRenderers.Add(componentName, meshRenderer);
                    break;
                case Collider collider:
                    Colliders.Add(componentName, collider);
                    break;
                case Point point:
                    Points.Add(componentName, point);
                    break;
                case Transform transformComponent:
                    var gameObject = transformComponent.gameObject;
                    DictObjName[gameObject.name] = gameObject;
                    if (gameObject.tag.IsNullOrEmpty()) continue;
                    DictTagName.Insert(gameObject.tag, gameObject);
                    break;
            }

            switch (component)
            {
                case Renderer renderer:
                    Renderers.Add(componentName, renderer);
                    break;
            }
        }
    }

    public GameObject GetObjectFromName(string objName)
    {
        if (DictObjName == null) return null;
        DictObjName.TryGetValue(objName, out var result);
        return result;
    }

    // Token: 0x0600347A RID: 13434 RVA: 0x00134518 File Offset: 0x00132918
    public Transform GetTransformFromName(string objName)
    {
        if (DictObjName == null) return null;
        return DictObjName.TryGetValue(objName, out var gameObject) ? gameObject.transform : null;
    }

    public List<GameObject> GetObjectFromTag(string tagName)
    {
        if (DictTagName == null) return null;
        DictTagName.TryGetValue(tagName, out var result);
        return result;
    }
}
#endif