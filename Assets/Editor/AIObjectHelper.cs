using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using UnityEngine;

public class AIObjectHelper {
    public static void InitializeHair(GameObject selectedObject) {
        GameObject hairObject = selectedObject;
        hairObject.layer = 10;

        if (hairObject != null) {
            AIChara.CmpHair hairComponent = hairObject.GetComponent<AIChara.CmpHair>();
            if (hairComponent == null)
                hairComponent = hairObject.AddComponent<AIChara.CmpHair>();

            FindAssist findAssist = new FindAssist();
            findAssist.Initialize(hairComponent.transform);
            hairComponent.rendHair = (from x in hairComponent.GetComponentsInChildren<Renderer>(true) where !x.name.Contains("_acs") select x).ToArray();

            // remove all dynamic bones. smh...
            DynamicBone[] components = hairComponent.GetComponents<DynamicBone>();
            foreach (var comp in components) {
                Object.DestroyImmediate(comp);
            }

            DevPreviewHair previewComp = hairObject.GetComponent<DevPreviewHair>();
            if (previewComp == null)
                previewComp = hairObject.AddComponent<DevPreviewHair>();
            previewComp.hairTexturePath = ModPacker.GetProjectPath().Replace("Assets/", "");

            var dynBones = (from x in findAssist.dictObjName where x.Value.transform.name.Contains("_s") select x.Value).ToArray();
            foreach (GameObject bone in dynBones) {
                DynamicBone dynBone = hairObject.AddComponent<DynamicBone>();
                dynBone.m_Root = bone.transform;
                dynBone.m_UpdateRate = 60;
                dynBone.m_UpdateMode = DynamicBone.UpdateMode.AnimatePhysics;
                dynBone.m_Damping = 0.102f;
                dynBone.m_Elasticity = 0.019f;
                dynBone.m_ElasticityDistrib = new AnimationCurve();
                dynBone.m_ElasticityDistrib.AddKey(0f, 0.969f);
                dynBone.m_ElasticityDistrib.AddKey(1f, 0.603f);
                dynBone.m_Stiffness = 0.144f;
                dynBone.m_Inert = 0.072f;
                dynBone.m_Radius = 0.1f;
                dynBone.m_RadiusDistrib = new AnimationCurve();
                dynBone.m_RadiusDistrib.AddKey(0f, 1f);
                dynBone.m_RadiusDistrib.AddKey(1f, 0.5f);
                dynBone.m_EndLength = 0f;
                dynBone.m_Force = new Vector3(0, -0.005f, 0);
            }
            components = hairComponent.GetComponents<DynamicBone>();

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
            for (int i = 0; i < renderers.Length; i++) {
                renderers[i].gameObject.layer = 10;
                hairComponent.rendCheckVisible[i] = renderers[i];
            }
        }
    }

    public static void InitializeItem(GameObject selectedObject) {
        GameObject studioItemObject = selectedObject;
        studioItemObject.layer = 10;

        if (studioItemObject != null) {
            Studio.ItemComponent itemComponent = studioItemObject.GetComponent<Studio.ItemComponent>();
            if (itemComponent == null)
                itemComponent = studioItemObject.AddComponent<Studio.ItemComponent>();

            Renderer[] renderers = studioItemObject.GetComponentsInChildren<Renderer>();
            itemComponent.rendererInfos = new Studio.ItemComponent.RendererInfo[renderers.Length];
            for (int i = 0; i < renderers.Length; i++) {
                Renderer renderer = renderers[i];
                renderer.gameObject.layer = 10;
                itemComponent.rendererInfos[i] = new Studio.ItemComponent.RendererInfo();
                itemComponent.rendererInfos[i].renderer = renderer;
                itemComponent.rendererInfos[i].materials = new Studio.ItemComponent.MaterialInfo[renderer.sharedMaterials.Length];
                Studio.ItemComponent.MaterialInfo[] materials = itemComponent.rendererInfos[i].materials;
                for (int k = 0; k < renderer.sharedMaterials.Length; k++) {
                    itemComponent.rendererInfos[i].materials[k] = new Studio.ItemComponent.MaterialInfo();
                    itemComponent.rendererInfos[i].materials[k].isColor1 = true;
                }
            }
            itemComponent.info = new Studio.ItemComponent.Info[3];
            for (int i = 0; i < 3; i++) {
                itemComponent.info[i] = new Studio.ItemComponent.Info();
                itemComponent.info[i].defColor = Color.white;
            }
        }
    }

    public static void InitializeAccessory(GameObject selectedObject) {
        GameObject hairObject = selectedObject;
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

    public static void InitializeClothes(GameObject selectedObject) {
        GameObject clotheObject = selectedObject;
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
                                        select x.Value).ToArray();
            clotheComponent.objOpt02 = (from x in findAssist.dictObjName
                                        where x.Key.StartsWith("op2")
                                        select x.Value).ToArray();

            // remove all dynamic bones. smh...
            DynamicBone[] components = clotheComponent.GetComponents<DynamicBone>();
            foreach (var comp in components) {
                Object.DestroyImmediate(comp);
            }

            Regex rgx = new Regex(@"cf_J_Legsk_[0-9]{2}_00");
            var dynBones = (from x in findAssist.dictObjName where rgx.IsMatch(x.Value.transform.name) select x.Value).ToArray();
            foreach (GameObject bone in dynBones) {
                DynamicBone dynBone = clotheObject.AddComponent<DynamicBone>();
                dynBone.m_Root = bone.transform;
                dynBone.m_UpdateRate = 60;
                dynBone.m_UpdateMode = DynamicBone.UpdateMode.AnimatePhysics;
                dynBone.m_Damping = 0.102f;
                dynBone.m_Elasticity = 0.119f;
                dynBone.m_ElasticityDistrib = new AnimationCurve();
                dynBone.m_ElasticityDistrib.AddKey(0f, 0.969f);
                dynBone.m_ElasticityDistrib.AddKey(1f, 0.603f);
                dynBone.m_Stiffness = 0.144f;
                dynBone.m_Inert = 0.072f;
                dynBone.m_Radius = 0.1f;
                dynBone.m_RadiusDistrib = new AnimationCurve();
                dynBone.m_RadiusDistrib.AddKey(0f, 1f);
                dynBone.m_RadiusDistrib.AddKey(1f, 0.5f);
                dynBone.m_EndLength = 0f;
                dynBone.m_Force = new Vector3(0, 0, 0);
            }

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
    public static void InitializeFace(GameObject selectedObject) {

    }
}

