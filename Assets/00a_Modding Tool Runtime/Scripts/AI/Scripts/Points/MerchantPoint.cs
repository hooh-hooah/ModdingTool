using AIProject.Definitions;
using UnityEngine;

// ReSharper disable NotAccessedField.Local
// ReSharper disable InconsistentNaming
#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649
namespace AIProject
{
    public class MerchantPoint : Point
    {
        [SerializeField] [Tooltip("行動ID")] private int _actionID;

        [SerializeField] [Tooltip("開放エリア等に使用")]
        private int _areaID;

        [SerializeField] [Tooltip("エリア内でのグループ分け")]
        private int _groupID;

        [SerializeField] [Tooltip("このポイントで起こせる行動")]
        private Merchant.EventType _eventType;

        [SerializeField] [Tooltip("商人登場イベント時のスタートポイント")]
        private bool _isStartPoint;

        [SerializeField] [Tooltip("島から出ていく時に使うポイント")]
        private bool _isExitPoint;

        [SerializeField] [Tooltip("Actorがこのポイントを目指す到達地点")]
        private Transform _destination;
    }
}