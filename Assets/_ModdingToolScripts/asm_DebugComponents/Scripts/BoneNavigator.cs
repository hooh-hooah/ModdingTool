using System.Collections.Generic;
using System.Linq;
using UnityEditor;
using UnityEngine;

namespace DebugComponents
{
    [DisallowMultipleComponent]
    public class BoneNavigator : MonoBehaviour
    {
        public static readonly Dictionary<string, string> AccessoryPoints = new Dictionary<string, string>
        {
            {"N_Waist_b", "Waist Back"},
            {"N_Waist_f", "Waist Fron"},
            {"N_Waist_L", "Waist Left"},
            {"N_Waist_R", "Waist Right"},
            {"N_Ana", "Ana"},
            {"N_Kokan", "Kokan"},
            {"N_Knee_L", "Knee Left"},
            {"N_Foot_L", "Foot Left"},
            {"N_Ankle_L", "Ankle Left"},
            {"N_Leg_L", "Leg Left"},
            {"N_Knee_R", "Knee Right"},
            {"N_Foot_R", "Foot Right"},
            {"N_Ankle_R", "Ankle Right"},
            {"N_Leg_R", "Leg Right"},
            {"N_Dan", "Dicc"},
            {"N_Tikubi_L", "Nip L"},
            {"N_Tikubi_R", "Nip R"},
            {"N_Mouth", "Mouth"},
            {"N_Earring_L", "Earring L"},
            {"N_Earring_R", "Earring R"},
            {"N_Head", "Head"},
            {"N_Hair", "Hair"},
            {"N_Nose", "Nose"},
            {"N_Megane", "Glasses"},
            {"N_Neck", "Neck"},
            {"N_Elbo_L", "Elbow L"},
            {"N_Index_L", "Index Finger L"},
            {"N_Middle_L", "Middle Finger L"},
            {"N_Ring_L", "Ring Finger L"},
            {"N_Hand_L", "Hand L"},
            {"N_Wrist_L", "Wrist L"},
            {"N_Arm_L", "Arm L"},
            {"N_Shoulder_L", "Shoulder L"},
            {"N_Elbo_R", "Elbow R"},
            {"N_Index_R", "Index Finger R"},
            {"N_Middle_R", "Middle Finger R"},
            {"N_Ring_R", "Ring Finger R"},
            {"N_Hand_R", "Hand R"},
            {"N_Wrist_R", "Wrist R"},
            {"N_Arm_R", "Arm R"},
            {"N_Shoulder_R", "Shoulder R"},
            {"N_Back", "Back"},
            {"N_Back_L", "Back L"},
            {"N_Back_R", "Back R"},
            {"N_Chest", "Chest"},
            {"N_Chest_f", "Chest Front"}
        };

#if UNITY_EDITOR
        public void NavigateToBone(string bone)
        {
            var target = GetComponentsInChildren<Transform>().Single(x => bone == x.name);
            if (target != null) Selection.activeObject = target.gameObject;
        }
#endif
    }
}