using System.Linq;
using System.Text.RegularExpressions;
using MyBox;
using UnityEngine;

namespace DebugComponents
{
    public class ClothingBindHelper : MonoBehaviour, PreviewInterface
    {
        private static readonly Regex stinkyFuckerDetector = new Regex(@"^(N_.*|k_f_.*|cm_J.*|f_pv.*|GameObject.*|k_m_.*|cf_hit_.*|aim|ColFace.*|.*Ref$)");

        public GameObject boneRoot;

        public static bool FuckBoyFilter(string shitname)
        {
            return !stinkyFuckerDetector.IsMatch(shitname);
        }

        public void AnalMastery()
        {
            var bitch = transform.Find("cf_J_Root");
            // fuck my life and your shits
            var bones = bitch.GetComponentsInChildren<Transform>().GroupBy(x => x.name)
                .Select(x => x.FirstOrDefault()).Where(x => FuckBoyFilter(x.name));

            GetComponentsInChildren<SkinnedMeshRenderer>().ToList().ForEach(x =>
            {
                x.rootBone = bitch;
                x.bones = bones.ToArray();
                x.sharedMesh.RecalculateBounds(); // ayy
            });
        }

        [ButtonMethod]
        private void BindAllSkinnedMeshRenderers()
        {
            boneRoot.GetComponentsInChildren<SkinnedMeshRenderer>().ToList().ForEach(x => DestroyImmediate(x.gameObject));

            var renderers = GetComponentsInChildren<SkinnedMeshRenderer>();
            foreach (var r in renderers)
            {
                var newObject = Instantiate(r.gameObject, boneRoot.transform.parent);
                newObject.transform.name = r.name; // fuck you clone
                var renderer = newObject.GetComponent<SkinnedMeshRenderer>();

                renderer.rootBone = boneRoot.transform;
                var boneNames = renderer.bones.ToDictionary(x => x.name);
                boneRoot.GetComponentsInChildren<Transform>().ToList().ForEach(x =>
                {
                    if (boneNames.ContainsKey(x.name))
                        boneNames[x.name] = x;
                });

                renderer.bones = boneNames.Values.ToArray();
                renderer.sharedMesh.RecalculateBounds();
            }
        }
    }
}