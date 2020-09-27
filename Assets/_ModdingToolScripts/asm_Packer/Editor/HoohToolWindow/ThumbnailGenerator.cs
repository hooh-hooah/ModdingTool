using System;
using System.Drawing;
using System.IO;
using System.Linq;
using ModPackerModule.Utility;
using nQuant;
using UnityEditor;
using UnityEngine;
using UnityEngine.Serialization;
using Color = UnityEngine.Color;

#if UNITY_EDITOR
public partial class HoohTools
{
    public bool foldThumbnailGenerator = true;

    [FormerlySerializedAs("PreviewDirection")]
    public Vector3 previewDirection;

    public Texture2D thumbnailBackgroundTexture;
    public Texture2D thumbnailForegroundTexture;
    public GameObject[] thumbnailTargets;


    // TODO: Make automatic studio item thumbnail generator with compression methods
    // Use pngquant to compress png image or something 

    private void SetupThumbnailGenerator()
    {
        RuntimePreviewGenerator.MarkTextureNonReadable = false;
        RuntimePreviewGenerator.BackgroundColor = new Color(0, 0, 0, 0);
        RuntimePreviewGenerator.Padding = 0f;
        RuntimePreviewGenerator.OrthographicMode = true;
        RuntimePreviewGenerator.PreviewDirection = previewDirection;
    }

    private void GenerateTexture(GameObject thumbnailTarget, string outputPath, bool compress)
    {
        var texture = RuntimePreviewGenerator.GenerateModelPreview(thumbnailTarget.transform, 128, 128, true);

        if (thumbnailBackgroundTexture)
        {
            var texturePixels = texture.GetPixels();
            var backgroundPixels = thumbnailBackgroundTexture.GetPixels();
            for (var i = 0; i < texturePixels.Length; i++) texturePixels[i] = Color.Lerp(backgroundPixels[i], texturePixels[i], texturePixels[i].a);
            texture.SetPixels(texturePixels);
        }

        if (thumbnailForegroundTexture)
        {
            var texturePixels = texture.GetPixels();
            var foregroundPixels = thumbnailForegroundTexture.GetPixels();
            for (var i = 0; i < texturePixels.Length; i++) texturePixels[i] = Color.Lerp(texturePixels[i], foregroundPixels[i], foregroundPixels[i].a);
            texture.SetPixels(texturePixels);
        }

        if (compress)
        {
            var quantize = new WuQuantizer();
            var bitmap = new Bitmap(128, 128);
            var index = 0;
            foreach (var pixel in texture.GetPixels())
            {
                var x = index % 128;
                var y = 127 - index / 128;
                bitmap.SetPixel(x, y, System.Drawing.Color.FromArgb(
                    Mathf.CeilToInt(Mathf.Clamp(pixel.a * 255, 0, 255)),
                    Mathf.CeilToInt(Mathf.Clamp(pixel.r * 255, 0, 255)),
                    Mathf.CeilToInt(Mathf.Clamp(pixel.g * 255, 0, 255)),
                    Mathf.CeilToInt(Mathf.Clamp(pixel.b * 255, 0, 255))
                ));
                index++;
            }

            var image = quantize.QuantizeImage(bitmap);
            image.Save(outputPath);
        }
        else
        {
            File.WriteAllBytes(outputPath, texture.EncodeToPNG());
        }
    }

    private void GenerateThumbnail()
    {
        var assetPath = Path.Combine(Directory.GetCurrentDirectory(), PathUtils.GetProjectPath());
        var thumbnailTargetPath = Path.Combine(assetPath, "thumbs");
        if (!Directory.Exists(thumbnailTargetPath)) Directory.CreateDirectory(thumbnailTargetPath);

        SetupThumbnailGenerator();
        var index = 0;
        var total = thumbnailTargets.Length;

        try
        {
            EditorUtility.DisplayProgressBar("Generating", "Generating the image...", 0);
            foreach (var thumbnailTarget in thumbnailTargets)
            {
                var outputPath = Path.Combine(thumbnailTargetPath, $"thumb_{thumbnailTarget.name.ToLower().Replace(" ", "_")}.png");
                GenerateTexture(thumbnailTarget, outputPath, false);
                EditorUtility.DisplayProgressBar("Generating", "Generating the image...", ++index / (float) total);
            }
            EditorApplication.Beep();
        }
        catch (Exception e)
        {
            Console.WriteLine(e);
            throw;
        }
        finally
        {
            EditorUtility.ClearProgressBar();
        }

        AssetDatabase.Refresh();
    }

