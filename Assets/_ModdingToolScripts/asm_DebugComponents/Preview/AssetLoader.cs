#if UNITY_EDITOR
using System.IO;
using System.Linq;
using MyBox;
using UnityEditor;
using UnityEngine;

namespace DebugComponents
{
    public class AssetLoader : MonoBehaviour, PreviewInterface
    {
        public DefaultAsset something;

        [ButtonMethod]
        public void LoadAsset()
        {
            var assetPath = Path.Combine(Application.dataPath.Replace("Assets", ""), AssetDatabase.GetAssetPath(something));
            AssetBundle.UnloadAllAssetBundles(true);
            var bundle = AssetBundle.LoadFromFile(assetPath);
            var prefabs = bundle.GetAllAssetNames().Where(x => x.EndsWith(".prefab")).ToList();
            foreach (var prefab in prefabs)
            {
                var asset = bundle.LoadAsset<GameObject>(prefab);
                var gameObject = Instantiate(asset);
                gameObject.name = "faggot";
                gameObject.transform.parent = transform;
            }
        }
    }
}
#endif