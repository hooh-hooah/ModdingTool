using System;
using JetBrains.Annotations;
using UnityEditor;
using UnityEngine;

namespace ModPackerModule.Structure.ScriptableObjectResolver
{
    public abstract class ResolverBase<T> where T : ScriptableObject
    {
        private readonly T instance;
        private readonly Type instanceType;

        protected ResolverBase([NotNull] ref T instance)
        {
            this.instance = instance;
            instanceType = instance.GetType();
        }

        protected virtual string GetTypeName => "";

        public virtual bool IsValid()
        {
            return instanceType.Name.Equals(GetTypeName);
        }

        public virtual void Save()
        {
            EditorUtility.SetDirty(instance);
        }

        public virtual void Set()
        {
        }
    }
}