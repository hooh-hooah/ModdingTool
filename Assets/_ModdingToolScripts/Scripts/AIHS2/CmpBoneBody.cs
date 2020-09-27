using System;
using UnityEngine;

// ReSharper disable InconsistentNaming

#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649

namespace AIChara
{
    [DisallowMultipleComponent]
    public class CmpBoneBody : CmpBase
    {
        [Header("男無効用胸の判定")] public DynamicBoneCollider[] dbcBust;

        [Header("アクセサリの親")] public TargetAccessory targetAccessory = new TargetAccessory();

        [Header("その他ターゲット")] public TargetEtc targetEtc = new TargetEtc();

        private DynamicBone_Ver02[] dynamicBonesBustAndHip;

        public CmpBoneBody() : base(false)
        {
        }

        [Serializable]
        public class TargetAccessory
        {
            public Transform acs_Ana;

            public Transform acs_Ankle_L;

            public Transform acs_Ankle_R;

            public Transform acs_Arm_L;

            public Transform acs_Arm_R;

            public Transform acs_Back;

            public Transform acs_Back_L;

            public Transform acs_Back_R;

            public Transform acs_Chest;

            public Transform acs_Chest_f;

            public Transform acs_Dan;

            public Transform acs_Elbo_L;

            public Transform acs_Elbo_R;

            public Transform acs_Foot_L;

            public Transform acs_Foot_R;

            public Transform acs_Hand_L;

            public Transform acs_Hand_R;

            public Transform acs_Index_L;

            public Transform acs_Index_R;

            public Transform acs_Knee_L;

            public Transform acs_Knee_R;

            public Transform acs_Kokan;

            public Transform acs_Leg_L;

            public Transform acs_Leg_R;

            public Transform acs_Middle_L;

            public Transform acs_Middle_R;
            public Transform acs_Neck;

            public Transform acs_Ring_L;

            public Transform acs_Ring_R;

            public Transform acs_Shoulder_L;

            public Transform acs_Shoulder_R;

            public Transform acs_Tikubi_L;

            public Transform acs_Tikubi_R;

            public Transform acs_Waist;

            public Transform acs_Waist_b;

            public Transform acs_Waist_f;

            public Transform acs_Waist_L;

            public Transform acs_Waist_R;

            public Transform acs_Wrist_L;

            public Transform acs_Wrist_R;
        }

        [Serializable]
        public class TargetEtc
        {
            public Transform trf_k_handL_00;

            public Transform trf_k_handR_00;

            public Transform trf_k_shoulderL_00;

            public Transform trf_k_shoulderR_00;

            public Transform trfAnaCorrect;

            public Transform trfHeadParent;

