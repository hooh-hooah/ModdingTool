using System;
using System.Collections.Generic;
using UnityEngine;

public class DickPuller : MonoBehaviour
{
    // you don't want to find whole scene to find navigator instances.
    public static List<DickPuller> Instances = new List<DickPuller>();

    private void Start()
    {
        Instances.Add(this);
    }

    private void OnDestroy()
    {
        Instances.Remove(this);
    }
}