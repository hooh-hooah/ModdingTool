using System.Collections.Generic;
using System.IO;
using System.Linq;
using UnityEditor;
using UnityEngine;

public class HoohTools : EditorWindow {
    // TODO: Make these moddable with windows.
    public static int category = 0;
    public static string sideloaderString = "";
    public static int categorySmall = 0;
    public static string manifest = "";
    public static float lightScaleSize = 9f;
    public static string gameExportPath = "";
    public static int gap = 10;
    public static int cols = 10;

    public void OnEnable() {
        category = EditorPrefs.GetInt("hoohTool_category"); // this is mine tho
        sideloaderString = EditorPrefs.GetString("hoohTool_sideloadString");
        categorySmall = EditorPrefs.GetInt("hoohTool_categorysmall"); // this is mine tho
        manifest = EditorPrefs.GetString("hoohTool_manifest");
        gameExportPath = EditorPrefs.GetString("hoohTool_exportPath");
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

    Vector2 scrollPos;
    private void OnGUI() {
        if (GUILayout.Button("Check Updates")) {
            Application.OpenURL("https://github.com/hooh-hooah/AI_ModTools/releases");
        }

        if (GUILayout.Button("How to make mods for AI?")) {
            Application.OpenURL("https://github.com/hooh-hooah/AI_Tips");
        }

        EditorGUILayout.BeginVertical();
        scrollPos = EditorGUILayout.BeginScrollView(scrollPos, GUILayout.Width(0), GUILayout.Height(0));
        {
            // help
            var titleStyle = new GUIStyle();
                titleStyle.fontSize = 15;
                titleStyle.margin = new RectOffset(10, 10, 0, 10);

            DrawUILine(new Color(0, 0, 0));
            GUILayout.Label("CSV Generator", titleStyle);

            EditorPrefs.SetInt("hoohTool_category", int.Parse(EditorGUILayout.TextField("Big Category Number: ", category.ToString()))); 
            EditorPrefs.SetInt("hoohTool_categorysmall", int.Parse(EditorGUILayout.TextField("Mid Category Number: ", categorySmall.ToString())));
            EditorPrefs.SetString("hoohTool_sideloadString", EditorGUILayout.TextField("Game Assetbundle Path: ", sideloaderString));
            EditorPrefs.SetString("hoohTool_manifest", EditorGUILayout.TextField("Manifest(?): ", manifest));

            category = EditorPrefs.GetInt("hoohTool_category"); // this is mine tho
            sideloaderString = EditorPrefs.GetString("hoohTool_sideloadString");
            categorySmall = EditorPrefs.GetInt("hoohTool_categorysmall"); // this is mine tho
            manifest = EditorPrefs.GetString("hoohTool_manifest");

            if (GUILayout.Button("Generate Item List")) {
                if (Selection.objects.Length <= 0)
                    EditorUtility.DisplayDialog("Error!", "You have to select at least one or more objects to generate studio item CSV.", "Yee, boi");
                else
                    GenerateCSV();
            }

            DrawUILine(new Color(0, 0, 0));
            GUILayout.Label("Quick Unity Macros", titleStyle);

            gap = EditorGUILayout.IntField("Showcase Gap: ", gap);
            cols =  EditorGUILayout.IntField("Showcase Columns: ", cols);
            if (GUILayout.Button("Showcase Mode")) {
                if (Selection.objects.Length <= 0)
                    EditorUtility.DisplayDialog("Error!", "You have to select at least one or more objects to generate studio item CSV.", "Yee, boi");
                else
                    ShowcaseMode();
            }

            if (GUILayout.Button("Randomize Rotation")) {
                if (Selection.objects.Length <= 0)
                    EditorUtility.DisplayDialog("Error!", "You have to select at least one or more objects to generate studio item CSV.", "Yee, boi");
                else
                    RandomizeRotation();
            }

            if (GUILayout.Button("Wrap Object with new GameObject and Scale")) {
                if (Selection.objects.Length <= 0)
                    EditorUtility.DisplayDialog("Error!", "You have to select at least one or more objects to generate studio item CSV.", "Yee, boi");
                else
                    WrapObjectScale();
            }

            if (GUILayout.Button("Wrap Object with new GameObject")) {
                if (Selection.objects.Length <= 0)
                    EditorUtility.DisplayDialog("Error!", "You have to select at least one or more objects to generate studio item CSV.", "Yee, boi");
                else
                    WrapObject();
            }
            if (GUILayout.Button("Create Prefab from Selected Objects")) {
                if (Selection.objects.Length <= 0)
                    EditorUtility.DisplayDialog("Error!", "You have to select at least one or more objects to generate studio item CSV.", "Yee, boi");
                else
                    CreatePrefab();
            }

            lightScaleSize = EditorGUILayout.FloatField("Light Scale Size: ", lightScaleSize);
            if (GUILayout.Button("Scale Lights and Probes")) {
                if (Selection.objects.Length <= 0)
                    EditorUtility.DisplayDialog("Error!", "You have to select at least one or more objects to generate studio item CSV.", "Yee, boi");
                else
                    ScaleLightsAndProbes();
            }

            GUILayout.Label("Mod Scaffolding", titleStyle);

            if (GUILayout.Button("Initialize Hair")) {
                GameObject hairObject = (GameObject)Selection.activeObject; // get only one
                hairObject.layer = 10;

                if (hairObject != null) {
                    AIChara.CmpHair hairComponent = hairObject.GetComponent<AIChara.CmpHair>();
                    if (hairComponent == null)
                        hairComponent = hairObject.AddComponent<AIChara.CmpHair>();




                    FindAssist findAssist = new FindAssist();
                    findAssist.Initialize(hairComponent.transform);
                    hairComponent.rendHair = (from x in hairComponent.GetComponentsInChildren<Renderer>(true)
                                     where !x.name.Contains("_acs")
                                     select x).ToArray<Renderer>();
                    DynamicBone[] components = hairComponent.GetComponents<DynamicBone>();
                    KeyValuePair<string, GameObject> keyValuePair = findAssist.dictObjName.FirstOrDefault((KeyValuePair<string, GameObject> x) => x.Key.Contains("_top"));
                    if (keyValuePair.Equals(default(KeyValuePair<string, GameObject>))) {
                        return;
                    }
                    hairComponent.boneInfo = new AIChara.CmpHair.BoneInfo[keyValuePair.Value.transform.childCount];
                    for (int i = 0; i < hairComponent.boneInfo.Length; i++) {
                        Transform child = keyValuePair.Value.transform.GetChild(i);
                        findAssist.Initialize(child);
                        AIChara.CmpHair.BoneInfo boneInfo = new AIChara.CmpHair.BoneInfo();
                        KeyValuePair<string, GameObject> keyValuePair2 = findAssist.dictObjName.FirstOrDefault((KeyValuePair<string, GameObject> x) => x.Key.Contains("_s"));
                        if (!keyValuePair2.Equals(default(KeyValuePair<string, GameObject>))) {
                            Transform transform = keyValuePair2.Value.transform;
                            boneInfo.trfCorrect = transform;
                            boneInfo.basePos = boneInfo.trfCorrect.transform.localPosition;
                            boneInfo.posMin.x = boneInfo.trfCorrect.transform.localPosition.x + 0.5f;
                            boneInfo.posMin.y = boneInfo.trfCorrect.transform.localPosition.y;
                            boneInfo.posMin.z = boneInfo.trfCorrect.transform.localPosition.z + 0.5f;
                            boneInfo.posMax.x = boneInfo.trfCorrect.transform.localPosition.x - 0.5f;
                            boneInfo.posMax.y = boneInfo.trfCorrect.transform.localPosition.y - 0.5f;
                            boneInfo.posMax.z = boneInfo.trfCorrect.transform.localPosition.z - 0.5f;
                            boneInfo.baseRot = boneInfo.trfCorrect.transform.localEulerAngles;
                            boneInfo.rotMin.x = boneInfo.trfCorrect.transform.localEulerAngles.x - 30f;
                            boneInfo.rotMin.y = boneInfo.trfCorrect.transform.localEulerAngles.y - 30f;
                            boneInfo.rotMin.z = boneInfo.trfCorrect.transform.localEulerAngles.z - 30f;
                            boneInfo.rotMax.x = boneInfo.trfCorrect.transform.localEulerAngles.x + 30f;
                            boneInfo.rotMax.y = boneInfo.trfCorrect.transform.localEulerAngles.y + 30f;
                            boneInfo.rotMax.z = boneInfo.trfCorrect.transform.localEulerAngles.z + 30f;
                            boneInfo.moveRate.x = Mathf.InverseLerp(boneInfo.posMin.x, boneInfo.posMax.x, boneInfo.basePos.x);
                            boneInfo.moveRate.y = Mathf.InverseLerp(boneInfo.posMin.y, boneInfo.posMax.y, boneInfo.basePos.y);
                            boneInfo.moveRate.z = Mathf.InverseLerp(boneInfo.posMin.z, boneInfo.posMax.z, boneInfo.basePos.z);
                            boneInfo.rotRate.x = Mathf.InverseLerp(boneInfo.rotMin.x, boneInfo.rotMax.x, boneInfo.baseRot.x);
                            boneInfo.rotRate.y = Mathf.InverseLerp(boneInfo.rotMin.y, boneInfo.rotMax.y, boneInfo.baseRot.y);
                            boneInfo.rotRate.z = Mathf.InverseLerp(boneInfo.rotMin.z, boneInfo.rotMax.z, boneInfo.baseRot.z);
                        }
                        List<DynamicBone> list = new List<DynamicBone>();
                        DynamicBone[] array = components;
                        for (int j = 0; j < array.Length; j++) {
                            DynamicBone n = array[j];
                            if (!findAssist.dictObjName.FirstOrDefault((KeyValuePair<string, GameObject> x) => x.Key == n.m_Root.name).Equals(default(KeyValuePair<string, GameObject>))) {
                                list.Add(n);
                            }
                        }
                        boneInfo.dynamicBone = list.ToArray();
                        hairComponent.boneInfo[i] = boneInfo;
                    }
                    findAssist = new FindAssist();
                    findAssist.Initialize(hairComponent.transform);
                    hairComponent.rendAccessory = (from s in findAssist.dictObjName
                                          where s.Key.Contains("_acs")
                                          select s into x
                                          select x.Value.GetComponent<Renderer>() into r
                                          where null != r
                                          select r).ToArray<Renderer>();


                    Renderer[] renderers = hairObject.GetComponentsInChildren<Renderer>();
                    hairComponent.rendCheckVisible = new Renderer[renderers.Length];
                    hairComponent.rendHair = new Renderer[renderers.Length];
                    for (int i = 0; i < renderers.Length; i++) {
                        renderers[i].gameObject.layer = 10;
                        hairComponent.rendCheckVisible[i] = renderers[i];
                        hairComponent.rendHair[i] = renderers[i];
                    }
                }
            }

            if (GUILayout.Button("Initialize Accessory")) {
                GameObject hairObject = (GameObject)Selection.activeObject;
                hairObject.layer = 10;

                if (hairObject != null) {
                    AIChara.CmpAccessory accComponent = hairObject.GetComponent<AIChara.CmpAccessory>();
                    if (accComponent == null)
                        accComponent = hairObject.AddComponent<AIChara.CmpAccessory>();

                    FindAssist findAssist = new FindAssist();
                    findAssist.Initialize(accComponent.transform);
                    accComponent.trfMove01 = findAssist.GetTransformFromName("N_move");
                    accComponent.trfMove02 = findAssist.GetTransformFromName("N_move2");

                    Renderer[] renderers = hairObject.GetComponentsInChildren<Renderer>();
                    accComponent.rendCheckVisible = new Renderer[renderers.Length];
                    accComponent.rendNormal = new Renderer[renderers.Length];
                    for (int i = 0; i < renderers.Length; i++) {
                        renderers[i].gameObject.layer = 10;
                        accComponent.useColor01 = true;
                        accComponent.rendCheckVisible[i] = renderers[i];
                        accComponent.rendNormal[i] = renderers[i];
                    }
                }
            }

            if (GUILayout.Button("Initialize Clothes")) {
                GameObject clotheObject = (GameObject)Selection.activeObject;
                clotheObject.layer = 10;

                if (clotheObject != null) {
                    AIChara.CmpClothes clotheComponent = clotheObject.GetComponent<AIChara.CmpClothes>();
                    if (clotheComponent == null)
                        clotheComponent = clotheObject.AddComponent<AIChara.CmpClothes>();

                    FindAssist findAssist = new FindAssist();
                    findAssist.Initialize(clotheComponent.transform);
                    clotheComponent.objTopDef = findAssist.GetObjectFromName("n_top_a");
                    clotheComponent.objTopHalf = findAssist.GetObjectFromName("n_top_b");
                    clotheComponent.objBotDef = findAssist.GetObjectFromName("n_bot_a");
                    clotheComponent.objBotHalf = findAssist.GetObjectFromName("n_bot_b");
                    clotheComponent.objOpt01 = (from x in findAssist.dictObjName
                                     where x.Key.StartsWith("op1")
                                     select x.Value).ToArray<GameObject>();
                    clotheComponent.objOpt02 = (from x in findAssist.dictObjName
                                     where x.Key.StartsWith("op2")
                                     select x.Value).ToArray<GameObject>();

                    Renderer[] renderers = clotheObject.GetComponentsInChildren<Renderer>();
                    clotheComponent.rendCheckVisible = new Renderer[renderers.Length];
                    clotheComponent.rendNormal01 = new Renderer[renderers.Length];
                    for (int i = 0; i < renderers.Length; i++) {
                        renderers[i].gameObject.layer = 10;
                        clotheComponent.useColorN01 = true;
                        clotheComponent.rendCheckVisible[i] = renderers[i];
                        clotheComponent.rendNormal01[i] = renderers[i];
                    }
                }
            }

            DrawUILine(new Color(0, 0, 0));
            GUILayout.Label("Pack Hair Mod", titleStyle);
            EditorPrefs.SetString("hoohTool_exportPath", EditorGUILayout.TextField("Zipmod Destination: ", gameExportPath));
            gameExportPath = EditorPrefs.GetString("hoohTool_exportPath");

            if (GUILayout.Button("Build Hair Mod")) {
                ModPacker.PackMod(gameExportPath, "hair");
            }

            if (GUILayout.Button("Build Studio Mod")) {
                ModPacker.PackMod(gameExportPath, "studio");
            }

            if (GUILayout.Button("Build Map Mod")) {
                ModPacker.PackMod(gameExportPath, "map");
            }

            if (GUILayout.Button("Build Female Clothes")) {
                ModPacker.PackMod(gameExportPath, "fclothe");
            }

            if (GUILayout.Button("Build Male Clothes")) {
                ModPacker.PackMod(gameExportPath, "mclothe");
            }

            if (GUILayout.Button("Build Accessory")) {
                ModPacker.PackMod(gameExportPath, "acc");
            }

            DrawUILine(new Color(0, 0, 0));
            GUILayout.Label("Assetbundle Builder", titleStyle);
            if (GUILayout.Button("Build All Assetbundles")) {
                BuildAllAssetBundles();
            }
        }
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

    [MenuItem("Assets/Generate Item List")]
    public static void GenerateCSV() {
        string path = Path.Combine(ModPacker.GetProjectPath(), "generated.txt");

        // Generate CSV files.
        if (File.Exists(path))
            File.Delete(path);
        StreamWriter writer = new StreamWriter(path, true);

        Object[] selections = Selection.objects;
        List<Object> beforeList = new List<Object>(selections);
        List<Object> list = beforeList.OrderBy(o => o.name).ToList();

        for (int i = 0; i < list.Count; i++) {
            Object currentObject = list[i];
            string niceString = currentObject.name;
            niceString = niceString.Replace('-', ' ');
            niceString = niceString.Replace('_', ' ');

            string toWrite = string.Format("<asset path=\"{0}\"/>", currentObject.name + ".prefab");
            writer.WriteLine(toWrite);
            //Debug.Log(toWrite);
        }

        for (int i = 0; i < list.Count; i++) {
            Object currentObject = list[i];
            string niceString = currentObject.name;
            niceString = niceString.Replace('-', ' ');
            niceString = niceString.Replace('_', ' ');

            string toWrite = string.Format("<item big-category=\"{1}\" mid-category=\"{2}\" name=\"{3}\" manifest=\"{4}\" bundle=\"{5}.unity3d\" object=\"{6}\" />", i, category, categorySmall, niceString, manifest, sideloaderString, currentObject.name);
            writer.WriteLine(toWrite);
            //Debug.Log(toWrite);
        }
        writer.Close();
        Debug.Log("CSV has been generated to " + path);
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
            int curRow = (int) Mathf.Floor(i / cols);
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
            string localPath = Path.Combine(ModPacker.GetProjectPath(), gameObject.name + ".prefab").Replace('\\', '/');
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