            public Transform trfNeckLookTarget;
            public Transform trfRoot;
        }
#if UNITY_EDITOR
        public override void SetReferenceObject()
        {
            var findAssist = new FindAssist(transform);
            targetAccessory.acs_Neck = findAssist.GetTransformFromName("N_Neck");
            targetAccessory.acs_Chest_f = findAssist.GetTransformFromName("N_Chest_f");
            targetAccessory.acs_Chest = findAssist.GetTransformFromName("N_Chest");
            targetAccessory.acs_Tikubi_L = findAssist.GetTransformFromName("N_Tikubi_L");
            targetAccessory.acs_Tikubi_R = findAssist.GetTransformFromName("N_Tikubi_R");
            targetAccessory.acs_Back = findAssist.GetTransformFromName("N_Back");
            targetAccessory.acs_Back_L = findAssist.GetTransformFromName("N_Back_L");
            targetAccessory.acs_Back_R = findAssist.GetTransformFromName("N_Back_R");
            targetAccessory.acs_Waist = findAssist.GetTransformFromName("N_Waist");
            targetAccessory.acs_Waist_f = findAssist.GetTransformFromName("N_Waist_f");
            targetAccessory.acs_Waist_b = findAssist.GetTransformFromName("N_Waist_b");
            targetAccessory.acs_Waist_L = findAssist.GetTransformFromName("N_Waist_L");
            targetAccessory.acs_Waist_R = findAssist.GetTransformFromName("N_Waist_R");
            targetAccessory.acs_Leg_L = findAssist.GetTransformFromName("N_Leg_L");
            targetAccessory.acs_Leg_R = findAssist.GetTransformFromName("N_Leg_R");
            targetAccessory.acs_Knee_L = findAssist.GetTransformFromName("N_Knee_L");
            targetAccessory.acs_Knee_R = findAssist.GetTransformFromName("N_Knee_R");
            targetAccessory.acs_Ankle_L = findAssist.GetTransformFromName("N_Ankle_L");
            targetAccessory.acs_Ankle_R = findAssist.GetTransformFromName("N_Ankle_R");
            targetAccessory.acs_Foot_L = findAssist.GetTransformFromName("N_Foot_L");
            targetAccessory.acs_Foot_R = findAssist.GetTransformFromName("N_Foot_R");
            targetAccessory.acs_Shoulder_L = findAssist.GetTransformFromName("N_Shoulder_L");
            targetAccessory.acs_Shoulder_R = findAssist.GetTransformFromName("N_Shoulder_R");
            targetAccessory.acs_Elbo_L = findAssist.GetTransformFromName("N_Elbo_L");
            targetAccessory.acs_Elbo_R = findAssist.GetTransformFromName("N_Elbo_R");
            targetAccessory.acs_Arm_L = findAssist.GetTransformFromName("N_Arm_L");
            targetAccessory.acs_Arm_R = findAssist.GetTransformFromName("N_Arm_R");
            targetAccessory.acs_Wrist_L = findAssist.GetTransformFromName("N_Wrist_L");
            targetAccessory.acs_Wrist_R = findAssist.GetTransformFromName("N_Wrist_R");
            targetAccessory.acs_Hand_L = findAssist.GetTransformFromName("N_Hand_L");
            targetAccessory.acs_Hand_R = findAssist.GetTransformFromName("N_Hand_R");
            targetAccessory.acs_Index_L = findAssist.GetTransformFromName("N_Index_L");
            targetAccessory.acs_Index_R = findAssist.GetTransformFromName("N_Index_R");
            targetAccessory.acs_Middle_L = findAssist.GetTransformFromName("N_Middle_L");
            targetAccessory.acs_Middle_R = findAssist.GetTransformFromName("N_Middle_R");
            targetAccessory.acs_Ring_L = findAssist.GetTransformFromName("N_Ring_L");
            targetAccessory.acs_Ring_R = findAssist.GetTransformFromName("N_Ring_R");
            targetAccessory.acs_Dan = findAssist.GetTransformFromName("N_Dan");
            targetAccessory.acs_Kokan = findAssist.GetTransformFromName("N_Kokan");
            targetAccessory.acs_Ana = findAssist.GetTransformFromName("N_Ana");
            targetEtc.trfRoot = findAssist.GetTransformFromName("cf_J_Hips");
            targetEtc.trfHeadParent = findAssist.GetTransformFromName("cf_J_Head_s");
            targetEtc.trfNeckLookTarget = findAssist.GetTransformFromName("cf_J_Spine03");
            targetEtc.trfAnaCorrect = findAssist.GetTransformFromName("cf_J_Ana");
            targetEtc.trf_k_shoulderL_00 = findAssist.GetTransformFromName("k_f_shoulderL_00");
            targetEtc.trf_k_shoulderR_00 = findAssist.GetTransformFromName("k_f_shoulderR_00");
            targetEtc.trf_k_handL_00 = findAssist.GetTransformFromName("k_f_handL_00");
            targetEtc.trf_k_handR_00 = findAssist.GetTransformFromName("k_f_handR_00");
            dbcBust = new DynamicBoneCollider[4];
            var objectFromName = findAssist.GetObjectFromName("cf_hit_Mune02_s_L");
            dbcBust[0] = objectFromName.GetComponent<DynamicBoneCollider>();
            objectFromName = findAssist.GetObjectFromName("cf_hit_Mune021_s_L");
            dbcBust[1] = objectFromName.GetComponent<DynamicBoneCollider>();
            objectFromName = findAssist.GetObjectFromName("cf_hit_Mune02_s_R");
            dbcBust[2] = objectFromName.GetComponent<DynamicBoneCollider>();
            objectFromName = findAssist.GetObjectFromName("cf_hit_Mune021_s_R");
            dbcBust[3] = objectFromName.GetComponent<DynamicBoneCollider>();
        }

        public void InactiveBustDynamicBoneCollider()
        {
            foreach (var dynamicBoneCollider in dbcBust)
                if (null != dynamicBoneCollider)
                    dynamicBoneCollider.enabled = false;
        }

        public void InitDynamicBonesBustAndHip()
        {
        }

        public void GetDynamicBoneBustAndHip()
        {
        }

        public void GetDynamicBoneBustAndHip(int area)
        {
        }

        public void ResetDynamicBonesBustAndHip(bool includeInactive = false)
        {
        }

        public void EnableDynamicBonesBustAndHip(bool enable, int area)
        {
            if (dynamicBonesBustAndHip == null || area >= dynamicBonesBustAndHip.Length) return;
            if (null == dynamicBonesBustAndHip[area]) return;
            if (dynamicBonesBustAndHip[area].enabled != enable) dynamicBonesBustAndHip[area].enabled = enable;
        }

#endif
    }
}