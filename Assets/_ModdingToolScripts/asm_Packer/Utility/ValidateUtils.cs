using System;
using System.Linq;
using MyBox;

namespace hooh_ModdingTool.asm_Packer.Utility
{
    public static class ValidateUtils
    {
        public static bool BulkValidCheck<T>(params T[] parameters)
        {
            return parameters.Length <= 0 || parameters.All(
                parameter => parameter.CheckValid());
        }

        public static bool BulkValidCheck(params string[] parameters)
        {
            return parameters.Length <= 0 || parameters.All(
                parameter => parameter.CheckValid() && !parameter.IsNullOrEmpty());
        }

        public static bool BulkValidCheckMin<T>(T min, params T[] parameters) where T : IComparable<T>
        {
            return parameters.Length <= 0 || parameters.All(
                parameter => parameters.CheckValid() && parameter.CompareTo(min) <= 0);
        }

        public static bool BulkValidCheckMax<T>(T max, params T[] parameters) where T : IComparable<T>
        {
            return parameters.Length <= 0 || parameters.All(
                parameter => parameters.CheckValid() && parameter.CompareTo(max) >= 0);
        }

        public static bool BulkValidCheckRange<T>(T min, T max, params T[] parameters) where T : IComparable<T>
        {
            return parameters.Length <= 0 || parameters.All(
                parameter => parameters.CheckValid() && parameter.CompareTo(min) <= 0 && parameter.CompareTo(max) >= 0);
        }

        private static bool CheckValid<T>(this T entity)
        {
            return !ReferenceEquals(null, entity);
        }
    }
}