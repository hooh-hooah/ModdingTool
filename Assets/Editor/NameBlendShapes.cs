using UnityEngine;
using UnityEditor;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System;

public class NameBlendShapes : MonoBehaviour {

    // Use this for initialization
    public FBSTargetInfo smrFBS;
    [MenuItem("BlendShapes/Name Temporal FBS Slots")]
    public static void Function()
    {
        SetNames();
    }

    static void SetNames()
    {
        GameObject[] selObj = Selection.gameObjects;

        foreach (var obj in Selection.gameObjects)
        {
            SkinnedMeshRenderer smr = obj.GetComponent<SkinnedMeshRenderer>();

            FBSTargetInfo queueComp = obj.GetComponent<FBSTargetInfo>();
            System.Type ourType = queueComp.GetType();
            FieldInfo fi = ourType.GetField("OpenName", BindingFlags.Public | BindingFlags.Instance);
            //Debug.Log(fi);
            fi.SetValue(queueComp, new string[] { "test" });
        }
    }
}
