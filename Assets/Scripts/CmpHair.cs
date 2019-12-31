using System;
using UnityEngine;

namespace AIChara {

    [DisallowMultipleComponent]
    public class CmpHair : CmpBase {

        [Serializable]
        public class BoneInfo {
            public Transform trfCorrect;

            public DynamicBone[] dynamicBone;

            [HideInInspector]
            public Vector3 basePos = Vector3.zero;

            [HideInInspector]
            public Vector3 baseRot = Vector3.zero;

            [Header("[位置 制限]---------------------")]
            public Vector3 posMin = new Vector3(0f, 0f, 0f);

            public Vector3 posMax = new Vector3(0f, 0f, 0f);

            [Header("[回転 制限]---------------------")]
            public Vector3 rotMin = new Vector3(0f, 0f, 0f);

            public Vector3 rotMax = new Vector3(0f, 0f, 0f);

            [HideInInspector]
            public Vector3 moveRate = Vector3.zero;

            [HideInInspector]
            public Vector3 rotRate = Vector3.zero;
        }

        [Header("< 髪の毛 >-------------------")]
        public Renderer[] rendHair;

        [Tooltip("根本の色を使用")]
        public bool useTopColor = true;

        [Tooltip("毛先の色を使用")]
        public bool useUnderColor = true;

        public CmpHair.BoneInfo[] boneInfo;

        public int setdefaultposition;

        public int setdefaultrotation;

        [Header("< 飾り >---------------------")]
        public bool useAcsColor01;

        public bool useAcsColor02;

        public bool useAcsColor03;

        public Renderer[] rendAccessory;

        public Color[] acsDefColor;

        public int setcolor;

        public CmpHair(bool _baseDB) : base(_baseDB) {
        }

        public override void SetReferenceObject() {
            throw new NotImplementedException();
        }
    }
}