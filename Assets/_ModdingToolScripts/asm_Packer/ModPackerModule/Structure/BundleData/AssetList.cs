using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Xml.Linq;
using hooh_ModdingTool.asm_Packer.Utility;
using ModPackerModule.Utility;
using MyBox;
using UnityEngine;

namespace ModPackerModule.Structure.BundleData
{
    public class AssetList : BundleBase, IBundleList
    {
        public AssetList(in SideloaderMod.SideloaderMod sideloaderMod, XElement element) : base(in sideloaderMod, element)
        {
            AddBundle(AssetPath,
                element.Elements("asset")
                    .Select(asset =>
                    {
                        var path = asset.Attr("path");
                        return !path.IsNullOrEmpty() ? Path.Combine(SideloaderMod.AssetFolder, path).ToUnixPath() : default;
                    })
                    .Where(CheckAndRememberAsset)
                    .ToArray()
            );
        }

        public AssetList(in SideloaderMod.SideloaderMod sideloaderMod, string path, string target) : base(in sideloaderMod, path, target)
        {
        }

        public AssetList AddAsset(string path, bool isAllocBundle = true)
        {
            path = !path.IsNullOrEmpty() ? Path.Combine(SideloaderMod.AssetFolder, path).ToUnixPath() : default;
            if (CheckAndRememberAsset(path)) AddBundle(AssetPath, path, isAllocBundle);
            return this;
        }

        public AssetList AddAsset(IEnumerable<string> paths, bool isAllocBundle = true)
        {
            foreach (var path in paths)
                try
                {
                    AddAsset(path, isAllocBundle);
                }
                catch (Exception e)
                {
                    Debug.LogError(e);
                    throw;
                }

            return this;
        }
    }
}