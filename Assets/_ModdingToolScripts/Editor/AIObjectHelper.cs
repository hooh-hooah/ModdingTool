using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using DebugComponents;
using MyBox;
using UnityEditor;
using UnityEngine;
using Object = UnityEngine.Object;

public class AIObjectHelper {
     public enum Command
     {
         Hair = 0,
         Clothing = 1,
         Accessory = 2,
         StudioItem = 3,
         HS2Map = 10,
         AIMap = 20,
         RemoveAll = 999,
     }
     
    public static void InitializeHair(GameObject selectedObject, int preset = 0) {
        GameObject hairObject = selectedObject;
        hairObject.layer = 10;

        if (hairObject != null) {
            AIChara.CmpHair hairComponent = hairObject.GetOrAddComponent<AIChara.CmpHair>();
            hairComponent.ReassignAllObjects();
        }
    }

    public static void InitializeItem(GameObject selectedObject) {
        GameObject studioItemObject = selectedObject;
        studioItemObject.layer = 10;

        if (studioItemObject != null) {
            Studio.ItemComponent itemComponent = studioItemObject.GetOrAddComponent<Studio.ItemComponent>();
            itemComponent.InitializeItem();
        }
    }

    public static void InitializeAccessory(GameObject selectedObject) {
        GameObject hairObject = selectedObject;
        hairObject.layer = 10;

        if (hairObject != null) {
            AIChara.CmpAccessory accComponent = hairObject.GetOrAddComponent<AIChara.CmpAccessory>();
            accComponent.ReassignAllObjects();
        }
    }

    public static void InitializeClothes(GameObject selectedObject) {
        GameObject clotheObject = selectedObject;
        clotheObject.layer = 10;

        if (clotheObject != null) {
            AIChara.CmpClothes clotheComponent = clotheObject.GetOrAddComponent<AIChara.CmpClothes>();
            clotheComponent.ReassignAllObjects();
        }
    }
    
    public static void InitializeFace(GameObject selectedObject) {

    }

    public static void InitializeMap(GameObject selectedObject)
    {
        if (selectedObject != null) {
            if (selectedObject.transform.parent == null)
            {
                // add some hs2 map shits
            }
            else
            {
                EditorUtility.DisplayDialog($"Error", $"The map component should be in the top hierarchy of the scene but selected game object has parent.", "OK");
            }
        }
    }
}

