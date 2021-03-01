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
    public class DevicePoint : Point
    {
        [SerializeField] private int _id;
        [SerializeField] private bool _enabledRangeCheck = true;
        [SerializeField] private float _radius = 1f;
        [SerializeField] private Transform _commandBasePoint;
        [SerializeField] private Transform _pivotPoint;
        [SerializeField] private List<Transform> _recoverPoints = new List<Transform>();
        [SerializeField] private Transform _playerRecoverPoint;
        [SerializeField] private Animator _animator;
    }
}