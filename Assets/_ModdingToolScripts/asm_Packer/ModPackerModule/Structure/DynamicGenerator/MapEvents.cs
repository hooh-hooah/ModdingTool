using System;
using System.IO;
using hooh_ModdingTool.asm_Packer.Utility;
using UnityEditor;
using UnityEngine;
using Object = UnityEngine.Object;

namespace ModPackerModule.Structure.DynamicGenerator
{
    public static class MapEvents
    {
        private static readonly MapEventParameter DefaultMapEventParameter = new MapEventParameter
        {
            camPosition = new Vector3(0, 7, 19),
            camAngle = new Vector3(0, 180, 0),
            charPosition = Vector3.zero,
            charAngle = Vector3.zero,
            fov = 45f
        };

        public static string GenerateMapEvent(string basePath, string englishMapName, int id)
        {
            var name = $"{englishMapName}_Event{id:D2}";
            var param = DefaultMapEventParameter;
            var rootGameObject = new GameObject(name);
            try
            {
                var dataComponent = rootGameObject.AddComponent(Type.GetType("ADV.EventCG.Data, Assembly-CSharp"));
                dataComponent.ReflectSetField("mapName", englishMapName);

                var cameraPosition = new GameObject("camPos");
                cameraPosition.transform.parent = rootGameObject.transform;
                cameraPosition.transform.position = param.camPosition;
                cameraPosition.transform.eulerAngles = param.camAngle;

                var camDataComponent = cameraPosition.AddComponent(Type.GetType("ADV.EventCG.CameraData, Assembly-CSharp"));
                camDataComponent.ReflectSetField("_fieldOfView", param.fov);

                var characterPosition = new GameObject("chaPos");
                characterPosition.transform.parent = rootGameObject.transform;
                characterPosition.transform.position = param.charPosition;
                characterPosition.transform.eulerAngles = param.charAngle;

                var relAssetPath = Path.Combine("map_events", name + ".prefab");
                var savePath = Path.Combine(basePath, relAssetPath);
                var dirName = Path.GetDirectoryName(savePath);
                if (dirName == null) return null;
                Directory.CreateDirectory(dirName);

                PrefabUtility.SaveAsPrefabAsset(rootGameObject, savePath);
                return relAssetPath;
            }
            catch (Exception e)
            {
                Debug.LogError(e);
            }
            finally
            {
                Object.DestroyImmediate(rootGameObject);
            }

            return null;
        }

        public struct MapEventParameter
        {
            public Vector3 camPosition;
            public Vector3 camAngle;
            public Vector3 charPosition;
            public Vector3 charAngle;
            public float fov;

            public MapEventParameter(GameObject charPoint, GameObject camPoint, float fov)
            {
                charPosition = charPoint.transform.position;
                charAngle = charPoint.transform.eulerAngles;
                camPosition = camPoint.transform.position;
                camAngle = camPoint.transform.eulerAngles;
                this.fov = fov;
            }
        }
    }
}