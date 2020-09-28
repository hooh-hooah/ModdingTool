using UnityEngine;

namespace HooahComponents.Utility
{
    public static class VectorUtility
    {
        public static float SqrDistance(Vector3 from, Vector3 to)
        {
            return (from - to).sqrMagnitude;
        }

        public static bool IsInRange(Vector3 from, Vector3 to, float distance)
        {
            return SqrDistance(from, to) <= distance;
        }
    }
}