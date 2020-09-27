using System.Collections.Generic;
using UnityEngine;

public class FindAssist
{
    private Dictionary<string, GameObject> DictObjName { get; set; }

    private Dictionary<string, List<GameObject>> DictTagName { get; set; }

    public void Initialize(Transform trf)
    {
        DictObjName = new Dictionary<string, GameObject>();
        DictTagName = new Dictionary<string, List<GameObject>>();
        FindAll(trf);
    }

    private void FindAll(Transform trf)
    {
        if (!DictObjName.ContainsKey(trf.name)) DictObjName[trf.name] = trf.gameObject;
        var tag = trf.tag;
        if (string.Empty != tag)
        {
            if (!DictTagName.TryGetValue(tag, out var list))
            {
                list = new List<GameObject>();
                DictTagName[tag] = list;
            }

            list.Add(trf.gameObject);
        }

        for (var i = 0; i < trf.childCount; i++) FindAll(trf.GetChild(i));
    }

    public GameObject GetObjectFromName(string objName)
    {
        if (DictObjName == null) return null;
        DictObjName.TryGetValue(objName, out var result);
        return result;
    }

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