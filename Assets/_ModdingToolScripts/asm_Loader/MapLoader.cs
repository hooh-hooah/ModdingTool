#if UNITY_EDITOR

using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.IO;
using System.Linq;
using Ludiq.OdinSerializer.Utilities;
using ModdingTool;
using UnityEditor;
using UnityEngine;
using UnityEngine.SceneManagement;

[SuppressMessage("ReSharper", "IdentifierTypo")]
[SuppressMessage("ReSharper", "StringLiteralTypo")]
public class MapLoader : EditorWindow
{
    private const string BASE_PATH = "D:/AI-Syoujyo/abdata";

    private static readonly Dictionary<string, AssetBundle> LoadedBundles = new Dictionary<string, AssetBundle>();

    private static readonly List<AssetBundleManifest> Dependencies = new List<AssetBundleManifest>();

    public List<string> sceneList = new List<string>();

    private void OnGUI()
    {
        var serializedObject = new SerializedObject(this);
        var nameField = serializedObject.FindProperty("sceneList");
        EditorGUILayout.PropertyField(nameField, new GUIContent("nameList"), true);
        serializedObject.ApplyModifiedProperties();

        if (GUILayout.Button("load map please"))
        {
            var isFirst = true;
            foreach (var scenePath in sceneList.Select(x => $"{x}.unity3d").Select(internalBundleName =>
            {
                foreach (var file in Directory.GetFiles(BASE_PATH))
                    if (GetAssetBundleDepencency(GetPath(file), out var manifestBundle))
                        Dependencies.Add(manifestBundle);

                var depBundles = GetDependencies(internalBundleName);
                foreach (var depBundle in depBundles)
                    GetBundle(GetPath(depBundle));

                var bundle = GetBundle(GetPath(internalBundleName));
                var scene = bundle.GetAllScenePaths().FirstOrDefault();
                return scene;
            }).Where(x => !string.IsNullOrEmpty(x)))
            {
                SceneManager.LoadScene(scenePath, isFirst ? LoadSceneMode.Single : LoadSceneMode.Additive);
                isFirst = false;
            }

            foreach (var component in FindObjectsOfType<Component>().Where(x => !(x is Transform))) Debug.LogWarning(component);
        }

        if (GUILayout.Button("load thing please"))
        {
            AssetBundle.UnloadAllAssetBundles(true);
            foreach (var gameObject in sceneList.Select(x => $"{x}.unity3d").SelectMany(internalBundleName =>
            {
                foreach (var file in Directory.GetFiles(BASE_PATH))
                    if (GetAssetBundleDepencency(GetPath(file), out var manifestBundle))
                        Dependencies.Add(manifestBundle);

                var depBundles = GetDependencies(internalBundleName);
                foreach (var depBundle in depBundles)
                    GetBundle(GetPath(depBundle));

                var bundle = GetBundle(GetPath(internalBundleName));
                var gameObjects = bundle.LoadAllAssets<GameObject>();
                return gameObjects;
            }))
            {
                Instantiate(gameObject);
            }
        }
    }

    // Show control window - WiP
    [MenuItem("Developers/Remove Bakery Transform")]
    public static void RemoveBakeryPlease()
    {
        LightmapSettings.lightmaps = null;
        var lightMap = new []
            {
                FindObjectsOfType<ftLightmapsStorage>(),
            }
            .SelectMany(x => x)
            .Select(x => x.gameObject)
            .ToList();

        Debug.Log($"Found {lightMap?.Count ?? 0} Lightmap Containers");
        foreach (var transform in lightMap)
        {
            Debug.LogWarning("Destroyed Bakery Lightmap Containers");
            DestroyImmediate(transform.gameObject);
        }
    }

    // Show control window - WiP
    [MenuItem("Developers/Move Bakerylightmap")]
    public static void RemoveBakery()
    {
        var mapRoot = GameObject.Find("Map");
        var lightMap = GameObject.Find("!ftraceLightmaps");

        lightMap.transform.parent = mapRoot.transform;
    }

    [MenuItem("Developers/Toggle Bakery Light")]
    public static void Toggalight()
    {
        var lightMap = GameObject.Find("Map/!ftraceLightmaps");
        lightMap.SetActive(!lightMap.activeSelf);
    }

    // Show control window - WiP
    [MenuItem("Developers/Load Map Loader")]
    public static void ShowWindow()
    {
        GetWindow<MapLoader>(false, "WIP Map Loader", true);
    }

    private static AssetBundle GetBundle(string path)
    {
        if (LoadedBundles.TryGetValue(path, out var cache)) return cache;

        var bundle = AssetBundleManager.GetBundle(path);
        LoadedBundles.Add(path, bundle);
        return bundle;
    }

    private static bool GetAssetBundleDepencency(string path, out AssetBundleManifest result)
    {
        var bundle = GetBundle(path);
        var manifest = bundle.LoadAsset<AssetBundleManifest>("AssetBundleManifest");
        result = manifest;
        return !ReferenceEquals(null, manifest);
    }

    private static IEnumerable<string> GetDependencies(string path)
    {
        return Dependencies
            .Select(dependency => dependency.GetAllDependencies(path))
            .Where(dependency => dependency.Length > 0)
            .SelectMany(x => x)
            .ToArray();
    }

    private static string GetPath(string path)
    {
        return Path.Combine(BASE_PATH, path).Replace("\\", "/");
    }
}
#endif