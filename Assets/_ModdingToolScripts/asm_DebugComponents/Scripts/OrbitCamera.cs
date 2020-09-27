using UnityEngine;

namespace DebugComponents
{
    [DisallowMultipleComponent]
    public class OrbitCamera : MonoBehaviour
    {
        public float distance = 5.0f;
        public Transform target;
        public float xSpeed = 250.0f;
        public float yMaxLimit = 80.0f;
        public float yMinLimit = -20.0f;
        public float ySpeed = 120.0f;

        public float zoomSpeed = 1;


        private Camera _camera;
        private float _x;
        private float _y;

        private void Awake()
        {
            var angles = transform.eulerAngles;
            _x = angles.x;
            _y = angles.y;
            _camera = GetComponent<Camera>();
        }

        private void LateUpdate()
        {
            if (ReferenceEquals(null, target)) return;

            if (MouseScreenCheck())
            {
                distance -= Input.GetAxis("Mouse ScrollWheel") * zoomSpeed;
                if (Input.GetKey(KeyCode.Mouse1)) distance += Input.GetAxis("Mouse Y") * zoomSpeed / 3;
            }

            if (Input.GetKey(KeyCode.Mouse0))
            {
                _x += Input.GetAxis("Mouse X") * xSpeed * 0.02f;
                _y -= Input.GetAxis("Mouse Y") * ySpeed * 0.02f;
                _y = ClampAngle(_y, yMinLimit, yMaxLimit);
            }

            var rotation = Quaternion.Euler(_y, _x, 0);
            var position = rotation * new Vector3(0.0f, 0.0f, -distance) + target.position;
            transform.rotation = rotation;
            transform.position = position;
        }

        private bool MouseScreenCheck()
        {
            var view = _camera.ScreenToViewportPoint(Input.mousePosition);
            var isOutside = view.x < 0 || view.x > 1 || view.y < 0 || view.y > 1;

            return !isOutside;
        }

        private static float ClampAngle(float angle, float min, float max)
        {
            if (angle < -360) angle += 360;
            if (angle > 360) angle -= 360;
            return Mathf.Clamp(angle, min, max);
        }
    }
}