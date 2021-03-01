using System;
using System.IO;
using MyBox;
using UnityEngine;

namespace DebugComponents
{
    public class AnimationPreview : MonoBehaviour
    {
        public string basePath;
        public string animationPath;
        public string controllerPath;
        public string clipPath;
        private Animator _anim;

        public void Start()
        {
            _anim = this.GetOrAddComponent<Animator>();
        }

        [ButtonMethod()]
        public void LoadAnimation()
        {
            var path = Path.Combine(basePath, animationPath);
            if (!path.EndsWith(".unity3d"))
            {
                path += ".unity3d";
            }
            
            AssetBundle.UnloadAllAssetBundles(false);
            if (File.Exists(path))
            {
                var bundle = AssetBundle.LoadFromFile(path);
                if (!bundle) return;
                var controller = bundle.LoadAsset<RuntimeAnimatorController>(controllerPath);
                _anim.runtimeAnimatorController = controller;
                _anim.Play(clipPath);
            }
            else
            {
                Debug.LogError($"{path} does not exists.");
            }
        }
    }
}