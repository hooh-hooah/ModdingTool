#pragma warning disable 618
using System.IO;
using System.Linq;
using ModPackerModule.Utility;
using UnityEditor;
using UnityEngine;
using static UnityEditor.ReplacePrefabOptions;

#pragma warning restore 618

#if UNITY_EDITOR
public partial class HoohTools
{
    private static readonly int BumpMap = Shader.PropertyToID("_BumpMap");
    private static readonly int MainTex = Shader.PropertyToID("_MainTex");

    private void DrawUnityUtility(SerializedObject serializedObject)
    {
        foldoutMacros = EditorGUILayout.Foldout(foldoutMacros, "Quick Unity Macros", true, Style.Foldout);
        if (!foldoutMacros) return;

        // Starts a horizontal group
        GUILayout.BeginHorizontal("box");
        GUILayout.BeginVertical();
        Gap = EditorGUILayout.IntField("Showcase Gap: ", Gap);
        Cols = EditorGUILayout.IntField("Showcase Columns: ", Cols);
        GUILayout.EndVertical();
        if (GUILayout.Button("Showcase Mode", Style.Button))
            if (CheckGoodSelection())
                _guiEventAction = ShowcaseMode;
        GUILayout.EndHorizontal();

        GUILayout.Space(5);
        GUILayout.BeginVertical("box");
        GUILayout.Label("Easy Macros", Style.Header);
        if (GUILayout.Button("Wrap Object with new GameObject and Scale", Style.Button))
            if (CheckGoodSelection())
                _guiEventAction = WrapObjectScale;
        if (GUILayout.Button("Wrap Object with new GameObject", Style.Button))
            if (CheckGoodSelection())
                _guiEventAction = WrapObject;
        if (GUILayout.Button("Create Prefab from Selected Objects", Style.Button))
            if (CheckGoodSelection())
                _guiEventAction = CreatePrefab;
        GUILayout.EndVertical();


        GUILayout.Space(5);
        GUILayout.BeginVertical("box");
        LightScaleSize = EditorGUILayout.FloatField("Light Scale Size: ", LightScaleSize);

        GUILayout.BeginHorizontal();
        if (GUILayout.Button("Scale Lights and Probes", Style.Button))
            if (CheckGoodSelection())
                _guiEventAction = ScaleLightsAndProbes;
        if (GUILayout.Button("Reset Lightmap Scale", Style.Button))
            _guiEventAction = () =>
            {
                var meshes = Resources.FindObjectsOfTypeAll<MeshRenderer>();
                foreach (var mesh in meshes)
                {
                    var so = new SerializedObject(mesh);
                    so.FindProperty("m_ScaleInLightmap").floatValue = 1;
                    so.ApplyModifiedProperties();
                }
            };

        GUILayout.EndHorizontal();
        GUILayout.EndVertical();

        GUILayout.Space(5);
        GUILayout.BeginHorizontal("box");
        targetObject = (GameObject) EditorGUILayout.ObjectField("Target Object", targetObject, typeof(GameObject), true);
        if (GUILayout.Button("Move Selected to Clutter", Style.Button))
            _guiEventAction = () =>
            {
                if (!CheckGoodSelection()) return;
                var clutter = targetObject != null ? targetObject : GameObject.Find("Clutters") ?? new GameObject("Clutters");

                foreach (var select in Selection.objects)
                {
                    var currentObject = (GameObject) select;
                    currentObject.transform.parent = clutter.transform;
                }
            };

        GUILayout.EndHorizontal();

        GUILayout.Space(5);
        GUILayout.BeginVertical("box");
        GUILayout.Label("Multi-Rename", Style.Header);
        PrepostString = EditorGUILayout.TextField("Pre/Postfix Text", PrepostString);
        GUILayout.BeginHorizontal();
        if (GUILayout.Button("Add to Front", Style.Button) && CheckGoodSelection())
            _guiEventAction = () => { UnityMacros.AddPrefixOnName(PrepostString); };
        if (GUILayout.Button("Add to End", Style.Button) && CheckGoodSelection())
            _guiEventAction = () => { UnityMacros.AddPostfixOnName(PrepostString); };
        if (GUILayout.Button("Remove", Style.Button) && CheckGoodSelection())
            _guiEventAction = () => { UnityMacros.ReplaceTextOfName(PrepostString, ""); };
        if (GUILayout.Button("SetTo", Style.Button) && CheckGoodSelection())
            _guiEventAction = () => { UnityMacros.SetName(PrepostString); };
        if (GUILayout.Button("Sequence", Style.Button) && CheckGoodSelection())
            _guiEventAction = () => { UnityMacros.SetNameSequence(PrepostString); };
        GUILayout.EndHorizontal();
        GUILayout.EndVertical();


        GUILayout.Space(5);
        GUILayout.BeginVertical("box");

        if (GUILayout.Button("Auto-Generate Materials", Style.Button))
            _guiEventAction = () =>
            {
                var targetPath = PathUtils.GetProjectPath();
                var basePath = Path.Combine(Directory.GetCurrentDirectory(), targetPath);
                var filesWithRegex = PathUtils.GetFilesWithRegex(basePath, @"\.(jpg|png|tif|tga)");
                var normalizedFiles = filesWithRegex.ToDictionary(Path.GetFileNameWithoutExtension, x => x);
                foreach (var file in filesWithRegex.Where(x => Path.GetFileName(x).StartsWith("ALB_")))
                {
                    var name = Path.GetFileNameWithoutExtension(file);
                    var matPath = Path.Combine(basePath, $"{name}.mat");
                    if (File.Exists(matPath)) File.Delete(matPath);
                    var material = new Material(Shader.Find("Standard")) {color = Color.white};
                    var diffuseTexture = AssetDatabase.LoadAssetAtPath<Texture2D>(Path.Combine(targetPath, Path.GetFileName(file)));
                    material.SetTexture(MainTex, diffuseTexture);
                    if (normalizedFiles.TryGetValue(name.Replace("ALB_", "NRM_"), out var normalPath))
                    {
                        var normalMapTexture = AssetDatabase.LoadAssetAtPath<Texture2D>(Path.Combine(targetPath, Path.GetFileName(normalPath)));
                        material.SetTexture(BumpMap, normalMapTexture);
                    }

                    AssetDatabase.CreateAsset(material, Path.Combine(targetPath, $"{name}.mat").ToUnixPath());
                }
            };

        GUILayout.EndVertical();
    }

