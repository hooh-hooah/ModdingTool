using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Xml.Linq;
using UnityEditor;
using UnityEngine;
using Object = UnityEngine.Object;
using Random = UnityEngine.Random;

public class HoohTools : EditorWindow {
    // TODO: Make these moddable with windows.
    public static int category = 0;

    private GUIStyle foldoutStyle;
    private GUIStyle titleStyle;
    private float sliderValue;
    private float inputNumber;
    private float maxSliderValue = 5.0f;
    private float minSliderValue = 1.0f;

    public static string sideloaderString = "";
    public static int categorySmall = 0;
    public static float lightScaleSize = 9f;
    public static string gameExportPath = "";
    public static int gap = 10;
    public static int cols = 10;

    bool foldoutElement = true;
    bool foldoutMacros = true;
    bool foldoutProbeset = true;
    bool foldoutScaffolding = true;
    bool foldoutMod = true;
    bool foldoutBundler = true;

    public void OnEnable() {
        foldoutElement = EditorPrefs.GetBool("hoohTool_foldoutElement", true);
        foldoutMacros = EditorPrefs.GetBool("hoohTool_foldoutMacros", true);
        foldoutProbeset = EditorPrefs.GetBool("hoohTool_foldoutProbeset", true);
        foldoutScaffolding = EditorPrefs.GetBool("hoohTool_foldoutScaffolding", true);
        foldoutMod = EditorPrefs.GetBool("hoohTool_foldoutMod", true);
        foldoutBundler = EditorPrefs.GetBool("hoohTool_foldoutBundler", true);

        category = EditorPrefs.GetInt("hoohTool_category"); // this is mine tho
        sideloaderString = EditorPrefs.GetString("hoohTool_sideloadString");
        categorySmall = EditorPrefs.GetInt("hoohTool_categorysmall"); // this is mine tho
        gameExportPath = EditorPrefs.GetString("hoohTool_exportPath");
        sliderValue = EditorPrefs.GetFloat("hoohTool_probeStrength");
        lightScaleSize = 9f;
    }

    public static void DrawUILine(Color color, int thickness = 1, int padding = 15) {
        Rect r = EditorGUILayout.GetControlRect(GUILayout.Height(padding + thickness));
        r.height = thickness;
        r.y += padding / 2;
        r.x -= 2;
        r.width += 6;
        EditorGUI.DrawRect(r, color);
    }

    private Vector2 scrollPos;

    bool CheckGoodSelection() {
        if (Selection.objects.Length <= 0) {
            EditorUtility.DisplayDialog("Error!", "You need to select at least one or more objects.", "Dismiss");
            return false;
        }
        return true;
    }
    void InitStyle() {
        titleStyle = new GUIStyle();
        titleStyle.fontSize = 15;
        titleStyle.margin = new RectOffset(10, 10, 0, 10);
        foldoutStyle = new GUIStyle(EditorStyles.foldout);
        foldoutStyle.fontSize = 15;
        foldoutStyle.margin = new RectOffset(10, 10, 0, 10);
    }

