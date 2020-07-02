#if UNITY_EDITOR
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using MyBox;
using UnityEditor;
using UnityEngine;

namespace DebugComponents
{
    public class DevPreviewHair : MonoBehaviour, PreviewInterface
    {
        private static readonly string shaderBundleName = "_AIResources\\hair_shader_mat.unity3d";
        private static readonly string[] textureExtentions = {".psd", ".png", ".jpg", ".tga", ".tif"}; // most used extentions.

        private Shader hairShader;
        private Material instanceMaterial;

        public Material hairBundleMaterial;
        public float detailScale = 0.3f;
        public Color previewMainColor = new Color(0.2f, 0.2f, 0.2f);
        public Color previewSpecColor = new Color(0.3f, 0.3f, 0.3f);
        public Color previewTopColor = new Color(0.3f, 0.3f, 0.3f);
        public Color previewUnderColor = new Color(0.564f, 0.564f, 0.564f);
        public Texture2D mapDiffuse;
        public Texture2D mapNormal;
        public Texture2D mapAO;
        public Texture2D mapNoise;
        public Texture2D mapColormask;

        private List<SkinnedMeshRenderer> rendererList;

        private void Start()
        {
        }

        public void LoadAndSetTexture()
        {
            var bundle = AssetBundle.GetAllLoadedAssetBundles().FirstOrDefault(x => x.name.Contains(Path.GetFileName(shaderBundleName)));
            if (bundle == null) bundle = AssetBundle.LoadFromFile(Path.Combine(Directory.GetCurrentDirectory(), shaderBundleName));
                
            foreach (var assetPath in bundle.GetAllAssetNames())
                if (assetPath.Contains("hair_dithering"))
                {
                    hairBundleMaterial = bundle.LoadAsset<Material>(assetPath);
                    break;
                }

            instanceMaterial = new Material(hairBundleMaterial);
            
            if (instanceMaterial)
            {
                instanceMaterial.SetColor("_Color", previewMainColor);
                instanceMaterial.SetColor("_Specular", previewSpecColor);
                instanceMaterial.SetColor("_TopColor", previewTopColor);
                instanceMaterial.SetColor("_UnderColor", previewUnderColor);
                instanceMaterial.SetTexture("_MainTex", mapDiffuse);
                instanceMaterial.SetTexture("_BumpMap", mapNormal);
                instanceMaterial.SetTexture("_Occlusion", mapAO);
                instanceMaterial.SetTexture("_DetailMask", mapNoise);
                instanceMaterial.SetTexture("_ColorMask", mapColormask);
                
                instanceMaterial.SetFloat("_Cutoff", 0.5f);
                instanceMaterial.SetFloat("_DetailScale", detailScale); // 가변
                instanceMaterial.SetFloat("_HighLight", 13.17f); // 가변 
                instanceMaterial.SetFloat("_Rimpower", 6.2f); // 가변
                instanceMaterial.SetFloat("_TopGradation", 4.59f); // 가변
                instanceMaterial.SetFloat("_UnderGradation", 2.62f); // 
                instanceMaterial.SetFloat("_Metalic", 0.0f); // 게임 변수
                instanceMaterial.SetFloat("_ExGloss", 0f); // 게임 변수
                instanceMaterial.SetFloat("_Smoothness", 0.0f); // 게임 변수

                GetComponentsInChildren<Renderer>().ToList().ForEach(x => x.material = instanceMaterial);
            }
            else
            {
                Debug.LogError("Couldn't find hair material assetbundle!");
            }
        }

        public void SetupTextureBasedDirectory()
        {
            // I don't even care 
            // you don't even run this occasionally.
            var path = GetProjectPath();

            var colorTexturePath = AssetDatabase
                .FindAssets("color t:texture2D", new[] {path}).Select(AssetDatabase.GUIDToAssetPath).FirstOrDefault(x => !x.Contains("mask"));
            if (!colorTexturePath.IsNullOrEmpty())
                mapDiffuse = AssetDatabase.LoadAssetAtPath<Texture2D>(colorTexturePath);

            var normalTexturePath = AssetDatabase.FindAssets("normal t:texture2D", new[] {path}).FirstOrDefault();
            if (!normalTexturePath.IsNullOrEmpty())
                mapNormal = AssetDatabase.LoadAssetAtPath<Texture2D>(AssetDatabase.GUIDToAssetPath(normalTexturePath));

            var aoTexturePath = AssetDatabase.FindAssets("t:texture2D", new[] {path})
                .Select(AssetDatabase.GUIDToAssetPath).FirstOrDefault(x => x.ToLower().Contains("ao") || x.ToLower().Contains("occlusion") || x.ToLower().Contains("ambient"));
            if (!aoTexturePath.IsNullOrEmpty())
                mapAO = AssetDatabase.LoadAssetAtPath<Texture2D>(aoTexturePath);

            var detailTexturePath = AssetDatabase.FindAssets("noise t:texture2D", new[] {path}).FirstOrDefault();
            if (!detailTexturePath.IsNullOrEmpty())
                mapNoise = AssetDatabase.LoadAssetAtPath<Texture2D>(AssetDatabase.GUIDToAssetPath(detailTexturePath));

            var colormaskTexturePath = AssetDatabase.FindAssets("colormask t:texture2D", new[] {path}).FirstOrDefault();
            if (!colormaskTexturePath.IsNullOrEmpty())
                mapColormask = AssetDatabase.LoadAssetAtPath<Texture2D>(AssetDatabase.GUIDToAssetPath(colormaskTexturePath));
        }

        public static string GetProjectPath()
        {
            try
            {
                var projectBrowserType = Type.GetType("UnityEditor.ProjectBrowser,UnityEditor");
                var projectBrowser = projectBrowserType.GetField("s_LastInteractedProjectBrowser", BindingFlags.Static | BindingFlags.Public).GetValue(null);
                var invokeMethod = projectBrowserType.GetMethod("GetActiveFolderPath", BindingFlags.NonPublic | BindingFlags.Instance);
                return (string) invokeMethod.Invoke(projectBrowser, new object[] { });
            }
            catch (Exception exception)
            {
                Debug.LogWarning("Error while trying to get current project path.");
                Debug.LogWarning(exception.Message);
                return string.Empty;
            }
        }
    }
}
#endif