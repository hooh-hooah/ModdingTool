using System;
using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Reflection;
using UnityEditor;
using UnityEditor.VersionControl;

public class ImportAB : MonoBehaviour
{
    private static AssetBundle bundle = null;

    [MenuItem("Assets/Import AB")]
    public static void Function()
    {
        DoTheStuff(@"T:\illusion\AI-SyoujyoTrial\abdata\chara\trial\fo_inner_t_00.unity3d", "p_cf_bra_ribbon", "Assets/Meshes/VanillaBikiniTop/");
    }

    private static void DoTheStuff(string assetbundle, string prefabName, string output)
    {
        Resources.UnloadUnusedAssets();
        if (Directory.Exists(Path.Combine(output, "Materials")) == false)
            Directory.CreateDirectory(Path.Combine(output, "Materials"));
        try
        {
            bundle = AssetBundle.LoadFromFile(assetbundle);

            GameObject go = Instantiate(bundle.LoadAsset<GameObject>(prefabName));
            go.name = go.name.Replace("(Clone)", "");
            Dictionary<Mesh, Mesh> dic = new Dictionary<Mesh, Mesh>();
            Dictionary<string, int> meshNamesCount = new Dictionary<string, int>();
            foreach (SkinnedMeshRenderer renderer in go.GetComponentsInChildren<SkinnedMeshRenderer>(true))
            {
                for (int i = 0; i < renderer.sharedMaterials.Length; i++)
                {
                    Material material;
                    if (renderer.sharedMaterials[i] != null)
                    {
                        material = new Material(renderer.sharedMaterials[i]);
                    }
                    else
                    {
                        material = new Material(Shader.Find("Standard"));
                        material.name = i.ToString();
                    }
                    string path = output + "Materials/" + (renderer.sharedMesh.name + " " + material.name).Replace("(Clone)", "") + ".mat";
                    AssetDatabase.CreateAsset(material, path);

                    renderer.sharedMaterials[i] = material;
                }
                Mesh m;
                bool found = true;
                if (dic.TryGetValue(renderer.sharedMesh, out m) == false)
                {
                    m = Instantiate(renderer.sharedMesh);
                    dic.Add(renderer.sharedMesh, m);
                    found = false;
                }
                UnityEngine.Debug.LogError(renderer.sharedMesh.name);
                renderer.sharedMesh = m;
                if (found == false)
                {
                    int count;
                    if (meshNamesCount.TryGetValue(renderer.sharedMesh.name, out count) == false)
                    {
                        count = 0;
                        meshNamesCount.Add(renderer.sharedMesh.name, count);
                    }
                    ++count;
                    meshNamesCount[renderer.sharedMesh.name] = count;
                    if (count > 1)
                        AssetDatabase.CreateAsset(m, output + m.name.Replace("(Clone)", "") + "_" + count + ".asset");
                    else
                        AssetDatabase.CreateAsset(m, output + m.name.Replace("(Clone)", "") + ".asset");
                }
            }
        }
        catch (Exception e)
        {
            Debug.LogError(e);
        }
        finally
        {
            bundle.Unload(false);
        }
        //try
        //{
        //    Shader s = null;
        //    foreach (UnityEngine.Object o in bundle.LoadAllAssets())
        //    {
        //        if (o.name == "acs_m_leo_head_00")
        //        {
        //            s = ((Material)o).shader;
        //            break;
        //        }
        //    }
        //    s = UnityEngine.Object.Instantiate(s);
        //    AssetDatabase.CreateAsset(s, "Assets/PBRsp.asset");
        //    bundle.Unload(false);
        //}
        //catch (Exception e)
        //{
        //    bundle.Unload(false);
        //}

    }

    [MenuItem("Assets/Replace DynamicBones on Selected")]
    public static void ReplaceDB()
    {
        foreach (DynamicBone bone in Selection.activeGameObject.GetComponentsInChildren<DynamicBone>(true))
        {
            DynamicBone newBone = null;
            try
            {
                newBone = bone.gameObject.AddComponent<DynamicBone>();
            }
            catch (Exception e)
            {
            }
            newBone.m_Root = bone.m_Root;
            newBone.m_UpdateRate = bone.m_UpdateRate;
            newBone.m_Damping = bone.m_Damping;
            newBone.m_DampingDistrib = bone.m_DampingDistrib;
            newBone.m_Elasticity = bone.m_Elasticity;
            newBone.m_ElasticityDistrib = bone.m_ElasticityDistrib;
            newBone.m_Stiffness = bone.m_Stiffness;
            newBone.m_StiffnessDistrib = bone.m_StiffnessDistrib;
            newBone.m_Inert = bone.m_Inert;
            newBone.m_InertDistrib = bone.m_InertDistrib;
            newBone.m_Radius = bone.m_Radius;
            newBone.m_RadiusDistrib = bone.m_RadiusDistrib;
            newBone.m_EndLength = bone.m_EndLength;
            newBone.m_EndOffset = bone.m_EndOffset;
            newBone.m_Gravity = bone.m_Gravity;
            newBone.m_Force = bone.m_Force;
            newBone.m_Colliders = new List<DynamicBoneColliderBase>(bone.m_Colliders);
            newBone.m_Exclusions = new List<Transform>(bone.m_Exclusions);
            newBone.m_FreezeAxis = bone.m_FreezeAxis;
            newBone.m_DistantDisable =  bone.m_DistantDisable;
            newBone.m_ReferenceObject = bone.m_ReferenceObject;
            newBone.m_DistanceToObject = bone.m_DistanceToObject;
            DestroyImmediate(bone);
        }

    }

    [MenuItem("Assets/Replace SetRenderQueues on Selected")]
    public static void ReplaceSetRenderQueues()
    {
        foreach (SetRenderQueue queue in Selection.activeGameObject.GetComponentsInChildren<SetRenderQueue>(true))
        {
            SetRenderQueue newQueue = null;
            try
            {
                newQueue = queue.gameObject.AddComponent<SetRenderQueue>();
            }
            catch (Exception e)
            {
                
            }
            newQueue.GetType().GetField("m_queues", BindingFlags.NonPublic | BindingFlags.Instance | BindingFlags.FlattenHierarchy).SetValue(newQueue, queue.GetType().GetField("m_queues", BindingFlags.NonPublic | BindingFlags.Instance | BindingFlags.FlattenHierarchy).GetValue(queue));
            DestroyImmediate(queue);
        }
    }


}
