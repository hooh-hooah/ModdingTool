using System;
using System.Collections.Generic;
using MyBox;
using UnityEditor;
using UnityEngine;

[CustomEditor(typeof(MapInfo))]
public class MapParameterEditor : CustomComponentBase
{
    // Currently used by ILLUSION atm.
    private static readonly int[] ReservedMapSlots = {0, 1, 2, 3, 4, 100, 101, 102, 103, 5, 6, 7, 8, 9, 10, 12, 13, 14, 15, 50, 51, 52, 53, 16};
    
    enum ButtonAction
    {
        None,
        Add,
        Remove
    }

    private const int labelWidth = 150;

    public override void OnInspectorGUI()
    {
        InitStyles();

        var mapInfo = (MapInfo) target;
        var action = ButtonAction.None;

        GUILayout.BeginHorizontal("box");
        GUILayout.Label($"Map List ({mapInfo.param.Count})", Styles.header);
        if (GUILayout.Button("+", new GUIStyle("button") {fixedWidth = 20f})) action = ButtonAction.Add;
        if (GUILayout.Button("-", new GUIStyle("button") {fixedWidth = 20f})) action = ButtonAction.Remove;
        GUILayout.EndHorizontal();
        
        mapInfo.param.ForEach(info =>
        {
            GUILayout.BeginVertical("box");

            GUILayout.BeginVertical();
            GUILayout.Label("Map Information", Styles.header);

            info.No = EditorGUILayout.IntField("MapID", info.No);

            GUILayout.Label("Map Name");
            GUILayout.BeginHorizontal();
            if (info.MapNames != null)
            {
                if (info.MapNames.Count == 2)
                {
                    info.MapNames[0] = EditorGUILayout.TextField(info.MapNames[0]);
                    info.MapNames[1] = EditorGUILayout.TextField(info.MapNames[1]);
                }
            }
            else
            {
                info.MapNames = new List<string> {"Japanese Name", "English Name"};
            }
            GUILayout.EndHorizontal();

            var oldWidth = EditorGUIUtility.labelWidth;
            EditorGUIUtility.labelWidth = labelWidth;
            info.AssetBundleName = EditorGUILayout.TextField("Asset Bundle Name", info.AssetBundleName);
            info.AssetName = EditorGUILayout.TextField("Asset Name", info.AssetName);
            EditorGUIUtility.labelWidth = oldWidth;

            GUILayout.EndVertical();

            GUILayout.BeginVertical();
            GUILayout.Label("Map Flags", Styles.header);
            EditorGUIUtility.labelWidth = labelWidth;
            info.State = EditorGUILayout.IntField("State", info.State);
            info.Draw = EditorGUILayout.IntField("Draw", info.Draw);
            info.isOutdoors = EditorGUILayout.Toggle("Is Outdoor Map", info.isOutdoors);
            info.isADV = EditorGUILayout.Toggle("Is Event Map", info.isADV);
            // get event dropdown
            EditorGUIUtility.labelWidth = oldWidth;
            GUILayout.EndVertical();

            GUILayout.BeginVertical();
            GUILayout.Label("Thumbnails", Styles.header);
            
            info.ThumbnailManifest_L = info.ThumbnailManifest_S
                = EditorGUILayout.TextField("Manifest", info.ThumbnailManifest_S);
            
            info.ThumbnailBundle_L = info.ThumbnailBundle_S
                = EditorGUILayout.TextField("Bundle", info.ThumbnailBundle_S);
            
            info.ThumbnailAsset_L = EditorGUILayout.TextField("Big Image", info.ThumbnailAsset_L);
            info.ThumbnailAsset_S = EditorGUILayout.TextField("Small Image", info.ThumbnailAsset_S);
            GUILayout.EndVertical();

            GUILayout.EndVertical();
        });

        if (action == ButtonAction.Remove)
        {
            if (!mapInfo.param.IsNullOrEmpty()) mapInfo.param.RemoveAt(mapInfo.param.Count - 1);
        }
        else if (action == ButtonAction.Add)
        {
            mapInfo.param.Add(new MapInfo.Param());
        }

        // GUILayout.BeginVertical("box");
        //     GUILayout.BeginHorizontal();
        //     if (GUILayout.Button("Re-Initialize Component"))
        //         accComponent.ReassignAllObjects();
        //     if (GUILayout.Button("Sync Default Values to Material"))
        //         accComponent.SyncMaterialDefaultValues();
        //     GUILayout.EndHorizontal();
        // GUILayout.EndVertical();
        // GUILayout.Space(5);
        //
        // if (accComponent.rendCheckVisible != null && accComponent.rendCheckVisible.Length <= 0)
        //     EditorGUILayout.HelpBox(
        //         "Rend Check Visible is EMPTY! Accessory will not rendered if rend check visible is not assigned.",
        //         MessageType.Error);
        //
        // var rendNormalTotal = accComponent.rendNormal?.Length;
        // if (rendNormalTotal <= 0)
        //     EditorGUILayout.HelpBox("Nothing is assigned to Rend Normal!", MessageType.Error);
        //
        // var total = accComponent.GetComponentsInChildren<Renderer>().Length;
        // if (accComponent.rendCheckVisible == null || total != accComponent.rendCheckVisible.Length)
        //     EditorGUILayout.HelpBox("Some Mesh Renderer is not assigned to rendCheckVisible List.", MessageType.Warning);
        // if (rendNormalTotal != total)
        //     EditorGUILayout.HelpBox("Some Mesh Renderer is not assigned to rendNormal List.", MessageType.Warning);
        //
        // EditorGUI.indentLevel++;
        // GUILayout.BeginVertical("box");
        // GUILayout.Label("Render Objects", Styles.header);
        // EditorGUILayout.PropertyField(serializedObject.FindProperty("rendCheckVisible"), new GUIContent("Visible Renderers"), true);
        // EditorGUILayout.PropertyField(serializedObject.FindProperty("rendNormal"), new GUIContent("Accessory Renderer"), true);
        // EditorGUILayout.PropertyField(serializedObject.FindProperty("trfMove01"), new GUIContent("Move Target 1"));
        // EditorGUILayout.PropertyField(serializedObject.FindProperty("trfMove02"), new GUIContent("Move Target 2"));
        // GUILayout.EndVertical();
        //
        // GUILayout.Space(5);
        //
        // var oldWidth = EditorGUIUtility.labelWidth;
        // for (var index = 1; index <= 4; index++)
        // {
        //     var colorName = "Color" + index;
        //     GUILayout.BeginVertical("box");
        //         GUILayout.Label($"{colorName} Option", Styles.header);
        //
        //         SerializedProperty property = null;
        //         if (index < 4)
        //         {
        //             property = serializedObject.FindProperty($"useColor{index:D2}");
        //             EditorGUILayout.PropertyField(property, new GUIContent($"Use Color {index}"));
        //         }
        //
        //         if (index >= 4 || (property != null && property.boolValue))
        //         {   
        //             GUILayout.Space(5);
        //             GUILayout.BeginHorizontal();
        //             EditorGUILayout.PropertyField(serializedObject.FindProperty($"useGloss{index:D2}"), new GUIContent($"Use Gloss"));
        //             EditorGUILayout.PropertyField(serializedObject.FindProperty($"useMetallic{index:D2}"), new GUIContent($"Use Metallic"));
        //             GUILayout.EndHorizontal();
        //             
        //             GUILayout.Space(5);
        //             EditorGUILayout.PropertyField(serializedObject.FindProperty($"defColor{index:D2}"), new GUIContent($"Default Color"));
        //             EditorGUILayout.PropertyField(serializedObject.FindProperty($"defGlossPower{index:D2}"), new GUIContent($"Default Gloss"));
        //             EditorGUILayout.PropertyField(serializedObject.FindProperty($"defMetallicPower{index:D2}"), new GUIContent($"Default Metallic"));
        //         }
        //      
        //         EditorGUIUtility.labelWidth = oldWidth;
        //     GUILayout.EndVertical();
        //     GUILayout.Space(5);
        // }

        serializedObject.ApplyModifiedProperties();
    }
}