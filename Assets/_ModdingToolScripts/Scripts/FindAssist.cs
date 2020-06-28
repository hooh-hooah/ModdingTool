using System;
using System.Collections.Generic;
using UnityEngine;

public class FindAssist
{
	public Dictionary<string, GameObject> dictObjName { get; private set; }

	public Dictionary<string, List<GameObject>> dictTagName { get; private set; }

	public void Initialize(Transform trf)
	{
		this.dictObjName = new Dictionary<string, GameObject>();
		this.dictTagName = new Dictionary<string, List<GameObject>>();
		this.FindAll(trf);
	}

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
