using UnityEngine;


// ReSharper disable NotAccessedField.Local
// ReSharper disable InconsistentNaming
#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649
namespace AIProject
{
    public class FarmPoint : Point
    {
        public enum FarmKind { Plant, ChickenCoop, Well }

        [SerializeField] private int _id;
        [SerializeField] private FarmSection[] _harvestSections;
        [SerializeField] private bool _enabledRangeCheck = true;
        [SerializeField] private float _radius = 1f;
        [SerializeField] private FarmKind _farmKind;
        [SerializeField] private Transform _commandBasePoint;
    }
}