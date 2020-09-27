using UnityEngine;

namespace ModdingTool
{
    public static class MaterialUtils
    {
        private static bool TryGetValue(this Material material, string name, out float value)
        {
            value = default;

            if (!material.HasProperty(name)) return false;
            value = material.GetFloat(name);
            return true;
        }


        private static bool TryGetValue(this Material material, string name, out Vector4 value)
        {
            value = default;

            if (!material.HasProperty(name)) return false;
            value = material.GetVector(name);
            return true;
        }

        private static bool TryGetValue(this Material material, string name, out Color value)
        {
            value = default;

            if (!material.HasProperty(name)) return false;
            value = material.GetColor(name);
            return true;
        }

        public static void SafeAssign(this Material material, string name, ref float value)
        {
            if (material.TryGetValue(name, out float matValue)) value = matValue;
        }


        public static void SafeAssign(this Material material, string name, ref Vector4 value)
        {
            if (material.TryGetValue(name, out Vector4 matValue)) value = matValue;
        }

        public static void SafeAssign(this Material material, string name, ref Color value)
        {
            if (material.TryGetValue(name, out Color matValue)) value = matValue;
        }
    }
}