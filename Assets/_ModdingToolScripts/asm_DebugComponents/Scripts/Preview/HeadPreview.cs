using System.IO;
using MyBox;
using UnityEngine;

namespace DebugComponents
{
    public class HeadPreview : MonoBehaviour
    {
        public string GamePath;
        public RuntimeAnimatorController Controller;
        public string GetPath(string value) => Path.Combine(GamePath, value);
        public void LoadAsset(string bundle, string name)
        {
            AssetBundle.UnloadAllAssetBundles(true);
            var assetBundle = AssetBundle.LoadFromFile(bundle);
            var asset = assetBundle.LoadAsset<GameObject>(name);
            var instance = Instantiate(asset);
            var shapeAnimRoot = instance.transform.GetChild(1);
            var animator = shapeAnimRoot.GetOrAddComponent<Animator>();
            animator.runtimeAnimatorController = Controller;
        }

        [ButtonMethod()]
        public void LoadHeadA()
        {
            LoadAsset(GetPath("chara\\00\\fo_head_00.unity3d"), "p_cf_head_00");
        }

        [ButtonMethod()]
        public void LoadHeadB()
        {
            LoadAsset(GetPath("chara\\00\\fo_head_00.unity3d"), "p_cf_head_01");
        }

        [ButtonMethod()]
        public void LoadHeadC()
        {
            LoadAsset(GetPath("chara\\00\\fo_head_30.unity3d"), "p_cf_head_02");
        }
    }
}