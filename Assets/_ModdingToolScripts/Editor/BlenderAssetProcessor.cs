using System;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using UnityEditor;
using UnityEditor.Presets;
using UnityEngine;

struct BlenderExportMesh
{
    public string name;
    public string type;
    public string diffuse;
    public string colormask;
    public string diffuse2;
    public string colormask2;
    public string diffuse3;
    public string colormask3;
}

struct BlenderExportModel
{
    public string rootBoneName;
    public BlenderExportMesh meshes;
}

struct BlenderExportInfo
{
    public DateTime lastExport;
    public string mode;
    public string id;
    public string name;
    public BlenderExportModel model;
}

public class BlenderAssetProcessor : AssetPostprocessor
{
    // TODO: Make some sort of generic rule to process

    private void OnPreprocessModel()
    {
        var fileName = Path.GetFileNameWithoutExtension(assetPath).ToLower();
        var extName = Path.GetExtension(assetPath);
        var folderName = Path.GetDirectoryName(assetPath);

        // TODO: will be used for automatic prefab/mod construction from the scratch
        var exportDataPath = Path.Combine(folderName ?? string.Empty, fileName + ".json");

        if (!File.Exists(exportDataPath)) return;
        if (!(assetImporter is ModelImporter modelImporter)) return;
        modelImporter.isReadable = true;
        modelImporter.importCameras = false;
        modelImporter.importConstraints = false;
        modelImporter.importLights = false;
        modelImporter.importAnimation = false;
        modelImporter.weldVertices = true;
        modelImporter.preserveHierarchy = true;
        modelImporter.optimizeMesh = false;
        modelImporter.optimizeGameObjects = false;
        modelImporter.normalCalculationMode = ModelImporterNormalCalculationMode.AreaAndAngleWeighted;
        modelImporter.importTangents = ModelImporterTangents.Import;
        modelImporter.importBlendShapeNormals = ModelImporterNormals.Import;
        modelImporter.importNormals = ModelImporterNormals.Import;
        modelImporter.animationType = ModelImporterAnimationType.Generic; // to unfuck non-rigged mesh
        // do not generate animations to reduce the burden. also adding animator for clothing is cringe (unless it's specified)
        modelImporter.generateAnimations = ModelImporterGenerateAnimations.None;
    }


    private void OnPostprocessGameObjectWithUserProperties(GameObject go, string[] propNames, object[] values)
    {
        for (var i = 0; i < propNames.Length; i++)
        {
            var key = propNames[i];
            if (!key.StartsWith("!@")) continue;
            var value = values[i] as string;
            switch (key)
            {
                case "!@component":
                    switch (value)
                    {
                        case "HairAccessory":
                            break;

                        case "SkinnedAccessory":
                            break;

                        case "CmpAccessory":
                            break;

                        case "CmpClothes":
                            break;

                        case "CmpHair":
                            break;

                        case "ItemComponent":
                            break;
                    }

                    break;
                case "!@root":
                    go.name = "cf_J_Root";
                    break;
            }
        }


    }

// // TODO: Apply Avatar Filters for every single animations.
// // TODO: Apply Avatar on every single clothings.
// if (assetPath.Contains("@CLOTHES_ASSETS"))
// {
//     var modelImporter = assetImporter as ModelImporter;
//     modelImporter.importAnimation = false;
//     modelImporter.importCameras = false;
//     modelImporter.importConstraints = false;
//     modelImporter.importLights = false;
//     modelImporter.isReadable = true;
//     modelImporter.optimizeMesh = false;
// }

    static private Regex animRegex = new Regex(@"Armature\|", RegexOptions.IgnoreCase | RegexOptions.Compiled);

    public void OnPreprocessAnimation()
    {
        if (assetPath.Contains("hs_anim"))
        {
            if (assetImporter is ModelImporter modelImporter)
            {
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
        }

        // prepare all humanoid animations ready to bake with Animation Converter.
        if (assetPath.Contains("src_"))
        {
            var name = Path.GetFileNameWithoutExtension(assetPath);
            if (!(assetImporter is ModelImporter modelImporter)) return;
            if (modelImporter.animationType != ModelImporterAnimationType.Human) return;
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
