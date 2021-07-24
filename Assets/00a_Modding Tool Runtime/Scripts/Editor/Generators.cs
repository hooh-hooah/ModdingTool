using System.IO;
using System.Linq;
using System.Text;
using ModPackerModule.Utility;
using UnityEditor;
using UnityEditor.Animations;
using UnityEngine;

namespace Generator
{
    public class Generators : EditorWindow
    {
        private const string AnimPrefix = "anim_";
        private const string OutputFolder = "output";
        private const string AnimExtension = ".anim";

        // Show control window - WiP
        [MenuItem("Assets/Generator/Modify Animation Masks")]
        public static void ModifyAnimationMasks()
        {
            foreach (var controller in AssetDatabase
                .FindAssets("t:AnimatorController", new[] {PathUtils.GetProjectPath()})
                .Select(AssetDatabase.GUIDToAssetPath)
                .Select(AssetDatabase.LoadAssetAtPath<AnimatorController>))
                controller.layers = controller.layers.Select(x =>
                {
                    x.avatarMask = Resources.Load<AvatarMask>("HS_MaskAvatar");
                    x.name = "Main Layer";
                    return x;
                }).ToArray();
        }

        // Show control window - WiP
        [MenuItem("Assets/Generator/Generate Animator Controller")]
        public static void GenerateAnimatorController()
        {
            var path = PathUtils.GetProjectPath();
            var outputPath = Path.Combine(path, OutputFolder);

            var animationFolders = Directory.GetDirectories(path)
                .Where(x => Path.GetFileName(x).StartsWith(AnimPrefix))
                .ToArray();

            if (animationFolders.Length <= 0)
            {
                EditorUtility.DisplayDialog("Error", $"This folder does not have any folder has prefix '{AnimPrefix}'!",
                    "I'll make one");
                return;
            }

            var animationClips = AssetDatabase.FindAssets("t:AnimationClip", animationFolders)
                .Select(AssetDatabase.GUIDToAssetPath)
                .Distinct()
                .Where(x => !x.EndsWith(".blend"))
                .Select(assetPath =>
                {
                    if (assetPath.EndsWith(AnimExtension))
                        return new object[]
                        {
                            Path.GetDirectoryName(assetPath),
                            new[] {AssetDatabase.LoadAssetAtPath<AnimationClip>(assetPath)}
                        };

                    var asset = AssetDatabase.LoadAllAssetRepresentationsAtPath(assetPath).OfType<AnimationClip>()
                        .ToArray();
                    return new object[]
                    {
                        Path.GetFileNameWithoutExtension(assetPath), asset
                    };
                })
                .Where(x => x.Length > 0)
                .GroupBy(x => (string) x[0], x => (AnimationClip[]) x[1])
                .ToDictionary(x => x.Key, x => x);

            var builder = new StringBuilder();
            var index = 0;
            foreach (var pair in animationClips)
            {
                var controllerName = $"controller_{index}.controller";
                var controller =
                    AnimatorController.CreateAnimatorControllerAtPath(Path.Combine(outputPath, controllerName));
                var animations = pair.Value.SelectMany(x => x).ToList();
                controller.layers = controller.layers.Select(layer =>
                {
                    layer.avatarMask = Resources.Load<AvatarMask>("HS_MaskAvatar");
                    return layer;
                }).ToArray();
                var baseLayer = controller.layers.First();
                var rootStateMachine = baseLayer.stateMachine;

                animations.ForEach(x =>
                {
                    var animationState = rootStateMachine.AddState(x.name);
                    animationState.motion = x;
                    rootStateMachine.AddEntryTransition(animationState);
                    builder.AppendLine($"{pair.Key},{controllerName},{x.name}");
                });
                index++;
            }

            File.WriteAllText(Path.Combine(Directory.GetCurrentDirectory(), path, "generated_animations.txt"),
                builder.ToString());
        }
    }
}