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
    public class Waypoint : Point
    {
        [Flags]
        public enum AffiliationType { Map = 1, Housing = 2, Item = 4 }

        [Flags]
        public enum ElementType { HalfWay = 1, Destination = 2 }

        [SerializeField] [Tooltip("手動操作か？")] private bool _isManual;
        [SerializeField] private ElementType _type = (ElementType) (-1);
        [SerializeField] private AffiliationType _affiliation = AffiliationType.Map;
    }
}