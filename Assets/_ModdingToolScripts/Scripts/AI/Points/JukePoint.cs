using UnityEngine;


// ReSharper disable NotAccessedField.Local
// ReSharper disable InconsistentNaming
#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649
namespace AIProject
{
    public class JukePoint : Point
    {
        [SerializeField] private int _id;
        [SerializeField] private bool _isCylinderCheck;
        [SerializeField] private bool _enableRangeCheck;
        [SerializeField] private float _rangeRadius = 1f;
        [SerializeField] private float _checkRadius;
        [SerializeField] private float _checkHeight = 1f;
        [SerializeField] private Transform _commandBasePoint;
        [SerializeField] private Transform _labelPoint;
        [SerializeField] private Transform _soundPlayPoint;
    }
}