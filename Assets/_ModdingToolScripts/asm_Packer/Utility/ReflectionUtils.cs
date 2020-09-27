using System;
using System.Reflection;
using UnityEngine;

namespace hooh_ModdingTool.asm_Packer.Utility
{
    public static class ReflectionUtils
    {
        public static bool TryGetMethod(this Type type, string name, out MethodInfo method)
        {
            var currentType = type;
            var index = 0; // failsafe
            while (!ReferenceEquals(null, currentType))
            {
                method = currentType.GetMethod(name);
                if (method != null) return true;

                currentType = currentType.BaseType;
                if (index++ > 10) break;
            }

            method = null;
            return false;
        }

        public static bool TryGetInvokeReturn<T>(this Type type, string name, out T value)
        {
            if (TryGetMethod(type, name, out var method))
            {
                value = (T) Convert.ChangeType(method.Invoke(null, null), typeof(T));
                return true;
            }

            value = default;
            return false;
        }

        public static bool TryGetInvokeReturn<T>(this Type type, string name, object[] parameters, out T value)
        {
            if (TryGetMethod(type, name, out var method))
            {
                value = (T) Convert.ChangeType(method.Invoke(null, parameters), typeof(T));
                return true;
            }

            value = default;
            return false;
        }

        public static T ReflectField<T>(this object instance, string key, T defaultValue = default)
        {
            try
            {
                return (T) Convert.ChangeType(instance.GetType().GetField(key).GetValue(instance), typeof(T));
            }
            catch (Exception)
            {
                return defaultValue;
            }
        }

        public static void ReflectSetField<T>(this object instance, string key, T value)
        {
            try
            {
                instance.GetType().GetField(key, BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic)?.SetValue(instance, value);
            }
            catch (Exception e)
            {
                // when failed to reflect set the field
                Debug.LogError(e);
            }
        }

        public static void InvokeMethod(this object instance, string methodName, params object[] parameters)
        {
            instance.GetType().GetMethod(methodName)?.Invoke(instance, parameters);
        }
    }
}