using System.Collections.Generic;
using UnityEngine;

// ReSharper disable NotAccessedField.Local
// ReSharper disable InconsistentNaming
#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649
namespace AIProject
{
    public class BasePoint : Point
    {
        [SerializeField] private int _id;
        [SerializeField] private int _areaIDInHousing;
        [SerializeField] private bool _enabledRangeCheck = true;
        [SerializeField] private float _radius = 1f;
        [SerializeField] private bool _isHousing = true;
        [SerializeField] private Transform _commandBasePoint;
        [SerializeField] private Transform _housingCenter;
        [SerializeField] private Transform _warpPoint;
        [SerializeField] private List<Transform> _recoverPoints = new List<Transform>();
    }
}