using System;
using UnityEngine;


// ReSharper disable NotAccessedField.Local
// ReSharper disable InconsistentNaming
#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649
namespace AIProject
{
    [Serializable]
    public class MapItemKeyValuePair
    {
        [SerializeField] private int _id;

        [SerializeField] private GameObject _itemObj;
    }
}