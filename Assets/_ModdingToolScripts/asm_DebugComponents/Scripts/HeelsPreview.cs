using System;
using UnityEngine;

public class HeelsPreview : MonoBehaviour
{
    [Serializable]
    public struct Offset
    {
        public Transform target;

        private Vector3 _originalPosition;
        private Vector3 _originalScale;
        private Vector3 _originalAngle;

        public Vector3 position;
        public Vector3 scale;
        public Vector3 angle;

        public void Remember()
        {
            _originalPosition = target.localPosition;
            _originalAngle = target.localEulerAngles;
            _originalScale = target.localScale;
        }

        public void Adjust()
        {
            if (target == null) return;
            target.localPosition = _originalPosition + position;
            target.localEulerAngles += angle;
            target.localScale = _originalScale + scale;
        }
    }

    [Serializable]
    public struct Foot
    {
        public Offset foot01;
        public Offset foot02;
        public Offset toe01;

        public void Remember()
        {
            foot01.Remember();
            foot02.Remember();
            toe01.Remember();
        }

        public void Adjust()
        {
            foot01.Adjust();
            foot02.Adjust();
            toe01.Adjust();
        }
    }

    public Foot left;
    public Foot right;

    // Start is called before the first frame update
    void Start()
    {
        left.Remember();
        right.Remember();
    }

    // Update is called once per frame
    void LateUpdate()
    {
        left.Adjust();
        right.Adjust();
    }
}
