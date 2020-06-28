using UnityEngine;

namespace DebugComponents
{
    public class SASOrbitCamera : MonoBehaviour
    {
        public float Distance = 5.0f;
        public Transform Target;
        private float x;
        public float xSpeed = 250.0f;
        private float y;
        public float yMaxLimit = 80.0f;
        public float yMinLimit = -20.0f;
        public float ySpeed = 120.0f;

        public float ZoomSpeed = 1;

        //public KeyCode RotationKey = KeyCode.LeftAlt;
        private void Awake()
        {
            var angles = transform.eulerAngles;
            x = angles.x;
            y = angles.y;
        }

        public bool MouseScreenCheck()
        {
            var view = GetComponent<Camera>().ScreenToViewportPoint(Input.mousePosition);
            var isOutside = view.x < 0 || view.x > 1 || view.y < 0 || view.y > 1;

            return !isOutside;
        }

        private void LateUpdate()
        {
            if (Target != null)
            {
                if (MouseScreenCheck())
                {
                    gameObject.GetComponent<SASOrbitCamera>().Distance -= Input.GetAxis("Mouse ScrollWheel") * ZoomSpeed;

                    if (Input.GetKey(KeyCode.Mouse1))
                        gameObject.GetComponent<SASOrbitCamera>().Distance += Input.GetAxis("Mouse Y") * ZoomSpeed / 3;
                }

                if (Input.GetKey(KeyCode.Mouse0))
                {
                    x += Input.GetAxis("Mouse X") * xSpeed * 0.02f;
                    y -= Input.GetAxis("Mouse Y") * ySpeed * 0.02f;
                    y = ClampAngle(y, yMinLimit, yMaxLimit);
                }


                var rotation = Quaternion.Euler(y, x, 0);
                var position = rotation * new Vector3(0.0f, 0.0f, -Distance) + Target.position;

                transform.rotation = rotation;
                transform.position = position;
            }
        }

        private float ClampAngle(float angle, float min, float max)
        {
            if (angle < -360) angle += 360;
            if (angle > 360) angle -= 360;
            return Mathf.Clamp(angle, min, max);
        }
    }
}