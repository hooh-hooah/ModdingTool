using System.Collections.Generic;
using System.Linq;
using UnityEditor;
using UnityEngine;

public class BaseBoneNavigator : MonoBehaviour
{
    public static readonly Dictionary<string, string> AccessoryPoints = new Dictionary<string, string>
    {
        {"Hair Pony", "N_Hair_pony"},
        {"Hair Twin L", "N_Hair_twin_L"},
        {"Hair Twin R", "N_Hair_twin_R"},
        {"Hair Pin L", "N_Hair_pin_L"},
        {"Hair Pin R", "N_Hair_pin_R"},
        {"Head Top", "N_Head_top"},
        {"Head", "N_Head"},
        {"Hitai", "N_Hitai"},
        {"Face", "N_Face"},
        {"Megane", "N_Megane"},
        {"Earring L", "N_Earring_L"},
        {"Earring R", "N_Earring_R"},
        {"Nose", "N_Nose"},
        {"Mouth", "N_Mouth"}
    };

    public GameObject[] baseMesh;
    public GameObject[] skinnedMesh;

    #if UNITY_EDITOR
    public void NavigateToBone(string bone)
    {
        var target = GetComponentsInChildren<Transform>().Single(x => bone == x.name);
        if (target != null) Selection.activeObject = target.gameObject;
    }
    #endif
}