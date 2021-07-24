using UnityEngine;

namespace Inspectors.Utilities
{
    public static class ObjectTransform
    {
        public static void TransformSnapToGround(this Transform transform, float offset = 0)
        {
            RaycastHit hit;
            var ray = new Ray(transform.position, Vector3.down);
            if (Physics.Raycast(ray, out hit, Mathf.Infinity))
            {
                var position = hit.point;
                position += Vector3.up * offset;
                transform.position = position;
            }
        }

        public static void RandomiseRotation(this Transform transform, Vector3 minRotation, Vector3 maxRotation)
        {
            var rotation = transform.eulerAngles;
            rotation.x = Random.Range(minRotation.x, maxRotation.x);
            rotation.y = Random.Range(minRotation.y, maxRotation.y);
            rotation.z = Random.Range(minRotation.z, maxRotation.z);
            transform.eulerAngles = rotation;
        }
    }
}