    private void OnGUI() {
        InitStyle();

        if (GUILayout.Button("Check Updates")) {
            Application.OpenURL("https://github.com/hooh-hooah/ModdingTool/tree/release/");
        }

        if (GUILayout.Button("How to make mods for AI?")) {
            Application.OpenURL("https://github.com/hooh-hooah/AI_Tips");
        }

        DrawUILine(new Color(0, 0, 0));
        EditorGUILayout.BeginVertical();
        scrollPos = EditorGUILayout.BeginScrollView(scrollPos, GUILayout.Width(0), GUILayout.Height(0));
        {
            foldoutElement = EditorGUILayout.Foldout(foldoutElement, "Element Generator", true, foldoutStyle);
            if (foldoutElement) {
                EditorPrefs.SetInt("hoohTool_category", int.Parse(EditorGUILayout.TextField("Big Category Number: ", category.ToString())));
                EditorPrefs.SetInt("hoohTool_categorysmall", int.Parse(EditorGUILayout.TextField("Mid Category Number: ", categorySmall.ToString())));
                EditorPrefs.SetString("hoohTool_sideloadString", EditorGUILayout.TextField("Game Assetbundle Path: ", sideloaderString));

                category = EditorPrefs.GetInt("hoohTool_category"); // this is mine tho
                sideloaderString = EditorPrefs.GetString("hoohTool_sideloadString");
                categorySmall = EditorPrefs.GetInt("hoohTool_categorysmall"); // this is mine tho

                if (GUILayout.Button("Generate And Fill Item List in mod.xml")) {
                    if (CheckGoodSelection()) {
                        try {
                            GameObject[] selections = Selection.gameObjects;
                            string path = Path.Combine(Path.Combine(Directory.GetCurrentDirectory(), ModPacker.GetProjectPath()), "mod.xml").Replace("\\", "/");

                            XDocument document = TouchXML.GetXMLObject(path);
                            TouchXML.GenerateObjectString(document, selections);
                            TouchXML.GenerateBundleString(document, selections);
                            Debug.Log(path);
                            document.Save(path);
                        } catch (InvalidCastException e) {
                            Debug.LogError("You've selected wrong kind of object. You should only select prefabs!");
                        } catch (Exception e) {
                            Debug.LogError(e);
                        }
                    }
                }

                if (GUILayout.Button("Add Bone Information of this object")) {
                    if (CheckGoodSelection()) {
                        try {
                            GameObject[] selections = Selection.gameObjects;
                            string path = Path.Combine(Path.Combine(Directory.GetCurrentDirectory(), ModPacker.GetProjectPath()), "mod.xml").Replace("\\", "/");

                            XDocument document = TouchXML.GetXMLObject(path);
                            TouchXML.GenerateBoneString(document, selections);
                            Debug.Log(path);
                            document.Save(path);
                        } catch (InvalidCastException e) {
                            Debug.LogError("You've selected wrong kind of object. You should only select prefabs!");
                        } catch (Exception e) {
                            Debug.LogError(e);
                        }
                    }
                }
            }

            foldoutMacros = EditorGUILayout.Foldout(foldoutMacros, "Quick Unity Macros", true, foldoutStyle);
            if (foldoutMacros) {
                gap = EditorGUILayout.IntField("Showcase Gap: ", gap);
                cols = EditorGUILayout.IntField("Showcase Columns: ", cols);
                if (GUILayout.Button("Showcase Mode")) {
                    if (CheckGoodSelection())
                        ShowcaseMode();
                }

                if (GUILayout.Button("Randomize Rotation")) {
                    if (CheckGoodSelection())
                        RandomizeRotation();
                }

                if (GUILayout.Button("Wrap Object with new GameObject and Scale")) {
                    if (CheckGoodSelection())
                        WrapObjectScale();
                }

                if (GUILayout.Button("Wrap Object with new GameObject")) {
                    if (CheckGoodSelection())
                        WrapObject();
                }
                if (GUILayout.Button("Create Prefab from Selected Objects")) {
                    if (CheckGoodSelection())
                        CreatePrefab();
                }
                lightScaleSize = EditorGUILayout.FloatField("Light Scale Size: ", lightScaleSize);
                if (GUILayout.Button("Scale Lights and Probes")) {
                    if (CheckGoodSelection())
                        ScaleLightsAndProbes();
                }
            }

            foldoutProbeset = EditorGUILayout.Foldout(foldoutProbeset, "LightProbe Adjustment", true, foldoutStyle);
            if (foldoutProbeset) {
                if (inputNumber > 5.0f) {
                    sliderValue = 5.0f;
                } else if (inputNumber < 1) {
                    sliderValue = 1;
                }

                string inputText = " ";
                sliderValue = EditorGUILayout.Slider(sliderValue, minSliderValue, maxSliderValue);

                if (inputNumber != sliderValue) {
                    if (float.TryParse(inputText, out inputNumber)) {
                        sliderValue = Mathf.Clamp(inputNumber, minSliderValue, maxSliderValue);
                    } else if (inputText == " ") {
                        inputNumber = sliderValue;
                    }
                }

                EditorPrefs.SetFloat("hoohTool_probeStrength", sliderValue);

                if (GUILayout.Button("Increase Intensity")) {
                    ProbeIntensity.ScaleLightProbeData(sliderValue);
                    ProbeIntensity.DisplayWarning();
                }

                if (GUILayout.Button("Decrease Intensity")) {
                    ProbeIntensity.ScaleLightProbeData(1 / Mathf.Abs(sliderValue));
                }

                if (GUILayout.Button("Reset Intensity")) {
                    ProbeIntensity.ResetProbeData();
                    ProbeIntensity.DisplayWarning();
                }
            }

            foldoutScaffolding = EditorGUILayout.Foldout(foldoutScaffolding, "Mod Scaffolding", true, foldoutStyle);
            if (foldoutScaffolding) {
                if (GUILayout.Button("Initialize Hair")) {
                    if (CheckGoodSelection())
                        AIObjectHelper.InitializeHair((GameObject)Selection.activeObject);
                }

                if (GUILayout.Button("Initialize Accessory")) {
                    if (CheckGoodSelection())
                        AIObjectHelper.InitializeAccessory((GameObject)Selection.activeObject);
                }

                if (GUILayout.Button("Initialize Clothes")) {
                    if (CheckGoodSelection())
                        AIObjectHelper.InitializeClothes((GameObject)Selection.activeObject);
                }

                if (GUILayout.Button("Initialize Studio Item (If it has more info)")) {
                    if (CheckGoodSelection())
                        AIObjectHelper.InitializeItem((GameObject)Selection.activeObject);
                }
            }

            foldoutMod = EditorGUILayout.Foldout(foldoutMod, "Build Mod", true, foldoutStyle);
            if (foldoutMod) {
                EditorPrefs.SetString("hoohTool_exportPath", EditorGUILayout.TextField("Zipmod Destination: ", gameExportPath));
                gameExportPath = EditorPrefs.GetString("hoohTool_exportPath");

                if (GUILayout.Button("Build Mod")) {
                    ModPacker.PackMod(gameExportPath);
                }
            }


            foldoutBundler = EditorGUILayout.Foldout(foldoutBundler, "Assetbundle Builder", true, foldoutStyle);
            if (foldoutBundler) {
                if (GUILayout.Button("Build All Assetbundles")) {
                    BuildAllAssetBundles();
                }
            }
        }

        EditorPrefs.SetBool("hoohTool_foldoutElement", foldoutElement);
        EditorPrefs.SetBool("hoohTool_foldoutMacros", foldoutMacros);
        EditorPrefs.SetBool("hoohTool_foldoutProbeset", foldoutProbeset);
        EditorPrefs.SetBool("hoohTool_foldoutScaffolding", foldoutScaffolding);
        EditorPrefs.SetBool("hoohTool_foldoutMod", foldoutMod);
        EditorPrefs.SetBool("hoohTool_foldoutBundler", foldoutBundler);

        EditorGUILayout.EndScrollView();
        EditorGUILayout.EndVertical();
    }

