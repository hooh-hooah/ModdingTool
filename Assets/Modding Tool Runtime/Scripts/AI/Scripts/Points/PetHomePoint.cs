using System;
using UnityEngine;


// ReSharper disable NotAccessedField.Local
// ReSharper disable InconsistentNaming
#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649
namespace AIProject.Animal
{
    public class PetHomePoint : Point
    {
        public enum HomeKind { PetMat, FishTank }

        [SerializeField] private int _pointID = -1;
        [SerializeField] private int _animalID = -1;
        [SerializeField] private Transform _commandBasePoint;
        [SerializeField] private Transform _labelPoint;
        [SerializeField] private bool _enableRangeCheck = true;
        [SerializeField] private float _checkRadius = 1f;
        [SerializeField] private HomeKind _homeKind;
        [SerializeField] private int _allowableSizeID;
        [SerializeField] private Transform[] _rootPoints;
        [SerializeField] private CommandAreaInfo[] _commandAreaInfos;

        [Serializable]
        public class CommandAreaInfo
        {
            [SerializeField] private Transform _labelPoint;
            [SerializeField] private Transform _basePoint;
        }
    }
}