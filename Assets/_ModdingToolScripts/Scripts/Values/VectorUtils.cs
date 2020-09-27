using UnityEngine;

namespace ModdingTool
{
    public static class VectorUtils
    {
        public static Vector3 FilterAxis(this Vector3 vector, params int[] indexes)
        {
            foreach (var index in indexes)
                if (index >= 0 && index <= 2)
                    vector[index] = 0;
            return vector;
        }

        public static Vector3 AddValue(this Vector3 vector, int index, float value)
        {
            if (index >= 0 && index <= 2) vector[index] += value;

            return vector;
        }

        public static Vector3 MulValue(this Vector3 vector, int index, float value)
        {
            if (index >= 0 && index <= 2) vector[index] *= value;

            return vector;
        }

        public static Vector3 MulValues(this Vector3 vector, float value, params int[] indexes)
        {
            foreach (var index in indexes)
                if (index >= 0 && index <= 2)
                    vector[index] *= value;

            return vector;
        }
    }
}