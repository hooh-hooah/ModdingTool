using UnityEngine;

namespace DebugComponents
{
    public class FreeCam : MonoBehaviour
    {
        public float mouseSensX = 2f;
        public float mouseSensY = 2f;
        private float rotY;
        private float speed;
        public float speedFast = 25f;
        public float speedNormal = 3f;

        private void Start()
        {
            //Cursor.visible = false;
        }

        private void Update()
        {
            if (Input.GetMouseButton(0))
            {
                //Cursor.visible = true;
            }

            if (Input.GetMouseButton(1))
            {
                var rotX = transform.localEulerAngles.y + Input.GetAxis("Mouse X") * mouseSensX;
                rotY += Input.GetAxis("Mouse Y") * mouseSensY;
                rotY = Mathf.Clamp(rotY, -80f, 80f);
                transform.localEulerAngles = new Vector3(-rotY, rotX, 0f);
                //Cursor.visible = false;
            }

            var forward = Input.GetAxis("Vertical");
            var side = Input.GetAxis("Horizontal");
            if (forward != 0f)
            {
                if (Input.GetKey(KeyCode.LeftShift)) speed = speedFast;
                else speed = speedNormal;
                var vect = new Vector3(0f, 0f, forward * speed * Time.deltaTime);
                transform.localPosition += transform.localRotation * vect;
            }

            if (side != 0f)
            {
                if (Input.GetKey(KeyCode.LeftShift)) speed = speedFast;
                else speed = speedNormal;
                var vect = new Vector3(side * speed * Time.deltaTime, 0f, 0f);
                transform.localPosition += transform.localRotation * vect;
            }
        }
    }
}