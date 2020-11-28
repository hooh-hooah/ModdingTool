using System.Collections;
using System.Collections.Generic;
using System.Linq;
using AIChara;
using JetBrains.Annotations;
using MyBox;
using UnityEditor;
using UnityEngine;

public static class SkinnedBones
{
    private static readonly Dictionary<ChaControl, Dictionary<string, Transform>> TransformCache =
        new Dictionary<ChaControl, Dictionary<string, Transform>>();

    // Skip unnecessary skinned bones to make traverse more efficient.
    // Containment O(1)
    private static readonly HashSet<string> Blacklist = new HashSet<string>
    {
        "cf_J_Root", "cf_t_root", "N_Neck", "N_Chest_f", "N_Chest", "N_Tikubi_L",
        "N_Tikubi_R", "N_Back", "N_Back_L", "N_Back_R", "N_Waist", "N_Waist_f", "N_Waist_b",
        "N_Waist_L", "N_Waist_R", "N_Leg_L", "N_Leg_R", "N_Knee_L", "N_Knee_R", "N_Ankle_L",
        "N_Ankle_R", "N_Foot_L", "N_Foot_R", "N_Shoulder_L", "N_Shoulder_R", "N_Elbo_L", "N_Elbo_R",
        "N_Arm_L", "N_Arm_R", "N_Wrist_L", "N_Wrist_R", "N_Hand_L", "N_Hand_R", "N_Index_L",
        "N_Index_R", "N_Middle_L", "N_Middle_R", "N_Ring_L", "N_Ring_R", "N_Dan",
        "N_Kokan", "N_Ana", "N_Hair_pony", "N_Hair_twin_L", "N_Hair_twin_R", "N_Hair_pin_L", "N_Hair_pin_R",
        "N_Head_top", "N_Head", "N_Hitai", "N_Face", "N_Megane",
        "N_Earring_L", "N_Earring_R", "N_Nose", "N_Mouth"
    };

    public static bool TryGetSkinnedBones(ChaControl chaControl, out Dictionary<string, Transform> result)
    {
        if (chaControl == null || ReferenceEquals(chaControl.objBodyBone, null))
        {
            result = null;
            return false;
        }

        if (TransformCache.TryGetValue(chaControl, out var dict))
        {
            result = dict;
            return true;
        }

        dict = new Dictionary<string, Transform>();
        GetBonesRecursive(dict, chaControl.objBodyBone.transform);

        if (dict.Count <= 0)
        {
            result = null;
            return false;
        }

        TransformCache[chaControl] = dict;
        result = TransformCache[chaControl];
        return true;
    }


    // reject cf_J_Roots to prevent duplicated bone collections
    private static void GetBonesRecursive(IDictionary<string, Transform> dict, Transform targetTransform)
    {
        dict[targetTransform.name] = targetTransform;

        for (var i = 0; i < targetTransform.childCount; i++)
        {
            var childTransform = targetTransform.GetChild(i);
            if (!Blacklist.Contains(childTransform.name)) GetBonesRecursive(dict, childTransform);
        }
    }

    public static void CleanUpCache(ChaControl chaControl)
    {
        // reserved for unknown cleanup task.
        if (TransformCache.ContainsKey(chaControl)) TransformCache.Remove(chaControl);
    }
}

[DisallowMultipleComponent]
public class SkinnedAccessory : MonoBehaviour
{
    private static readonly Bounds bound = new Bounds(new Vector3(0f, 10f, 0f), new Vector3(20f, 20f, 20f));
    private ChaControl _chaControl;
    private int _done;
    public List<SkinnedMeshRenderer> meshRenderers;
    public GameObject skeleton;

    private void Awake()
    {
        _chaControl = GetComponentInParent<ChaControl>();

        StartCoroutine(nameof(TryMerge));
    }

    private IEnumerator TryMerge()
    {
        var startTime = Time.time;
        yield return new WaitUntil(() => _chaControl != null || Time.time - startTime > 100);

        // TryGetSkinnedBones includes dictionary check and chaControl checks.
        if (ReferenceEquals(_chaControl, null) || !SkinnedBones.TryGetSkinnedBones(_chaControl, out var dict)) yield break;
        meshRenderers.ForEach(smr =>
        {
            smr.enabled = false;
            smr.rootBone = _chaControl.objBodyBone.transform;
            StartCoroutine(MergeCoroutine(smr, dict));
        });
    }

    private IEnumerator MergeCoroutine(SkinnedMeshRenderer smr, [NotNull] IReadOnlyDictionary<string, Transform> dict)
    {
        try
        {
            // Sometimes it's not really null.
            // So gotta double check object wise and unity wise. it looks dumb tbh
            smr.bones = smr.bones
                .Select(boneTransform => dict.TryGetValue(boneTransform.name, out var bone) ? bone : null)
                .ToArray();
            smr.enabled = true;
            smr.localBounds = bound;

            // well shit if i could track coroutines like god damn async
        }
        finally
        {
            _done++;
            if (_done == meshRenderers.Count) DestroyImmediate(skeleton);
        }

        yield break;
    }

#if UNITY_EDITOR
    [ButtonMethod]
    public void Initialize()
    {
        skeleton = GetComponentsInChildren<Transform>(true)?.First(x => x.name.ToLower() == "cf_j_root")?.gameObject;
        var renderers = GetComponentsInChildren<SkinnedMeshRenderer>().ToList();
        renderers.ForEach(x =>
        {
            var t = x.transform;
            t.localScale = Vector3.one;
            t.localPosition = Vector3.zero;
            t.localRotation = Quaternion.identity;
        });
        meshRenderers = renderers;
        EditorUtility.SetDirty(this);
    }

    // to prevent mistakes made by modders.
    public bool ValidateObject()
    {
        // skeleton must be there
        // it should have at least one mesh renderers.
        // it should not have any null mesh renderers.
        return !ReferenceEquals(null, skeleton) && meshRenderers.Count > 0 && !meshRenderers.Any(x => ReferenceEquals(null, x));
    }
#endif
}