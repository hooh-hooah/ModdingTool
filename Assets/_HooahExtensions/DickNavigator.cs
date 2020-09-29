using System;
using System.Collections.Generic;
using UnityEngine;

public class DickNavigator : MonoBehaviour
{
    // you don't want to find whole scene to find navigator instances.
    public static List<DickNavigator> Instances = new List<DickNavigator>();
    // These two shit cannot be null.
    public Transform dickMidPoint;
    public Transform dickEndPoint;

    private void Start()
    {
        Instances.Add(this);
    }

    private void OnDestroy()
    {
        Instances.Remove(this);
    }
    
    #if UNITY_EDITOR
    private void OnDrawGizmos()
    {
        Gizmos.color = Color.blue;
        Gizmos.DrawSphere(dickMidPoint.transform.position, .1f);
        Gizmos.color = Color.red;
        Gizmos.DrawSphere(dickEndPoint.transform.position, .1f);
    }
    #endif
}