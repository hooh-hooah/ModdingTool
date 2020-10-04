using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using ModPackerModule.Structure.BundleData;
using ModPackerModule.Structure.ListData;
using MyBox;
using UnityEditor;
using UnityEngine;

namespace ModPackerModule.Structure.SideloaderMod
{
    public partial class SideloaderMod
    {
        // IDEA: external bundle checking
        // REQUIREMENTS: find external bundles in the path(abdata) - mutliple path
        //               find external bundles in the sideloader - yoink the bepis plugin config to check everything automatically

        public bool IsValidAsset(string bundlePath, string assetName)
        {
            return !bundlePath.IsNullOrEmpty() && !bundlePath.IsNullOrEmpty() && (
                // First condition: if bundlePath does not exists in the mod (external bundle)?
                // Second condition: if bundlePath exists inside of bundle and if the asset is valid in the project.
                bundlePath == "0" && assetName == "0" ||
                bundlePath != "0" && !Assets.HasBundle(bundlePath) ||
                IsValidInternalAsset(assetName)
            );
        }

        public bool IsValidAssets(out (string, string) invalidAsset, IEnumerable<(string, string)> tuples)
        {
            invalidAsset = default;
            foreach (var asset in tuples)
            {
                if (IsValidAsset(asset.Item1, asset.Item2)) continue;
                invalidAsset = asset;
                return false;
            }

            return true;
        }

        public bool IsValidInternalAsset(string assetName)
        {
            if (assetName == "0") return true; // Makred as optional.
            var path = Assets.GetPathFromName(assetName);
            return !path.IsNullOrEmpty() && !AssetDatabase.AssetPathToGUID(path).IsNullOrEmpty();
        }

        public bool IsValidInternalAssets(out string invalidAsset, params string[] assetNames)
        {
            invalidAsset = null;
            foreach (var assetName in assetNames)
                if (!IsValidInternalAsset(assetName))
                {
                    invalidAsset = assetName;
                    return false;
                }

            return true;
        }

        private void ValidateBundleData()
        {
            var confirmed = true;
            var badBundleList = new List<(BundleBase, string)>();

            foreach (var bundleTarget in _bundleTargets)
            {
                if (bundleTarget.IsValid(out var reason)) continue;
                confirmed = false;
                badBundleList.Add((bundleTarget, reason));
            }

            if (confirmed) return;

            Debug.LogError("<bundles> Validation has been failed.");
            Debug.LogError("Please check items below:");
            foreach (var valueTuple in badBundleList)
            {
                var (list, reason) = valueTuple;
                Debug.LogError($"{reason} => {list}");
            }

            throw new InvalidBundleTargetException($"Found bad bundle targets from the {FileName}.xml file.");
        }

        private void ValidateListData()
        {
            var confirmed = true;
            var badList = new List<(ListBase, string)>();

            foreach (var list in _gameItems.Values
                .SelectMany(info => info.ItemList.Values
                    .SelectMany(x => x)
                ))
            {
                var result = list.IsValid(out var reason);
                if (result) continue;

                badList.Add((list, reason));
                confirmed = false;
            }

            if (confirmed) return;

            Debug.LogError("<build> Validation has been failed.");
            Debug.LogError("Please check items below:");
            foreach (var valueTuple in badList)
            {
                var (list, reason) = valueTuple;
                Debug.LogError($"{reason} => {list}");
            }

            throw new InvalidListTargetException("Found bad list targets from the {FileName}.xml file.");
        }

        public static bool IsValidModXml(string path)
        {
            var xElement = XDocument.Load(path).Root;
            return xElement != null && xElement.Name == "packer";
        }
    }
}