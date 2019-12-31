using UnityEngine;

namespace AIChara {
    public abstract class CmpBase : MonoBehaviour {
        public CmpBase(bool _baseDB) {
        }

        public abstract void SetReferenceObject();

        private DynamicBone[] dynamicBones;

        [Header("カメラ内判定用")]
        public Renderer[] rendCheckVisible;

        public int reacquire;
    }
}
