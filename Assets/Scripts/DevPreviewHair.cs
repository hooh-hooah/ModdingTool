using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEngine;

public class DevPreviewHair : MonoBehaviour {

    List<SkinnedMeshRenderer> rendererList;
    public static Material loadedBundleMaterial;
    Shader hairShader;

    readonly static string shaderBundleName = "_AIResources\\hair_shader_mat.unity3d";
    readonly static Dictionary<string, string> textureAssign = new Dictionary<string, string>() {
        { "_MainTex", "diffuse" },
        { "_BumpMap", "normal" },
        { "_Occlusion", "ao" },
        { "_DetailMask", "noise" },
        { "_ColorMask", "colormask" }
    };
    readonly static string[] textureExtentions = { ".psd", ".png", ".jpg", ".tga", ".tif" }; // most used extentions.
 
    [Header("Specify where mesh's hair at.")]
    [Header("The folder should contain 5 textures.")]
    [Header("The script will automatically assign following textures in this name convention")]
    [Header("(diffuse, normal, colormask, ao, noise)")]
    public string hairTexturePath;
    public float detailScale = 0.3f;
    Material instanceMaterial;

    public Color previewMainColor = new Color(0.2f, 0.2f, 0.2f);
    public Color previewSpecColor = new Color(0.3f, 0.3f, 0.3f);
    public Color previewTopColor = new Color(0.3f, 0.3f, 0.3f);
    public Color previewUnderColor = new Color(0.564f, 0.564f, 0.564f);

    Dictionary<string, float> TextureShits;
    
    // Use this for initialization
    void Start () {
        #if UNITY_EDITOR
        try {
            AssetBundle bundle = AssetBundle.LoadFromFile(Path.Combine(Directory.GetCurrentDirectory(), shaderBundleName));
            foreach (var assetPath in bundle.GetAllAssetNames()) {
                if (assetPath.Contains("hair_dithering")) {
                    loadedBundleMaterial = bundle.LoadAsset<Material>(assetPath);
                    break;
                }
            }

            instanceMaterial = new Material(loadedBundleMaterial);
            if (instanceMaterial) {
                SkinnedMeshRenderer[] renderers = GetComponentsInChildren<SkinnedMeshRenderer>();

                // Initial Value Settings

                instanceMaterial.SetColor("_Color", previewMainColor);
                instanceMaterial.SetColor("_Specular", previewSpecColor);
                instanceMaterial.SetColor("_TopColor", previewTopColor);
                instanceMaterial.SetColor("_UnderColor", previewUnderColor);

                instanceMaterial.SetFloat("_Cutoff", 0.5f);
                instanceMaterial.SetFloat("_DetailScale", detailScale); // 가변
                instanceMaterial.SetFloat("_HighLight", 13.17f); // 가변 
                instanceMaterial.SetFloat("_Rimpower", 6.2f); // 가변
                instanceMaterial.SetFloat("_TopGradation", 4.59f); // 가변
                instanceMaterial.SetFloat("_UnderGradation", 2.62f); // 
                instanceMaterial.SetFloat("_Metalic", 0.0f); // 게임 변수
                instanceMaterial.SetFloat("_ExGloss", 0f); // 게임 변수
                instanceMaterial.SetFloat("_Smoothness", 0.0f); // 게임 변수

                string texturesPath = Path.Combine("Assets/", hairTexturePath);
                foreach (KeyValuePair<string, string> kv in textureAssign) {
                    foreach (var ext in textureExtentions) {
                        Texture2D texture = (Texture2D)UnityEditor.AssetDatabase.LoadAssetAtPath(
                            Path.Combine(texturesPath, kv.Value + ext), typeof(Texture2D)
                        );
                        if (texture) {
                            instanceMaterial.SetTexture(kv.Key, texture);
                            break;
                        }
                    }
                }

                foreach (var renderer in renderers) {
                    renderer.material = instanceMaterial;
                }
            } else {
                Debug.LogError("Couldn't find hair material assetbundle!");
            }
        } catch (Exception e) {
            Debug.LogWarning(e.Message);
        }
        #endif
    }
	
	// Update is called once per frame
	void Update () {
    }
}