    public static void ScaleLightsAndProbes() {
        ReflectionProbe[] reflectionProbes = Resources.FindObjectsOfTypeAll<ReflectionProbe>();
        Light[] lights = Resources.FindObjectsOfTypeAll<Light>();
        List<Object> undoObjects = new List<Object>();
        // Scale all lights by X.
        foreach (var light in lights) {
            undoObjects.Add(light);
            switch (light.type) {
                case LightType.Area:
                    light.areaSize = new Vector2(light.areaSize.x, light.areaSize.y) * lightScaleSize;
                    break;

                case LightType.Point:
                    light.range *= lightScaleSize;
                    break;

                case LightType.Spot:
                    light.range *= lightScaleSize;
                    break;
            }
        }

        // Scale all reflection probes by X.
        foreach (var probe in reflectionProbes) {
            undoObjects.Add(probe);
            probe.size = new Vector3(probe.size.x, probe.size.y, probe.size.z) * lightScaleSize;
        }

        Undo.RecordObjects(undoObjects.ToArray(), "Undo Light Scalings");
    }

    // Show control window - WiP
    [MenuItem("hooh Tools/Show Window")]
    public static void ShowWindow() {
        GetWindow<HoohTools>(false, "hooh Tools", true);
    }

    [MenuItem("Assets/Build AssetBundles!")]
    private static void BuildAllAssetBundles() {
        BuildPipeline.BuildAssetBundles("Assets/Assetbundles", BuildAssetBundleOptions.None, BuildTarget.StandaloneWindows64);
    }

