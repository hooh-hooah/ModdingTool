using UnityEngine;

// ReSharper disable NotAccessedField.Local
// ReSharper disable InconsistentNaming
#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649
namespace AIProject
{
    public class ShipPoint : Point
    {
        [SerializeField] private bool _enableRangeCheck = true;
        [SerializeField] private float _radius = 1f;
        [SerializeField] private Transform _commandBasePoint;
        [SerializeField] private Transform _startPointFromMigrate;
    }
}