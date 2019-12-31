using System;
using System.Collections.Generic;
using UnityEngine;

public class FindAssist
{
    // Token: 0x1700095B RID: 2395
    // (get) Token: 0x06003473 RID: 13427 RVA: 0x001343FC File Offset: 0x001327FC
    // (set) Token: 0x06003474 RID: 13428 RVA: 0x00134404 File Offset: 0x00132804
    public Dictionary<string, GameObject> dictObjName { get; private set; }

    // Token: 0x1700095C RID: 2396
    // (get) Token: 0x06003475 RID: 13429 RVA: 0x0013440D File Offset: 0x0013280D
    // (set) Token: 0x06003476 RID: 13430 RVA: 0x00134415 File Offset: 0x00132815
    public Dictionary<string, List<GameObject>> dictTagName { get; private set; }

    // Token: 0x06003477 RID: 13431 RVA: 0x0013441E File Offset: 0x0013281E
    public void Initialize(Transform trf)
    {
        this.dictObjName = new Dictionary<string, GameObject>();
        this.dictTagName = new Dictionary<string, List<GameObject>>();
        this.FindAll(trf);
    }

    // Token: 0x06003478 RID: 13432 RVA: 0x00134440 File Offset: 0x00132840
    private void FindAll(Transform trf)
    {
        if (!this.dictObjName.ContainsKey(trf.name))
        {
            this.dictObjName[trf.name] = trf.gameObject;
        }
        string tag = trf.tag;
        if (string.Empty != tag)
        {
            List<GameObject> list = null;
            if (!this.dictTagName.TryGetValue(tag, out list))
            {
                list = new List<GameObject>();
                this.dictTagName[tag] = list;
            }
            list.Add(trf.gameObject);
        }
        for (int i = 0; i < trf.childCount; i++)
        {
            this.FindAll(trf.GetChild(i));
        }
    }

    // Token: 0x06003479 RID: 13433 RVA: 0x001344EC File Offset: 0x001328EC
    public GameObject GetObjectFromName(string objName)
    {
        if (this.dictObjName == null)
        {
            return null;
        }
        GameObject result = null;
        this.dictObjName.TryGetValue(objName, out result);
        return result;
    }

    // Token: 0x0600347A RID: 13434 RVA: 0x00134518 File Offset: 0x00132918
    public Transform GetTransformFromName(string objName)
    {
        if (this.dictObjName == null)
        {
            return null;
        }
        GameObject gameObject = null;
        if (this.dictObjName.TryGetValue(objName, out gameObject))
        {
            return gameObject.transform;
        }
        return null;
    }

    // Token: 0x0600347B RID: 13435 RVA: 0x00134550 File Offset: 0x00132950
    public List<GameObject> GetObjectFromTag(string tagName)
    {
        if (this.dictTagName == null)
        {
            return null;
        }
        List<GameObject> result = null;
        this.dictTagName.TryGetValue(tagName, out result);
        return result;
    }
}