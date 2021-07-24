using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEngine;

public class FolderAsset
{
    [System.Serializable]
    public class FolderReference
    {
        public string GUID;

        public string Path => AssetDatabase.GUIDToAssetPath(GUID);
        //    public DefaultAsset Asset => AssetDatabase.LoadAssetAtPath<DefaultAsset>(Path);
    }

    [CustomPropertyDrawer(typeof(FolderReference))]
    public class FolderReferencePropertyDrawer : PropertyDrawer
    {
        private Dictionary<string, (SerializedProperty, Object)> data = new Dictionary<string, (SerializedProperty, Object)>();

        public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
        {
            var propertyPropertyPath = property.propertyPath;
            if (!data.TryGetValue(propertyPropertyPath, out var tuple))
            {
                var guid = property.FindPropertyRelative("GUID");
                data[propertyPropertyPath] = tuple = (guid, AssetDatabase.LoadAssetAtPath<Object>(AssetDatabase.GUIDToAssetPath(guid.stringValue)));
            }

            GUIContent guiContent = EditorGUIUtility.ObjectContent(tuple.Item2, typeof(DefaultAsset));

            Rect r = EditorGUI.PrefixLabel(position, label);

            Rect textFieldRect = r;
            textFieldRect.width -= 19f;

            GUIStyle textFieldStyle = new GUIStyle("TextField")
            {
                imagePosition = tuple.Item2 ? ImagePosition.ImageLeft : ImagePosition.TextOnly
            };

            if (GUI.Button(textFieldRect, guiContent, textFieldStyle) && tuple.Item2)
                EditorGUIUtility.PingObject(tuple.Item2);

            if (textFieldRect.Contains(Event.current.mousePosition))
            {
                Object reference;
                string path;

                switch (Event.current.type)
                {
                    case EventType.DragUpdated:
                        reference = DragAndDrop.objectReferences[0];
                        path = AssetDatabase.GetAssetPath(reference);
                        DragAndDrop.visualMode = Directory.Exists(path) ? DragAndDropVisualMode.Copy : DragAndDropVisualMode.Rejected;
                        Event.current.Use();
                        break;
                    case EventType.DragPerform:
                        reference = DragAndDrop.objectReferences[0];
                        path = AssetDatabase.GetAssetPath(reference);
                        if (Directory.Exists(path))
                        {
                            tuple.Item2 = reference;
                            tuple.Item1.stringValue = AssetDatabase.AssetPathToGUID(path);
                            data[propertyPropertyPath] = tuple;
                        }

                        Event.current.Use();
                        break;
                }
            }

            Rect objectFieldRect = r;
            objectFieldRect.x = textFieldRect.xMax + 1f;
            objectFieldRect.width = 19f;

            if (!GUI.Button(objectFieldRect, "", GUI.skin.GetStyle("IN ObjectField"))) return;
            {
                var path = EditorUtility.OpenFolderPanel("Select a folder", "Assets", "");
                if (path.Contains(Application.dataPath))
                {
                    path = "Assets" + path.Substring(Application.dataPath.Length);
                    tuple.Item2 = AssetDatabase.LoadAssetAtPath(path, typeof(DefaultAsset));
                    tuple.Item1.stringValue = AssetDatabase.AssetPathToGUID(AssetDatabase.GetAssetPath(tuple.Item2));
                    data[propertyPropertyPath] = tuple;
                }
                else Debug.LogError("The path must be in the Assets folder");
            }
        }
    }
}
