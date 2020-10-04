using UnityEngine;


// ReSharper disable NotAccessedField.Local
// ReSharper disable InconsistentNaming
#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649
namespace AIProject
{
    public class EventPoint : Point
    {
        [SerializeField] private int _groupID;
        [SerializeField] private int _pointID = -1;
        [SerializeField] private Transform _commandBasePoint;
        [SerializeField] private Transform _labelPoint;
        [SerializeField] private CommandType _commandType;
        [SerializeField] private bool _enableRangeCheck = true;
        [SerializeField] private float _checkRadius = 1f;
    }
}