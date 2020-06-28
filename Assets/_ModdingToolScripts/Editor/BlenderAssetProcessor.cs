using UnityEngine;
using UnityEditor;
using System.Collections;
using System.IO;
using System.Linq;
using System.Collections.Generic;


public class BlenderAssetProcessor : AssetPostprocessor
{
    void OnPreprocessAnimation()
    {
        // TODO: Apply Avatar Filters for every single animations.
        // TODO: Apply Avatar on every single clothings.
        // TODO: Make model use rig from fucking shit. \
        if (assetPath.Contains("@CLOTHES_ASSETS"))
        {
            ModelImporter modelImporter = assetImporter as ModelImporter;
            modelImporter.importAnimation = false;
            modelImporter.importCameras = false;
            modelImporter.importConstraints = false;
            modelImporter.importLights = false;
            modelImporter.isReadable = true;
            modelImporter.optimizeMesh = false;
        }
        
        // all hs/sbpr/ph animation conversion should have fucking avatar filters.
        if (assetPath.Contains("hs_anim"))
        {
            ModelImporter modelImporter = assetImporter as ModelImporter;

            modelImporter.animationType = ModelImporterAnimationType.Generic;
            modelImporter.sourceAvatar = Resources.Load<Avatar>("AI_Generic");

            ModelImporterClipAnimation[] defaultAnimations = modelImporter.defaultClipAnimations;
            foreach (ModelImporterClipAnimation animation in defaultAnimations)
            {
                animation.loopTime = true;
                animation.maskType = ClipAnimationMaskType.CopyFromOther;
                animation.maskSource = Resources.Load<AvatarMask>("HS_MaskAvatar");
            }

            modelImporter.clipAnimations = defaultAnimations;
        }
    }
}