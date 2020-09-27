using System.Linq;
using AIChara;
using MyBox;
using Studio;
using UnityEditor;
using UnityEngine;

public class AIObjectHelper
{
    public enum Command
    {
        Hair,
        Clothing,
        Accessory,
        AccessoryWithTransform,
        AccessorySkinned,
        StudioItem,
        HS2Map = 10,
        AIMap = 20,
        RemoveAll = 999
    }

    public static void InitializeHair(GameObject selectedObject, int preset = 0)
    {
        var hairObject = selectedObject;
        hairObject.layer = 10;

        if (hairObject == null) return;
        var hairComponent = hairObject.GetOrAddComponent<CmpHair>();
        hairComponent.ReassignAllObjects();
    }

    public static void InitializeItem(GameObject selectedObject)
    {
        var studioItemObject = selectedObject;
        studioItemObject.layer = 10;

        if (studioItemObject == null) return;
        var itemComponent = studioItemObject.GetOrAddComponent<ItemComponent>();
        itemComponent.InitializeItem();
    }

    public static void InitializeAccessory(GameObject selectedObject, bool initializeTransform = false)
    {
        var gameObject = selectedObject;
        gameObject.layer = 10;
        if (gameObject == null) return;

        CmpAccessory accComponent;

        if (initializeTransform)
        {
            var newWrapper = new GameObject(gameObject.name + "_acc");

            if (gameObject.transform.parent != null)
            {
                newWrapper.transform.position = Vector3.zero;
                newWrapper.transform.eulerAngles = Vector3.zero;
                newWrapper.transform.localScale = Vector3.one;
                newWrapper.transform.SetParent(gameObject.transform.parent, false);
            }

            var newRoot = new GameObject("N_move");
            newRoot.transform.position = gameObject.transform.position;
            newRoot.transform.eulerAngles = Vector3.zero;
            newRoot.transform.localScale = Vector3.one;

            newRoot.transform.parent = newWrapper.transform;
            gameObject.transform.parent = newRoot.transform;
            accComponent = newWrapper.GetOrAddComponent<CmpAccessory>();
        }
        else
        {
            accComponent = gameObject.GetOrAddComponent<CmpAccessory>();
        }

        accComponent.ReassignAllObjects();
    }

    public static void InitializeSkinnedAccessory(GameObject selectedObject)
    {
        var gameObject = selectedObject;
        gameObject.layer = 10;
        if (gameObject == null) return;

        var accComponent = gameObject.GetOrAddComponent<CmpAccessory>();
        var skinnedComponent = gameObject.GetOrAddComponent<SkinnedAccessory>();
        foreach (var animator in gameObject.GetComponentsInChildren<Animator>()) Object.DestroyImmediate(animator);

        skinnedComponent.meshRenderers = gameObject.GetComponentsInChildren<SkinnedMeshRenderer>().ToList();
        skinnedComponent.skeleton = gameObject.GetComponentsInChildren<Transform>().FirstOrDefault(x => x.name.Equals("cf_J_Root"))?.gameObject;

        if (skinnedComponent.skeleton == null)
            EditorUtility.DisplayDialog("Warning", "This model does not seems a model for skinned accessory.\nPlease check the model has basic character armature rig.", "OK");
        else if (skinnedComponent.meshRenderers.Count <= 0)
            EditorUtility.DisplayDialog("Warning", "This model does not seems have any SkinnedMeshRenderer.\nPlease check if the model is rigged/imported properly.", "OK");

        accComponent.ReassignAllObjects();
    }

    public static void InitializeClothes(GameObject selectedObject)
    {
        var clotheObject = selectedObject;
        clotheObject.layer = 10;

        if (clotheObject == null) return;
        var clotheComponent = clotheObject.GetOrAddComponent<CmpClothes>();
        clotheComponent.ReassignAllObjects();
    }

    public static void InitializeFace(GameObject selectedObject)
    {
    }

}