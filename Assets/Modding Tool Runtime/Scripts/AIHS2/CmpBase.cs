using ModdingTool;
using UnityEngine;

namespace AIChara
{
    public abstract class CmpBase : MonoBehaviour
    {
        [HideInInspector] public int reacquire;

        public Renderer[] rendCheckVisible;
        private DynamicBone[] dynamicBones;

        public CmpBase(bool _baseDB)
        {
        }
#if UNITY_EDITOR
        public abstract void SetReferenceObject();

        public virtual void ReassignAllObjects()
        {
            SetReferenceObject();
            GetAllRenderers();
        }

        public void GetAllRenderers()
        {
            rendCheckVisible = GetComponentsInChildren<Renderer>(true);
        }

        public void ApplyDynamicBones(DynamicBonePreset preset)
        {
            var dynamicBones = GetComponentsInChildren<DynamicBone>();
            foreach (var dynamicBone in dynamicBones) preset.Apply(dynamicBone);
        }
#endif
    }
}