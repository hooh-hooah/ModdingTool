using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Xml.Linq;
using JetBrains.Annotations;
using ModPackerModule.Utility;
using MyBox;
using UnityEngine;

namespace ModPackerModule.Structure.BundleData
{
    public class FolderBundle : BundleBase, IBundleDirectory
    {
        public FolderBundle(in SideloaderMod.SideloaderMod sideloaderMod, XElement element) : base(in sideloaderMod, element)
        {
            From = element.Attribute("from")?.Value;
            Filter = element.Attribute("filter")?.Value;
            Grouped = !(element.Attribute("grouped")?.Value).IsNullOrEmpty();
        }

        public bool Grouped { get; }
        public string From { get; set; }
        public string Filter { get; set; }

        public override void GenerateAssetBundles()
        {
            if (From.IsNullOrEmpty()) throw new Exception("'FROM' attribute of 'FOLDER' cannot be empty!");
            if (!IsDirectoryValid(From, out var validatedPath))
                throw new Exception($"Failed to find relative folder '{From}'({validatedPath}). Please check if the directory is relative to xml file.");
            var files = GetFilesWithRegex(From, Filter);
            if (Grouped) GroupFiles(files);
            else AddBundle(AssetPath, files);
        }

        private void GroupFiles([NotNull] IEnumerable<string> files)
        {
            var groupIndex = 0;
            var result = new List<string[]>();
            var leftovers = new List<string>();

            foreach (var group in files
                .Select(file => (Path: file, Name: Path.GetFileNameWithoutExtension(file)))
                .GroupBy(tuple => PathUtils.SanitizeNameForGrouping(tuple.Name)))
            {
                if (group.Count() <= 1)
                {
                    leftovers.Add(group.First().Path);
                    continue;
                }

                result.Add(group.Select(x => x.Path).ToArray());
            }

            result.AddRange(leftovers
                .GroupBy(x => Mathf.Floor((float) groupIndex++ / SideloaderMod.DependencyData.Split))
                .Select(x => x.ToArray())
                .ToList()
            );

            var index = 0;
            result.ForEach(assets =>
            {
                index += 1;
                AddBundle(AssetPath.Replace("*", $"{index:D5}"), assets);
            });
        }
    }
}