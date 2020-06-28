using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace AIChara
{
    [DisallowMultipleComponent]
    public class CmpHair : CmpBase
    {
        [Serializable]
        public class BoneInfo
        {
            public Transform trfCorrect;
            public DynamicBone[] dynamicBone;

            public Vector3 posMin = new Vector3(0f, 0f, 0f);
            public Vector3 posMax = new Vector3(0f, 0f, 0f);

            public Vector3 rotMin = new Vector3(0f, 0f, 0f);
            public Vector3 rotMax = new Vector3(0f, 0f, 0f);

            [HideInInspector] public Vector3 basePos = Vector3.zero;
            [HideInInspector] public Vector3 baseRot = Vector3.zero;
            [HideInInspector] public Vector3 moveRate = Vector3.zero;
            [HideInInspector] public Vector3 rotRate = Vector3.zero;
        }

        public Renderer[] rendHair;
        public CmpHair.BoneInfo[] boneInfo;

        public bool useTopColor = true;
        public bool useUnderColor = true;

        public Renderer[] rendAccessory;
        public bool useAcsColor01;
        public bool useAcsColor02;
        public bool useAcsColor03;
        public Color[] acsDefColor;

        // These are not being used.
        [HideInInspector]
        public int setcolor;
        [HideInInspector]
        public int setdefaultposition;
        [HideInInspector]
        public int setdefaultrotation;
        [NonSerialized]
        public int dynamicBonePreset;

        public CmpHair(bool _baseDB) : base(_baseDB)
        {
        }

        public void SyncMaterialDefaultValues()
        {
            if (rendAccessory.Length != 0)
            {
                var sharedMaterial = rendAccessory[0].sharedMaterial;
                if (null != sharedMaterial)
                {
                    acsDefColor = new Color[3];
                    if (sharedMaterial.HasProperty("_Color")) acsDefColor[0] = sharedMaterial.GetColor("_Color");
                    if (sharedMaterial.HasProperty("_Color2")) acsDefColor[1] = sharedMaterial.GetColor("_Color2");
                    if (sharedMaterial.HasProperty("_Color3")) acsDefColor[2] = sharedMaterial.GetColor("_Color3");
                }
            }
        }

        public override void SetReferenceObject()
        {
            var findAssist = new FindAssist();
            findAssist.Initialize(this.transform);
            rendHair = (from x in GetComponentsInChildren<Renderer>(true)
                where !x.name.Contains("_acs")
                select x).ToArray();
            var components = GetComponents<DynamicBone>();
            var keyValuePair = findAssist.dictObjName.FirstOrDefault(x => x.Key.Contains("_top"));
            if (keyValuePair.Equals(default(KeyValuePair<string, GameObject>))) return;
            this.boneInfo = new BoneInfo[keyValuePair.Value.transform.childCount];
            for (var i = 0; i < this.boneInfo.Length; i++)
            {
                var child = keyValuePair.Value.transform.GetChild(i);
                findAssist.Initialize(child);
                var boneInfo = new BoneInfo();
                var keyValuePair2 = findAssist.dictObjName.FirstOrDefault(x => x.Key.Contains("_s"));
                if (!keyValuePair2.Equals(default(KeyValuePair<string, GameObject>)))
                {
                    var transform = keyValuePair2.Value.transform;
                    boneInfo.trfCorrect = transform;
                    var boneTransform = boneInfo.trfCorrect.transform;
                    var localPosition = boneTransform.localPosition;
                    var localEulerAngles = boneTransform.localEulerAngles;
                    boneInfo.basePos = localPosition;
                    boneInfo.posMin.x = localPosition.x + 0.1f;
                    boneInfo.posMin.y = localPosition.y;
                    boneInfo.posMin.z = localPosition.z + 0.1f;
                    boneInfo.posMax.x = localPosition.x - 0.1f;
                    boneInfo.posMax.y = localPosition.y - 0.2f;
                    boneInfo.posMax.z = localPosition.z - 0.1f;
                    boneInfo.baseRot = localEulerAngles;
                    boneInfo.rotMin.x = localEulerAngles.x - 15f;
                    boneInfo.rotMin.y = localEulerAngles.y - 15f;
                    boneInfo.rotMin.z = localEulerAngles.z - 15f;
                    boneInfo.rotMax.x = localEulerAngles.x + 15f;
                    boneInfo.rotMax.y = localEulerAngles.y + 15f;
                    boneInfo.rotMax.z = localEulerAngles.z + 15f;
                    boneInfo.moveRate.x = Mathf.InverseLerp(boneInfo.posMin.x, boneInfo.posMax.x, boneInfo.basePos.x);
                    boneInfo.moveRate.y = Mathf.InverseLerp(boneInfo.posMin.y, boneInfo.posMax.y, boneInfo.basePos.y);
                    boneInfo.moveRate.z = Mathf.InverseLerp(boneInfo.posMin.z, boneInfo.posMax.z, boneInfo.basePos.z);
                    boneInfo.rotRate.x = Mathf.InverseLerp(boneInfo.rotMin.x, boneInfo.rotMax.x, boneInfo.baseRot.x);
                    boneInfo.rotRate.y = Mathf.InverseLerp(boneInfo.rotMin.y, boneInfo.rotMax.y, boneInfo.baseRot.y);
                    boneInfo.rotRate.z = Mathf.InverseLerp(boneInfo.rotMin.z, boneInfo.rotMax.z, boneInfo.baseRot.z);
                }

                var list = new List<DynamicBone>();
                var array = components;
                for (var j = 0; j < array.Length; j++)
                {
                    var n = array[j];
                    if (!findAssist.dictObjName.FirstOrDefault(x => x.Key == n.m_Root.name)
                        .Equals(default(KeyValuePair<string, GameObject>))) list.Add(n);
                }

                boneInfo.dynamicBone = list.ToArray();
                this.boneInfo[i] = boneInfo;
            }

            findAssist = new FindAssist();
            findAssist.Initialize(this.transform);
            rendAccessory = (from s in findAssist.dictObjName
                where s.Key.Contains("_acs")
                select s
                into x
                select x.Value.GetComponent<Renderer>()
                into r
                where null != r
                select r).ToArray();
            SyncMaterialDefaultValues();
        }
    }
}