using System.Collections;
using System.Collections.Generic;
using System.Linq;
using AIChara;
using JetBrains.Annotations;
using MyBox;
using UnityEditor;
using UnityEngine;

[DisallowMultipleComponent]
public class SkinnedAccessory : MonoBehaviour
{
    private static readonly Dictionary<ChaControl, Dictionary<string, Transform>>
        TransformCache = new Dictionary<ChaControl, Dictionary<string, Transform>>(); // we should able to control empty one. - do it in global plugin hooks.

    private static readonly Bounds bound = new Bounds(new Vector3(0f, 10f, 0f), new Vector3(20f, 20f, 20f));

    private ChaControl _chaControl;
    private int _done;
    public List<SkinnedMeshRenderer> meshRenderers;
    public GameObject skeleton;

    private void Awake()
    {
        _chaControl = GetComponentInParent<ChaControl>();

        if (ReferenceEquals(null, _chaControl))
        {
            Debug.LogError("Couldn't find ChaControl from the parent.");
            enabled = false;
            return;
        }

        if (!TransformCache.ContainsKey(_chaControl))
            TransformCache[_chaControl] = _chaControl.objBodyBone.GetComponentsInChildren<Transform>(true)
                .GroupBy(x => x.name)
                .Select(x => x.First())
                .ToDictionary(x => x.name);

        TryMerge();
    }
    
    private void TryMerge()
    {
        if (ReferenceEquals(_chaControl, null) || !TransformCache.TryGetValue(_chaControl, out var dict) || dict.Count < 0) return;
        var bodyBone = _chaControl.objBodyBone;
        if (ReferenceEquals(null, bodyBone)) return;
        meshRenderers.ForEach(smr =>
        {
            smr.enabled = false;
            smr.rootBone = bodyBone.transform;
            StartCoroutine(MergeCoroutine(smr, dict));
        });
    }

    private IEnumerator MergeCoroutine(SkinnedMeshRenderer smr, [NotNull] Dictionary<string, Transform> dict)
    {
        smr.bones = smr.bones.Select(x =>
            dict.TryGetValue(x.name, out var t)
            
                ? t
                : x).ToArray();
        smr.enabled = true;
        smr.localBounds = bound;

        // well shit if i could track coroutines like god damn async
        _done++;
        if (_done == meshRenderers.Count) DestroyImmediate(skeleton);
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