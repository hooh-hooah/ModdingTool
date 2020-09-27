using UnityEngine;

namespace DebugComponents
{
    [DisallowMultipleComponent]
    public class ShowcaseAxis : MonoBehaviour
    {
        public int Elements = 4;

        public bool HideCursor = true;

        //public bool rotate = false;
        public bool RotateSky;
        public float SkyRotationSpeed = .5f;
        public int smoothing = 3;
        public float Speed = 20.0f;
        private float currentRotation;
        private float rotationX;

        private float rotationY;
        private float SkyDegrees, startupSkyRotation;
        private Material SkyMat;
        private int Step;

        private void Start()
        {
            rotationX = transform.eulerAngles.x;
            rotationY = transform.eulerAngles.y;
            SkyMat = RenderSettings.skybox;
            Step = 360 / Elements;
            currentRotation = rotationY;
            if (SkyMat)
                startupSkyRotation = SkyMat.GetFloat("_Rotation");
            Cursor.visible = !HideCursor;
        }

        private void Update()
        {
            if (Cursor.visible)
                Cursor.visible = !HideCursor;

            if (Input.GetKeyDown(KeyCode.LeftArrow))
            {
                currentRotation = Mathf.Lerp(currentRotation, currentRotation + Step, 1f / smoothing);
                rotationY += Step;
            }
            else
            {
                currentRotation = Mathf.Lerp(currentRotation, rotationY, 1f / smoothing);
            }

            transform.eulerAngles = new Vector3(rotationX, currentRotation * Speed, 0);

            if (Input.GetKeyDown(KeyCode.RightArrow))
            {
                currentRotation = Mathf.Lerp(currentRotation, currentRotation - Step, 1f / smoothing);
                rotationY -= Step;
            }


            if (RotateSky)
            {
                SkyDegrees += Time.deltaTime * SkyRotationSpeed;

                SkyMat.SetFloat("_Rotation", SkyDegrees);
            }
        }

        private void OnDestroy()
        {
            SkyMat.SetFloat("_Rotation", startupSkyRotation);
        }
    }
}