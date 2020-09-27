using System;
using System.Xml.Linq;
using hooh_ModdingTool.asm_Packer.Utility;
using MyBox;

namespace ModPackerModule.Structure.BundleData
{
    public class EachBundles : BundleBase, IBundleDirectory
    {
        public EachBundles(in SideloaderMod.SideloaderMod sideloaderMod, XElement element) : base(in sideloaderMod, element)
        {
            From = element.Attr("from");
            Filter = element.Attr("filter");
        }

        public string From { get; set; }
        public string Filter { get; set; }

        public override void GenerateAssetBundles()
        {
            if (From.IsNullOrEmpty()) throw new Exception("'FROM' attribute of 'FOLDER' cannot be empty!");
            if (!IsDirectoryValid(From, out var validatedPath)) throw new Exception($"Cannot find directory '{validatedPath}'");
            var files = GetFilesWithRegex(From, Filter);
            if (AssetPath.Contains("*"))
            {
                var index = 0;
                foreach (var file in files) AddBundle(AssetPath.Replace("*", $"{index++:D4}"), file);
            }
            else
            {
                throw new Exception("'EACH' tag must contain letter * to generate files");
            }
        }
    }
}