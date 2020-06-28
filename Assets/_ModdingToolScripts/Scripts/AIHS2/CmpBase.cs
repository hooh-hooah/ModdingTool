using MyBox;
using UnityEngine;

namespace AIChara {
    public abstract class CmpBase : MonoBehaviour {
        public CmpBase(bool _baseDB) {
        }

        public abstract void SetReferenceObject();
        private DynamicBone[] dynamicBones;
        public Renderer[] rendCheckVisible;
        [HideInInspector]
        public int reacquire;

        public virtual void ReassignAllObjects()
        {
            SetReferenceObject();
            GetAllRenderers();
        }
        
        public void GetAllRenderers()
        {
            rendCheckVisible = GetComponentsInChildren<Renderer>(true);
        }

        public void ApplyDynamicBones(ModdingTool.DynamicBonePreset preset)
        {
            DynamicBone[] dynamicBones = GetComponentsInChildren<DynamicBone>();
            foreach (DynamicBone dynamicBone in dynamicBones)
            {
                preset.Apply(dynamicBone);
            }
        }
    }
}
