using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using UnityEngine.Events;

namespace AIProject
{
    // Token: 0x02000949 RID: 2377
    public class ObjectPool<T> where T : new()
    {
        // Token: 0x04003E7D RID: 15997
        private readonly UnityAction<T> _actionOnGet;

        // Token: 0x04003E7E RID: 15998
        private readonly UnityAction<T> _actionOnRelease;

        // Token: 0x04003E7C RID: 15996
        private readonly Stack<T> _stack = new Stack<T>();

        // Token: 0x06004164 RID: 16740 RVA: 0x001903D7 File Offset: 0x0018E7D7
        public ObjectPool(UnityAction<T> actionOnGet, UnityAction<T> actionOnRelease)
        {
            _actionOnGet = actionOnGet;
            _actionOnRelease = actionOnRelease;
        }

        // Token: 0x17000C2F RID: 3119
        // (get) Token: 0x06004165 RID: 16741 RVA: 0x001903F8 File Offset: 0x0018E7F8
        // (set) Token: 0x06004166 RID: 16742 RVA: 0x00190400 File Offset: 0x0018E800
        public int countAll { get; private set; }

        // Token: 0x17000C30 RID: 3120
        // (get) Token: 0x06004167 RID: 16743 RVA: 0x00190409 File Offset: 0x0018E809
        public int countActive
        {
            [CompilerGenerated] get => countAll - countInactive;
        }

        // Token: 0x17000C31 RID: 3121
        // (get) Token: 0x06004168 RID: 16744 RVA: 0x00190418 File Offset: 0x0018E818
        public int countInactive
        {
            [CompilerGenerated] get => _stack.Count;
        }

        // Token: 0x06004169 RID: 16745 RVA: 0x00190428 File Offset: 0x0018E828
        public T Get()
        {
            T t;
            if (_stack.Count == 0)
            {
                t = Activator.CreateInstance<T>();
                countAll++;
            }
            else
            {
                t = _stack.Pop();
            }

            if (_actionOnGet != null) _actionOnGet(t);
            return t;
        }

        // Token: 0x0600416A RID: 16746 RVA: 0x00190484 File Offset: 0x0018E884
        public void Release(T element)
        {
            if (_stack.Count <= 0 || ReferenceEquals(_stack.Peek(), element))
            {
            }

            if (_actionOnRelease != null) _actionOnRelease(element);
            _stack.Push(element);
        }
    }
}