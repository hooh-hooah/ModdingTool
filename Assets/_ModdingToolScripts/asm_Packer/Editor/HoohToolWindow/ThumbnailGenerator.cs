using System.Collections.Generic;
using System.IO;
using System.Linq;
using UnityEditor;
using UnityEngine;
using UnityEngine.Serialization;

#if UNITY_EDITOR
public partial class HoohTools
{
    public bool foldThumbnailGenerator = true;
    public Texture2D thumbnailBackgroundTexture;
    public Texture2D thumbnailForegroundTexture;
    public GameObject[] thumbnailTargets;
    [FormerlySerializedAs("PreviewDirection")] public Vector3 previewDirection;

    public void GenerateThumbnail()
    {
        var assetPath = Path.Combine(Directory.GetCurrentDirectory(), ModPacker.GetProjectPath());
        var thumbnailTargetPath = Path.Combine(assetPath, "thumbs");
        if (!Directory.Exists(thumbnailTargetPath)) Directory.CreateDirectory(thumbnailTargetPath);
        
        RuntimePreviewGenerator.MarkTextureNonReadable = false;
        RuntimePreviewGenerator.BackgroundColor = new Color(0, 0, 0, 0);
        RuntimePreviewGenerator.Padding = 0f;
        RuntimePreviewGenerator.OrthographicMode = true;
        RuntimePreviewGenerator.PreviewDirection = previewDirection;

        foreach (var thumbnailTarget in thumbnailTargets)
        {
            var outputPath = Path.Combine(thumbnailTargetPath, $"thumb_{thumbnailTarget.name.ToLower().Replace(" ", "_")}.png");
            var texture = RuntimePreviewGenerator.GenerateModelPreview(thumbnailTarget.transform, 128, 128);

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


            var _bytes = texture.EncodeToPNG();
            File.WriteAllBytes(outputPath, _bytes);
        }
        AssetDatabase.Refresh();
    }

    private GameObject[] GetAllModelObjects()
    {
        return AssetDatabase.FindAssets("t:Prefab", new[] {ModPacker.GetProjectPath()})
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
        if (foldThumbnailGenerator)
        {
            GUILayout.BeginVertical("box");
                GUILayout.Label("Thumbnail Generator", _styles.Header);
                        
                GUILayout.BeginHorizontal();
                    EditorGUILayout.PropertyField(backgroundField, new GUIContent("Background Image"));
                    EditorGUILayout.PropertyField(foregroundField, new GUIContent("Foreground Image"));
                GUILayout.EndHorizontal();
                
                EditorGUILayout.PropertyField(directionField, new GUIContent("Preview Direction"));
                EditorGUILayout.PropertyField(targetsField, new GUIContent("Target Models"), true);

                GUILayout.BeginHorizontal();
                    if (GUILayout.Button("Add Folder", _styles.Button)) thumbnailTargets = GetAllModelObjects();
                    if (GUILayout.Button("Generate Thumbnails", _styles.Button)) GenerateThumbnail();
                GUILayout.EndHorizontal();
            GUILayout.EndVertical();
        }
    }
}
#endif