    public static bool randomizeX = true;
    public static bool randomizeY = true;
    public static bool randomizeZ = true;

    // Pretty useful to make stuffs look randomized
    [MenuItem("hooh Tools/Randomize Rotation", false)]
    public static void RandomizeRotation() {
        for (int i = 0; i < Selection.objects.Length; i++) {
            GameObject currentObject = (GameObject)Selection.objects[i];

            if (currentObject != null) {
                Vector3 ca = currentObject.transform.eulerAngles;
                currentObject.transform.eulerAngles = new Vector3(
                    randomizeX ? Random.Range(0, 360) : ca.x,
                    randomizeY ? Random.Range(0, 360) : ca.y,
                    randomizeZ ? Random.Range(0, 360) : ca.z
                   );
            }
        }
    }

    public static void ShowcaseMode() {
        for (int i = 0; i < Selection.objects.Length; i++) {
            GameObject currentObject = (GameObject)Selection.objects[i];
            int curRow = (int)Mathf.Floor(i / cols);
            int curCol = i % cols;

            if (currentObject != null) {
                currentObject.transform.position = new Vector3(
                    curCol * gap,
                    0,
                    curRow * gap
                );
            }
        }
    }

    // Pretty useful to make stuffs X time larger.
    [MenuItem("hooh Tools/Wrap Object with Gameobject", false)]
    public static void WrapObject() {
        for (int i = 0; i < Selection.objects.Length; i++) {
            GameObject currentObject = (GameObject)Selection.objects[i];

            if (currentObject != null) {
                GameObject wrapObject = new GameObject(currentObject.name);
                currentObject.transform.SetParent(wrapObject.transform);
            }
        }
    }

    [MenuItem("hooh Tools/Wrap Object with Gameobject and Scale", false)]
    public static void WrapObjectScale() {
        for (int i = 0; i < Selection.objects.Length; i++) {
            GameObject currentObject = (GameObject)Selection.objects[i];

            if (currentObject != null) {
                currentObject.transform.localScale = new Vector3(9, 9, 9);
                GameObject wrapObject = new GameObject(currentObject.name);
                currentObject.transform.SetParent(wrapObject.transform);
            }
        }
    }

    // Mass Register Prefabs. I'm sick and tired of dragging shit here and there for 10 minutes.
    [MenuItem("hooh Tools/Create Prefab")]
    public static void CreatePrefab() {
        GameObject[] objectArray = Selection.gameObjects;

        foreach (GameObject gameObject in objectArray) {
            string localPath = Path.Combine(ModPacker.GetProjectPath(), gameObject.name + ".prefab").Replace("\\", "/");
            Debug.Log(localPath);
            if (AssetDatabase.LoadAssetAtPath(localPath, typeof(GameObject))) {
                CreateNew(gameObject, localPath);
            } else {
                Debug.Log(gameObject.name + " is not a prefab, will convert");
                CreateNew(gameObject, localPath);
            }
        }
    }

    [MenuItem("hooh Tools/Create Prefab", true)]
    private static bool ValidateCreatePrefab() {
        return Selection.activeGameObject != null;
    }

    private static void CreateNew(GameObject obj, string localPath) {
        //Create a new prefab at the path given
        Object prefab = PrefabUtility.CreatePrefab(localPath, obj);
        PrefabUtility.ReplacePrefab(obj, prefab, ReplacePrefabOptions.ConnectToPrefab);
    }
}