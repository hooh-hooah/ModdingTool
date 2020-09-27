using UnityEngine;

namespace ADV.EventCG
{
    public class CameraData : MonoBehaviour
    {
        [Header("カメラデータ")] [SerializeField] private float _fieldOfView;

        [SerializeField] private Vector3 _maxAng;

        [SerializeField] private Vector3 _maxPos;

        [Header("身長補正角度")] [SerializeField] private Vector3 _minAng;

        [Header("身長補正座標")] [SerializeField] private Vector3 _minPos;
    }
}