using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using UnityEditor;
using UnityEngine;

public class BlenderAssetProcessor : AssetPostprocessor
{
    // TODO: Make some sort of generic rule to process 
    private void OnPreprocessModel()
    {
        /*
         * Rules
         */
        var fileName = Path.GetFileNameWithoutExtension(assetPath).ToLower();
        var folderNames = Path.GetFileName(Path.GetDirectoryName(assetPath));
        var splitText = fileName.Split('.');

        if (splitText.Length >= 3)
        {
            var importer = assetImporter as ModelImporter;
            var meshType = splitText[0];
            var preset = splitText[1];
            var name = splitText[2];

            // TODO: Automatic Substance Material Generation and assignment.
            importer.importCameras = false;
            importer.importConstraints = false;
            importer.importLights = false;
            importer.importAnimation = false;
            importer.weldVertices = true;
            importer.preserveHierarchy = true;
            importer.normalCalculationMode = ModelImporterNormalCalculationMode.AreaAndAngleWeighted;
            importer.importTangents = ModelImporterTangents.Import;
            importer.importBlendShapeNormals = ModelImporterNormals.Import;
            importer.importNormals = ModelImporterNormals.Import;

            // make it some database or something later, i'm so lazy atm
            switch (meshType)
            {
                case "옷":
                case "의상":
                case "服":
                case "衣":
                case "outfit":
                case "clothing":
                    switch (preset)
                    {
                        case "acc":
                        case "accessory":
                        case "악세서리":
                        case "アクセサリー":
                        case "アクセ":
                        case "악세":

                            break;

                        case "top":
                        case "bottom":
                        case "skirt":
                        default:
                            break;
                    }

                    break;
            }
        }

        // TODO: Apply Avatar Filters for every single animations.
        // TODO: Apply Avatar on every single clothings.
        if (assetPath.Contains("@CLOTHES_ASSETS"))
        {
            var modelImporter = assetImporter as ModelImporter;
            modelImporter.importAnimation = false;
            modelImporter.importCameras = false;
            modelImporter.importConstraints = false;
            modelImporter.importLights = false;
            modelImporter.isReadable = true;
            modelImporter.optimizeMesh = false;
        }
    }

    static private Regex animRegex = new Regex(@"Armature\|", RegexOptions.IgnoreCase | RegexOptions.Compiled);
    public void OnPreprocessAnimation()
    {
        if (assetPath.Contains("hs_anim"))
        {
            var modelImporter = assetImporter as ModelImporter;

            modelImporter.animationType = ModelImporterAnimationType.Generic;
            modelImporter.sourceAvatar = Resources.Load<Avatar>("AI_Generic");
            var animationMask = Resources.Load<AvatarMask>("HS_MaskAvatar");

            var defaultAnimations = modelImporter.defaultClipAnimations;
            foreach (var animation in defaultAnimations)
            {
                animation.loopTime = true;
                animation.maskType = ClipAnimationMaskType.CopyFromOther;
                animation.maskSource = animationMask;
                animation.ConfigureClipFromMask(animationMask);
            }

            modelImporter.clipAnimations = defaultAnimations;
        }

        // prepare all humanoid animations ready to bake with Animation Converter.
        if (assetPath.Contains("src_"))
        {
            var name = Path.GetFileNameWithoutExtension(assetPath);
            var modelImporter = assetImporter as ModelImporter;
            if (modelImporter == null || modelImporter.animationType != ModelImporterAnimationType.Human) return;
            modelImporter.humanoidOversampling = ModelImporterHumanoidOversampling.X2;
            modelImporter.clipAnimations = modelImporter.defaultClipAnimations.Select(clip =>
            {
                clip.name = animRegex.Replace(clip.name, "");
                clip.loopTime = true;
                clip.lockRootRotation = true;
                clip.lockRootHeightY = true;
                clip.lockRootPositionXZ = true;
                clip.keepOriginalOrientation = true;
                clip.keepOriginalPositionY = true;
                clip.keepOriginalPositionXZ = true;
                return clip;
            }).ToArray();
        }
    }
}