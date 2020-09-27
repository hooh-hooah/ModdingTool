#if UNITY_EDITOR
using System.Collections.Generic;
using System.Linq;
using hooh_ModdingTool.asm_Packer.Utility;
using MyBox;
using UnityEngine;

public class FindAssist
{
    public FindAssist(Transform transform)
    {
        Recalculate(transform);
        FindAll(transform);
    }

    public Dictionary<string, GameObject> DictObjName { get; private set; }
    public Dictionary<string, List<GameObject>> DictTagName { get; private set; }
    public Dictionary<string, SkinnedMeshRenderer> SkinnedMeshRenderers { get; private set; }
    public Dictionary<string, Renderer> Renderers { get; private set; }
    public Dictionary<string, MeshRenderer> MeshRenderers { get; private set; }

    public void Recalculate(Transform transform)
    {
        SkinnedMeshRenderers = new Dictionary<string, SkinnedMeshRenderer>();
        MeshRenderers = new Dictionary<string, MeshRenderer>();
        Renderers = new Dictionary<string, Renderer>();

        foreach (var renderer in transform.GetComponentsInChildren<Renderer>(true))
            switch (renderer)
            {
                case SkinnedMeshRenderer skinnedMeshRenderer:
                    SkinnedMeshRenderers.Add(renderer.name, skinnedMeshRenderer);
                    break;
                case MeshRenderer meshRenderer:
                    MeshRenderers.Add(renderer.name, meshRenderer);
                    break;
                default:
                    Renderers.Add(renderer.name, renderer);
                    break;
            }

        DictObjName = new Dictionary<string, GameObject>();
        DictTagName = new Dictionary<string, List<GameObject>>();
    }

    private void FindAll(Component transform)
    {
        foreach (var gameObject in transform.GetComponentsInChildren<Transform>(true).Select(x => x.gameObject))
        {
            DictObjName[gameObject.name] = gameObject;
            if (gameObject.tag.IsNullOrEmpty()) continue;
            DictTagName.Insert(gameObject.tag, gameObject);
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