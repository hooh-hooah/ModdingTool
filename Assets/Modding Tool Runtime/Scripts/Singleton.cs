using UnityEngine;

namespace RootMotion
{
    /// <summary>
    ///     The base abstract Singleton class.
    /// </summary>
    public abstract class Singleton<T> : MonoBehaviour where T : Singleton<T>
    {
        public static T instance { get; private set; }

        protected virtual void Awake()
        {
            if (instance != null) Debug.LogError(name + "error: already initialized", this);

            instance = (T) this;
        }
    }
}