    private void GenerateStudioThumbnail()
    {
        var assetPath = Path.Combine(Directory.GetCurrentDirectory(), PathUtils.GetProjectPath());
        var thumbnailTargetPath = Path.Combine(assetPath, "thumbs");
        if (!Directory.Exists(thumbnailTargetPath)) Directory.CreateDirectory(thumbnailTargetPath);

        SetupThumbnailGenerator();
        var index = 0;
        var total = thumbnailTargets.Length;

        try
        {
            EditorUtility.DisplayProgressBar("Generating", "Generating and Compressing the image...", 0);
            foreach (var pairs in PathUtils.GetAllNearestModData(thumbnailTargets))
            {
                var thumbnailTarget = pairs.Key;
                var thumbnailModObject = pairs.Value;
                if (thumbnailModObject == null) continue;
                if (!thumbnailModObject.StudioInfo.TryGetInfo(thumbnailTarget, out var itemInfo)) continue;
                var outputPath = Path.Combine(thumbnailTargetPath, $"{itemInfo.BigCategory:D8}-{itemInfo.MidCategory:D8}-{itemInfo.Name.SanitizeBadPath()}.png");
                GenerateTexture(thumbnailTarget, outputPath, true);
                EditorUtility.DisplayProgressBar("Generating", "Generating and Compressing the image...", ++index / (float) total);
            }
            EditorApplication.Beep();
        }
        catch (Exception e)
        {
            Debug.LogError(e);
            throw;
        }
        finally
        {
            EditorUtility.ClearProgressBar();
        }

        AssetDatabase.Refresh();
    }

    private static GameObject[] GetAllModelObjects()
    {
        return AssetDatabase.FindAssets("t:Prefab", new[] {PathUtils.GetProjectPath()})
            .Select(x => AssetDatabase.LoadAssetAtPath<GameObject>(AssetDatabase.GUIDToAssetPath(x)))
            .ToArray();
    }

    private void DrawThumbnailUtility(SerializedObject serializedObject)
    {
        var backgroundField = serializedObject.FindProperty("thumbnailBackgroundTexture");
        var foregroundField = serializedObject.FindProperty("thumbnailForegroundTexture");
        var targetsField = serializedObject.FindProperty("thumbnailTargets");
        var directionField = serializedObject.FindProperty("previewDirection");
        var thumbnailGeneratorField = serializedObject.FindProperty("foldThumbnailGenerator");

        thumbnailGeneratorField.boolValue = EditorGUILayout.Foldout(foldThumbnailGenerator, "Thumbnail Generator", true, _styles.Foldout);
        if (!foldThumbnailGenerator) return;

        GUILayout.BeginVertical("box");
        GUILayout.Label("Thumbnail Generator", _styles.Header);

        GUILayout.BeginHorizontal();
        EditorGUILayout.PropertyField(backgroundField, new GUIContent("Background Image"));
        EditorGUILayout.PropertyField(foregroundField, new GUIContent("Foreground Image"));
        GUILayout.EndHorizontal();

        EditorGUILayout.PropertyField(directionField, new GUIContent("Preview Direction"));
        EditorGUILayout.PropertyField(targetsField, new GUIContent("Target Models"), true);

        GUILayout.BeginHorizontal();
        if (GUILayout.Button("Add Folder", _styles.Button))
            SetEvent(() => { thumbnailTargets = GetAllModelObjects(); });
        if (GUILayout.Button("Generate Thumbnails", _styles.Button))
            SetEvent(GenerateThumbnail);
        if (GUILayout.Button("Generate Studio Thumbnails", _styles.Button))
            SetEvent(GenerateStudioThumbnail);
        GUILayout.EndHorizontal();
        GUILayout.EndVertical();
    }
}
#endif