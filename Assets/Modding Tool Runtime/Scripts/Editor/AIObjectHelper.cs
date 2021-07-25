using System.Linq;
using AIChara;
using MyBox;
using Studio;
using UnityEditor;
using UnityEngine;

public class AIObjectHelper
{
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

    public static void RemoveAllModRelatedObjects(Transform transform)
    {
        transform.gameObject.GetComponents<Component>().Where(x => x is CmpBase).ToList()
            .ForEach(Object.DestroyImmediate);
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

    private static bool IsRootBone(Transform transform)
    {
        return Enumerable.Range(0, transform.childCount).Any(x => transform.GetChild(x).name == "cf_N_height");
    }

    public static bool InitializeSkinnedAccessory(GameObject selectedObject)
    {
        var gameObject = selectedObject;
        gameObject.layer = 10;
        if (gameObject == null) return false;

        var accComponent = gameObject.GetOrAddComponent<CmpAccessory>();
        // var skinnedComponent = gameObject.GetOrAddComponent<SkinnedAccessory>();
        // foreach (var animator in gameObject.GetComponentsInChildren<Animator>()) Object.DestroyImmediate(animator);
        //
        // skinnedComponent.meshRenderers = gameObject.GetComponentsInChildren<SkinnedMeshRenderer>().ToList();
        // var selectedTransform = selectedObject.transform;
        // skinnedComponent.skeleton = Enumerable.Range(0, selectedTransform.childCount)
        //     .Select(x => selectedTransform.GetChild(x))
        //     .FirstOrDefault(IsRootBone)?.gameObject;
        //
        // if (skinnedComponent.skeleton == null)
        //     return EditorUtility.DisplayDialog("Warning", "This model does not seems a model for skinned accessory.\nPlease check the model has basic character armature rig.",
        //         "OK");
        //
        // if (skinnedComponent.meshRenderers.Count <= 0)
        //     return EditorUtility.DisplayDialog("Warning", "This model does not seems have any SkinnedMeshRenderer.\nPlease check if the model is rigged/imported properly.", "OK");
        //
        // skinnedComponent.skeleton.name = "cf_J_Root";
        // accComponent.ReassignAllObjects();

        return true;
    }

    public static bool InitializeClothes(GameObject selectedObject)
    {
        var target = selectedObject;
        target.layer = 10;

        if (target == null) return false;

        if (!target.GetComponentsInChildren<SkinnedMeshRenderer>().Any())
            return EditorUtility.DisplayDialog("Warning",
                "It seems like this model does not have any skinned mesh renderer.\nPlease check if you imported the model with correct option.",
                "Hnng");

        if (target.GetComponentsInChildren<MeshRenderer>().Any())
            return EditorUtility.DisplayDialog("Warning",
                "You can't use MeshRenderer Component for the clothing.\nMake sure the model is properly rigged in 3D Modeling Software.",
                "Okay...?");


        Transform rootBoneCandidate = null;
        for (var i = target.transform.childCount - 1; i >= 0; i--)
        {
            var child = target.transform.GetChild(i);
            if (!IsRootBone(child)) continue;
            rootBoneCandidate = child;
            break;
        }

        if (rootBoneCandidate == null)
            return EditorUtility.DisplayDialog("Warning",
                "It seems like the model does not have any kind of root bone candidates.", "Yas");

        rootBoneCandidate.name = "cf_J_Root";
        var clotheComponent = target.GetOrAddComponent<CmpClothes>();
        clotheComponent.ReassignAllObjects();

        return true;
    }

    public static void InitializeFace(GameObject selectedObject)
    {
    }

    public static void InitializeFurniture(GameObject transformGameObject)
    {
        var housingFurniture = transformGameObject.GetOrAddComponent<Housing.ItemComponent>();
        housingFurniture.InitializeItem();
    }
}