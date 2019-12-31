using System;
using System.Collections.Generic;

namespace AIProject
{
    // Token: 0x02000944 RID: 2372
    public static class DictionaryPool<TKey, TValue>
    {
        // Token: 0x06004155 RID: 16725 RVA: 0x001901A7 File Offset: 0x0018E5A7
        public static Dictionary<TKey, TValue> Get()
        {
            return DictionaryPool<TKey, TValue>._dictionaryPool.Get();
        }

        // Token: 0x06004156 RID: 16726 RVA: 0x001901B3 File Offset: 0x0018E5B3
        public static void Release(Dictionary<TKey, TValue> toRelease)
        {
            DictionaryPool<TKey, TValue>._dictionaryPool.Release(toRelease);
        }

        // Token: 0x04003E77 RID: 15991
        private static readonly ObjectPool<Dictionary<TKey, TValue>> _dictionaryPool = new ObjectPool<Dictionary<TKey, TValue>>(null, delegate (Dictionary<TKey, TValue> x)
        {
            x.Clear();
        });
    }
}
