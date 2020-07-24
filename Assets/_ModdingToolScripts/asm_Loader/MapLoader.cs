using System.IO;
using System.Linq;
using UnityEditor;
using UnityEngine;
using UnityEngine.SceneManagement;

public class MapLoader : EditorWindow
{
    public DefaultAsset bundleA;
    public DefaultAsset bundleB;
    public DefaultAsset bundleC;
    public string name;

    // Show control window - WiP
    [MenuItem("powerfucker/fuckshit")]
    public static void Fuckshit()
    {
        var mapRoot = GameObject.Find("Map");
        var LightMap = GameObject.Find("!ftraceLightmaps");

        LightMap.transform.parent = mapRoot.transform;
    }
    [MenuItem("powerfucker/toggalight")]
    public static void toggalight()
    {
        var LightMap = GameObject.Find("!ftraceLightmaps");
        LightMap.SetActive(!LightMap.activeSelf);
    }
    
    // Show control window - WiP
    [MenuItem("powerfucker/loadhist")]
    public static void ShowWindow()
    {
        GetWindow<MapLoader>(false, "hooh Tools", true);
    }

    private void OnGUI()
    {
        var serializedObject = new SerializedObject(this);
        var bundleAField = serializedObject.FindProperty("bundleA");
        var bundleBField = serializedObject.FindProperty("bundleB");
        var bundleCField = serializedObject.FindProperty("bundleC");
        var nameField = serializedObject.FindProperty("name");


        EditorGUILayout.PropertyField(bundleAField, new GUIContent("bundleAField"));
        EditorGUILayout.PropertyField(bundleBField, new GUIContent("bundleBField"));
        EditorGUILayout.PropertyField(bundleCField, new GUIContent("bundleCField"));
        EditorGUILayout.PropertyField(nameField, new GUIContent("name"));


        if (GUILayout.Button("fuckyou"))
        {
            var targetPath = $"D:\\suqa\\abdata\\studio\\map\\{name}.unity3d".Replace("\\", "/");
            var bundle = Resources.FindObjectsOfTypeAll<AssetBundle>()
                .Concat(AssetBundle.GetAllLoadedAssetBundles())
                .FirstOrDefault(x => x.name.Contains(Path.GetFileName(targetPath)));
            ;
            if (bundle == null) bundle = AssetBundle.LoadFromFile(targetPath);
            if (bundle.isStreamedSceneAssetBundle)
            {
                // well it usually has one map so
                var path = bundle.GetAllScenePaths().First();
                SceneManager.LoadScene(path, LoadSceneMode.Single);
            }
            else
            {
                
            }
        }

        serializedObject.ApplyModifiedProperties();
    }
}