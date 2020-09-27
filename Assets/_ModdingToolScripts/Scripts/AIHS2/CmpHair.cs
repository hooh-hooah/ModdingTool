using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace AIChara
{
    [DisallowMultipleComponent]
    public class CmpHair : CmpBase
    {
        public Color[] acsDefColor;
        public BoneInfo[] boneInfo;

        public Renderer[] rendAccessory;

        public Renderer[] rendHair;

        // These are not being used.
        [HideInInspector] public int setcolor;

        [HideInInspector] public int setdefaultposition;

        [HideInInspector] public int setdefaultrotation;

        public bool useAcsColor01;
        public bool useAcsColor02;
        public bool useAcsColor03;

        public bool useTopColor = true;
        public bool useUnderColor = true;

        [NonSerialized] public int dynamicBonePreset;

        public CmpHair(bool _baseDB) : base(_baseDB)
        {
        }

        [Serializable]
        public class BoneInfo
        {
            [HideInInspector] public Vector3 basePos = Vector3.zero;
            [HideInInspector] public Vector3 baseRot = Vector3.zero;
            public DynamicBone[] dynamicBone;
            [HideInInspector] public Vector3 moveRate = Vector3.zero;
            public Vector3 posMax = new Vector3(0f, 0f, 0f);

            public Vector3 posMin = new Vector3(0f, 0f, 0f);
            public Vector3 rotMax = new Vector3(0f, 0f, 0f);

            public Vector3 rotMin = new Vector3(0f, 0f, 0f);
            [HideInInspector] public Vector3 rotRate = Vector3.zero;
            public Transform trfCorrect;
        }

#if UNITY_EDITOR
        public void SyncMaterialDefaultValues()
        {
            if (rendAccessory.Length == 0) return;
            var sharedMaterial = rendAccessory[0].sharedMaterial;
            if (null == sharedMaterial) return;
            acsDefColor = new Color[3];
            if (sharedMaterial.HasProperty("_Color")) acsDefColor[0] = sharedMaterial.GetColor("_Color");
            if (sharedMaterial.HasProperty("_Color2")) acsDefColor[1] = sharedMaterial.GetColor("_Color2");
            if (sharedMaterial.HasProperty("_Color3")) acsDefColor[2] = sharedMaterial.GetColor("_Color3");
        }

        public override void SetReferenceObject()
        {
            var findAssist = new FindAssist(transform);
            rendHair = (from x in GetComponentsInChildren<Renderer>(true)
                where !x.name.Contains("_acs")
                select x).ToArray();
            var components = GetComponents<DynamicBone>();
            var keyValuePair = findAssist.DictObjName.FirstOrDefault(x => x.Key.Contains("_top"));
            if (keyValuePair.Equals(default(KeyValuePair<string, GameObject>))) return;
            boneInfo = new BoneInfo[keyValuePair.Value.transform.childCount];
            for (var i = 0; i < boneInfo.Length; i++)
            {
                var child = keyValuePair.Value.transform.GetChild(i);
                findAssist.Recalculate(child);
                var boneInfoInstance = new BoneInfo();
                var keyValuePair2 = findAssist.DictObjName.FirstOrDefault(x => x.Key.Contains("_s"));
                if (!keyValuePair2.Equals(default(KeyValuePair<string, GameObject>)))
                {
                    var transformCorrect = keyValuePair2.Value.transform;
                    boneInfoInstance.trfCorrect = transformCorrect;
                    var boneTransform = boneInfoInstance.trfCorrect.transform;
                    var localPosition = boneTransform.localPosition;
                    var localEulerAngles = boneTransform.localEulerAngles;
                    boneInfoInstance.basePos = localPosition;
                    boneInfoInstance.posMin.x = localPosition.x + 0.1f;
                    boneInfoInstance.posMin.y = localPosition.y;
                    boneInfoInstance.posMin.z = localPosition.z + 0.1f;
                    boneInfoInstance.posMax.x = localPosition.x - 0.1f;
                    boneInfoInstance.posMax.y = localPosition.y - 0.2f;
                    boneInfoInstance.posMax.z = localPosition.z - 0.1f;
                    boneInfoInstance.baseRot = localEulerAngles;
                    boneInfoInstance.rotMin.x = localEulerAngles.x - 15f;
                    boneInfoInstance.rotMin.y = localEulerAngles.y - 15f;
                    boneInfoInstance.rotMin.z = localEulerAngles.z - 15f;
                    boneInfoInstance.rotMax.x = localEulerAngles.x + 15f;
                    boneInfoInstance.rotMax.y = localEulerAngles.y + 15f;
                    boneInfoInstance.rotMax.z = localEulerAngles.z + 15f;
                    boneInfoInstance.moveRate.x = Mathf.InverseLerp(boneInfoInstance.posMin.x, boneInfoInstance.posMax.x, boneInfoInstance.basePos.x);
                    boneInfoInstance.moveRate.y = Mathf.InverseLerp(boneInfoInstance.posMin.y, boneInfoInstance.posMax.y, boneInfoInstance.basePos.y);
                    boneInfoInstance.moveRate.z = Mathf.InverseLerp(boneInfoInstance.posMin.z, boneInfoInstance.posMax.z, boneInfoInstance.basePos.z);
                    boneInfoInstance.rotRate.x = Mathf.InverseLerp(boneInfoInstance.rotMin.x, boneInfoInstance.rotMax.x, boneInfoInstance.baseRot.x);
                    boneInfoInstance.rotRate.y = Mathf.InverseLerp(boneInfoInstance.rotMin.y, boneInfoInstance.rotMax.y, boneInfoInstance.baseRot.y);
                    boneInfoInstance.rotRate.z = Mathf.InverseLerp(boneInfoInstance.rotMin.z, boneInfoInstance.rotMax.z, boneInfoInstance.baseRot.z);
                }

                var array = components;
                boneInfoInstance.dynamicBone = array.Where(n => !findAssist.DictObjName.FirstOrDefault(x => x.Key == n.m_Root.name)
                    .Equals(default(KeyValuePair<string, GameObject>))).ToArray();
                boneInfo[i] = boneInfoInstance;
            }

            rendAccessory = (from s in findAssist.Renderers
                where s.Key.Contains("_acs")
                select s.Value).ToArray();

            SyncMaterialDefaultValues();
        }

#endif
    }
}