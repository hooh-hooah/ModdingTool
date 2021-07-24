using System;
using System.Linq;
using ModPackerModule.Structure.SideloaderMod;
using MyBox;
using UnityEngine;
#if UNITY_EDITOR
using ModPackerModule.Utility;
using UnityEditor;


#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649
#endif

[CreateAssetMenu(fileName = "Mod Context", menuName = "ModContext", order = 1)]
public class ModContext : ScriptableObject
{
    public enum FolderType
    {
        Prefab,
        Thumbnails,
        StudioThumbnails,
        Copy
    }

    [Serializable]
    public struct Folders
    {
        public FolderAsset.FolderReference assets;
        public FolderType type;
        public string filter;
    }

    public TextAsset modFile;
    public Folders[] folders;



    [ButtonMethod()]
    public void CreateThumbnail()
    {
        var folder = folders.Where(x => x.type == FolderType.Thumbnails).ToArray();
        var prefabFolders = folders.Where(x => x.type == FolderType.Prefab).ToArray();
        if (folder.Length <= 0)
        {
            Debug.LogError("Invalid thumbnails folder");
            return;
        }

        var tools = EditorWindow.GetWindow<HoohTools>();
        if (tools == null)
        {
            Debug.LogError("please open hooh tool window");
            return;
        }

        tools.GenerateThumbnail(
            prefabFolders.SelectMany(x => PathUtils.LoadAssetsFromDirectory<GameObject>(x.assets.Path, ".prefab$")).ToArray(),
            folder[0].assets.Path
        );
        // do something
    }

    [ButtonMethod()]
    public void CreateStudioThumbnail()
    {
        var folder = folders.Where(x => x.type == FolderType.StudioThumbnails).ToArray();
        if (folder.Length <= 0)
        {
            Debug.LogError("Invalid studio thumbnails folder");
            return;
        }

        // do something
    }
}
