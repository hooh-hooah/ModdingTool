using System;
using System.Collections;
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
    public class ActionPoint : Point
    {
        public enum DirectionKind
        {
            Free,
            Lock,
            Look
        }

        [SerializeField] private int _registerID;
        [SerializeField] protected int _id;
        [SerializeField] protected int[] _idList;
        [SerializeField] protected EventType _playerEventType;
        [SerializeField] protected EventType _agentEventType;
        [SerializeField] protected EventType[] _playerDateEventType = new EventType[2];
        [SerializeField] protected EventType _agentDateEventType;
        [SerializeField] private bool _enabledRangeCheck = true;
        [SerializeField] private float _radius = 1f;
        [SerializeField] private Transform _commandBasePoint;
        [SerializeField] protected Transform _destination;
        [SerializeField] private GameObject[] _mapItemObjs;
        [SerializeField] private MapItemKeyValuePair[] _mapItemData;
        [SerializeField] protected ActionSlot _actionSlot = new ActionSlot();
        [SerializeField] private ObjectLayer _layer = ObjectLayer.Command;

        [Serializable]
        public struct PoseTypePair
        {
            public EventType eventType;
            public PoseType poseType;

            public PoseTypePair(EventType eventType_, PoseType poseType_)
            {
                eventType = eventType_;
                poseType = poseType_;
            }
        }

        [Serializable]
        public class PointPair
        {
            [SerializeField] private Transform _point;
            [SerializeField] private Transform _recoveryPoint;
        }

        [Serializable]
        public class ActionSlotTable : IEnumerable<ActionSlot>
        {
            [SerializeField] private List<ActionSlot> _table = new List<ActionSlot>();

            public IEnumerator<ActionSlot> GetEnumerator()
            {
                return null;
            }

            IEnumerator IEnumerable.GetEnumerator()
            {
                return GetEnumerator();
            }
        }

        [Serializable]
        public class ActionSlot
        {
            [SerializeField] private EventType _acceptionKey;
            [SerializeField] private Transform _point;
            [SerializeField] private Transform _recoveryPoint;
            [SerializeField] private Actor _actor;
        }
    }
}