    private static void ShowcaseMode()
    {
        for (var i = 0; i < Selection.objects.Length; i++)
        {
            var currentObject = (GameObject) Selection.objects[i];
            var curRow = (int) Mathf.Floor(i / (float) Cols);
            var curCol = i % Cols;

            if (currentObject != null)
                currentObject.transform.position = new Vector3(
                    curCol * Gap,
                    0,
                    curRow * Gap
                );
        }
    }

    // Pretty useful to make stuffs X time larger.
    [MenuItem("hooh Tools/Wrap Object with Gameobject", false)]
    public static void WrapObject()
    {
        foreach (var currentObject in Selection.objects.Cast<GameObject>())
        {
            var parent = currentObject.transform.parent;
            if (currentObject == null) continue;

            var wrapObject = new GameObject(currentObject.name);
            wrapObject.transform.SetParent(parent, false);
            currentObject.transform.SetParent(wrapObject.transform);
        }
    }

    [MenuItem("hooh Tools/Wrap Object with Gameobject and Scale", false)]
    public static void WrapObjectScale()
    {
        foreach (var currentObject in Selection.objects.Cast<GameObject>())
        {
            var parent = currentObject.transform.parent;
            if (currentObject == null) continue;

            currentObject.transform.localScale = new Vector3(9, 9, 9);
            var wrapObject = new GameObject(currentObject.name);
            wrapObject.transform.parent = parent;
            currentObject.transform.SetParent(wrapObject.transform);
            wrapObject.transform.position = Vector3.zero;
        }
    }

    // Mass Register Prefabs. I'm sick and tired of dragging here and there for 10 minutes.
    [MenuItem("hooh Tools/Create Prefab")]
    public static void CreatePrefab()
    {
        var objectArray = Selection.gameObjects;

        foreach (var gameObject in objectArray)
        {
            var localPath = Path.Combine(PathUtils.GetProjectPath(), gameObject.name + ".prefab").Replace("\\", "/");
            Debug.Log(localPath);
            if (AssetDatabase.LoadAssetAtPath(localPath, typeof(GameObject)))
            {
                CreateNew(gameObject, localPath);
            }
            else
            {
                Debug.Log(gameObject.name + " is not a prefab, will convert");
                CreateNew(gameObject, localPath);
            }
        }
    }

    [MenuItem("hooh Tools/Create Prefab", true)]
    private static bool ValidateCreatePrefab()
    {
        return Selection.activeGameObject != null;
    }

    private static void CreateNew(GameObject obj, string localPath)
    {
        //Create a new prefab at the path given
        Object prefab = PrefabUtility.SaveAsPrefabAsset(obj, localPath);

        // Fuck you unity you removed this without replacement API?
        // https://forum.unity.com/threads/how-to-generate-prefabs-w-scripts-w-the-new-system.613747/#post-4113010:w

#pragma warning disable 618
        PrefabUtility.ReplacePrefab(obj, prefab, ConnectToPrefab);
#pragma warning restore 618
    }
}
#endif