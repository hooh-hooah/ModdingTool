using UnityEngine;
using UnityEditor;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System;

public class RenderQueueSetting : EditorWindow {


    public int steps = 1;
    public int max = 3600;
    bool orderToggle = false;
    // Use this for initialization
    [MenuItem("HoneySelect/SetRenderQueues")]
    static void Init ()
    {
        RenderQueueSetting window = (RenderQueueSetting)EditorWindow.GetWindow(typeof(RenderQueueSetting));
        window.Show();        
    }
	
	// Update is called once per frame
	void OnGUI() {
        GUILayout.Label("Set Render Queues", EditorStyles.boldLabel);
        max = EditorGUILayout.IntField("Max Render Queue", max);
        steps = EditorGUILayout.IntField("Steps", steps);
        orderToggle = EditorGUILayout.Toggle("Descending", orderToggle);
        if (GUILayout.Button("Order"))
            SetQueues(max, orderToggle, steps);
    }

    static void SetQueues(int maxqueue, bool order, int queuesteps)
    {
        int qsteps = queuesteps;
        int maxv = maxqueue;
        GameObject[] selObj = Selection.gameObjects;                

        foreach (var obj in Selection.gameObjects.OrderByWithDirection(go => go.name, order))
        {
            SetRenderQueue queueComp = obj.AddComponent<SetRenderQueue>();
            System.Type ourType = queueComp.GetType();
            FieldInfo fi = ourType.GetField("m_queues", BindingFlags.NonPublic | BindingFlags.Instance);
            //Debug.Log(fi);
            fi.SetValue(queueComp, new int[] { maxv });
            maxv = maxv - queuesteps;
        }
    }

    [MenuItem("HoneySelect/Remove SetRenderQueues")]
    public static void PackageTextureAssetBundle()
    {
        foreach (var obj in Selection.gameObjects.OrderByWithDirection(go => go.name, true))
        {
            SetRenderQueue queueComp = obj.GetComponent<SetRenderQueue>();
            if (queueComp)
                DestroyImmediate(queueComp);
        }
    }

}

public static class ExtensionMethods
{
    public static IOrderedEnumerable<TSource> OrderByWithDirection<TSource, TKey>
        (this IEnumerable<TSource> source,
         Func<TSource, TKey> keySelector,
         bool descending)
    {
        return descending ? source.OrderByDescending(keySelector)
                          : source.OrderBy(keySelector);
    }
}