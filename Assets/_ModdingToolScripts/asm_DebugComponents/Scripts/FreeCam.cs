using UnityEngine;

namespace DebugComponents
{
    [DisallowMultipleComponent]
    public class FreeCam : MonoBehaviour
    {
        public float mouseSensX = 2f;
        public float mouseSensY = 2f;
        public float speedFast = 25f;
        public float speedNormal = 3f;
        private float _rotY;
        private float _speed;

        private void Update()
        {
            var t = transform;
            if (Input.GetMouseButton(1))
            {
                var rotX = t.localEulerAngles.y + Input.GetAxis("Mouse X") * mouseSensX;
                _rotY += Input.GetAxis("Mouse Y") * mouseSensY;
                _rotY = Mathf.Clamp(_rotY, -80f, 80f);
                t.localEulerAngles = new Vector3(-_rotY, rotX, 0f);
            }

            var forward = Input.GetAxis("Vertical");
            var side = Input.GetAxis("Horizontal");
            if (forward != 0f)
            {
                _speed = Input.GetKey(KeyCode.LeftShift) ? speedFast : speedNormal;
                var vector = new Vector3(0f, 0f, forward * _speed * Time.deltaTime);
                t.localPosition += t.localRotation * vector;
            }

            if (side != 0f)
            {
                _speed = Input.GetKey(KeyCode.LeftShift) ? speedFast : speedNormal;
                var vector = new Vector3(side * _speed * Time.deltaTime, 0f, 0f);
                t.localPosition += t.localRotation * vector;
            }
        }
    }
}