using System.Collections.Generic;

namespace hooh_ModdingTool.asm_Packer.Utility
{
    public static class ListUtils
    {
        public static void Insert<TKey, TValue>(this Dictionary<TKey, List<TValue>> dictionary, TKey key, TValue value)
        {
            if (!dictionary.ContainsKey(key)) dictionary[key] = new List<TValue>();
            dictionary[key].Add(value);
        }

        public static void Insert<TKey, TValue>(this Dictionary<TKey, HashSet<TValue>> dictionary, TKey key, TValue value)
        {
            if (!dictionary.ContainsKey(key)) dictionary[key] = new HashSet<TValue>();
            dictionary[key].Add(value);
        }
    }
}