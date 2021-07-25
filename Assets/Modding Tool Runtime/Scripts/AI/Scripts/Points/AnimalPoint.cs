using System;
using System.Collections.Generic;
using UnityEngine;

// ReSharper disable NotAccessedField.Local
// ReSharper disable InconsistentNaming
#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649

namespace AIProject.Animal
{
    public class AnimalPoint : Point
    {
        [SerializeField] [Tooltip("このポイントのID")]
        protected int _id;

        [SerializeField] private LocateTypes _locateType;

        [Serializable]
        public class LocateInfo
        {
            private const int ButtonHeight = 20;
            private const int FontSize = 15;
            [SerializeField] private float _raycastUpOffset = 3f;
            [SerializeField] private LayerMask _checkLayer = 0;
            [SerializeField] private float _checkNavMeshDistance = 10f;
            [SerializeField] private List<Transform> _colliderTarget = new List<Transform>();
            [SerializeField] private List<Transform> _navMeshTarget = new List<Transform>();
        }
    }
}