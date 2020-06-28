using UnityEngine;

namespace DebugComponents
{
    public class Rotate : MonoBehaviour
    {
        public bool rotate; //, RotateSky = false;
        private float rotationX;

        private float rotationY;
        private float rotationZ;
        public float Speed = 20.0f;

        private float time;
        // Material SkyMat = null;

        private void Start()
        {
            rotationX = transform.eulerAngles.x;
            rotationY = transform.eulerAngles.y;
            rotationZ = transform.eulerAngles.z;
            // SkyMat = RenderSettings.skybox;
        }

        private void Update()
        {
            if (rotate)
            {
                time += Time.deltaTime;
                transform.eulerAngles = new Vector3(rotationX, rotationY + time * Speed, rotationZ);
                //if (RotateSky)
                //SkyMat.SetFloat("_Rotation", -transform.eulerAngles.y+180);
            }
        }

        //void OnDestroy()
        //{
        //    SkyMat.SetFloat("_Rotation", 180);
        //}
    }
}