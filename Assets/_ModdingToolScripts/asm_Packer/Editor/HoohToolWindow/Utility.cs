using System.IO;
using UnityEditor;
using UnityEngine;

#if UNITY_EDITOR
public partial class HoohTools
{
    public void DrawUnityUtility(SerializedObject serializedObject)
    {
        foldoutMacros = EditorGUILayout.Foldout(foldoutMacros, "Quick Unity Macros", true, _styles.Foldout);
        if (foldoutMacros)
        {
            // Starts a horizontal group
            GUILayout.BeginHorizontal("box");
            GUILayout.BeginVertical();
            Gap = EditorGUILayout.IntField("Showcase Gap: ", Gap);
            Cols = EditorGUILayout.IntField("Showcase Columns: ", Cols);
            GUILayout.EndVertical();
            if (GUILayout.Button("Showcase Mode", _styles.Button))
                if (CheckGoodSelection())
                    ShowcaseMode();
            GUILayout.EndHorizontal();

            GUILayout.Space(5);
            GUILayout.BeginVertical("box");
            if (GUILayout.Button("Wrap Object with new GameObject and Scale", _styles.Button))
                if (CheckGoodSelection())
                    WrapObjectScale();
            if (GUILayout.Button("Wrap Object with new GameObject", _styles.Button))
                if (CheckGoodSelection())
                    WrapObject();
            if (GUILayout.Button("Create Prefab from Selected Objects", _styles.Button))
                if (CheckGoodSelection())
                    CreatePrefab();
            GUILayout.EndVertical();


            GUILayout.Space(5);
            GUILayout.BeginVertical("box");
            LightScaleSize = EditorGUILayout.FloatField("Light Scale Size: ", LightScaleSize);

            GUILayout.BeginHorizontal();
            if (GUILayout.Button("Scale Lights and Probes", _styles.Button))
                if (CheckGoodSelection())
                    ScaleLightsAndProbes();
            if (GUILayout.Button("Reset Lightmap Scale", _styles.Button))
            {
                var meshes = Resources.FindObjectsOfTypeAll<MeshRenderer>();
                foreach (var mesh in meshes)
                {
                    var so = new SerializedObject(mesh);
                    so.FindProperty("m_ScaleInLightmap").floatValue = 1;
                    so.ApplyModifiedProperties();
                }
            }

            GUILayout.EndHorizontal();
            GUILayout.EndVertical();

            GUILayout.Space(5);
            GUILayout.BeginHorizontal("box");
            fuckyouCunt = (GameObject) EditorGUILayout.ObjectField("Target Object", fuckyouCunt, typeof(GameObject), true);
            if (GUILayout.Button("Move Selected to Clutter", _styles.Button))
                if (CheckGoodSelection())
                {
                    var clutter = fuckyouCunt ?? GameObject.Find("Clutters") ?? new GameObject("Clutters");

                    foreach (var select in Selection.objects)
                    {
                        var currentObject = (GameObject) select;
                        currentObject.transform.parent = clutter.transform;
                    }
                }

            GUILayout.EndHorizontal();

            GUILayout.Space(5);
            GUILayout.BeginVertical("box");
            PrepostString = EditorGUILayout.TextField("Pre/Postfix Text", PrepostString);
            GUILayout.BeginHorizontal();
            if (GUILayout.Button("Add to Front", _styles.Button) && CheckGoodSelection())
                UnityMacros.AddPrefixOnName(PrepostString);
            if (GUILayout.Button("Add to End", _styles.Button) && CheckGoodSelection())
                UnityMacros.AddPostfixOnName(PrepostString);
            if (GUILayout.Button("Remove", _styles.Button) && CheckGoodSelection())
                UnityMacros.ReplaceTextOfName(PrepostString, "");
            if (GUILayout.Button("SetTo", _styles.Button) && CheckGoodSelection())
                UnityMacros.SetName(PrepostString);
            if (GUILayout.Button("Sequence", _styles.Button) && CheckGoodSelection())
                UnityMacros.SetNameSequence(PrepostString);
            GUILayout.EndHorizontal();
            GUILayout.EndVertical();
        }
    }

    public static void ShowcaseMode()
    {
        for (var i = 0; i < Selection.objects.Length; i++)
        {
            var currentObject = (GameObject) Selection.objects[i];
            var curRow = (int) Mathf.Floor(i / Cols);
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
        for (var i = 0; i < Selection.objects.Length; i++)
        {
            var currentObject = (GameObject) Selection.objects[i];
            var parent = currentObject.transform.parent;
            if (currentObject != null)
            {
                var wrapObject = new GameObject(currentObject.name);
                wrapObject.transform.SetParent(parent, false);
                currentObject.transform.SetParent(wrapObject.transform);
            }
        }
    }

    [MenuItem("hooh Tools/Wrap Object with Gameobject and Scale", false)]
    public static void WrapObjectScale()
    {
        for (var i = 0; i < Selection.objects.Length; i++)
        {
            var currentObject = (GameObject) Selection.objects[i];
            var parent = currentObject.transform.parent;
            if (currentObject != null)
            {
                currentObject.transform.localScale = new Vector3(9, 9, 9);
                var wrapObject = new GameObject(currentObject.name);
                wrapObject.transform.parent = parent;
                currentObject.transform.SetParent(wrapObject.transform);
                wrapObject.transform.position = Vector3.zero;
            }
        }
    }

    // Mass Register Prefabs. I'm sick and tired of dragging shit here and there for 10 minutes.
    [MenuItem("hooh Tools/Create Prefab")]
    public static void CreatePrefab()
    {
        var objectArray = Selection.gameObjects;

        foreach (var gameObject in objectArray)
        {
            var localPath = Path.Combine(ModPacker.GetProjectPath(), gameObject.name + ".prefab").Replace("\\", "/");
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
        Object prefab = PrefabUtility.CreatePrefab(localPath, obj);
        PrefabUtility.ReplacePrefab(obj, prefab, ReplacePrefabOptions.ConnectToPrefab);
    }
}
#endif