using System.Xml.Linq;
using hooh_ModdingTool.asm_Packer.Utility;
using MyBox;

namespace ModPackerModule.Structure.Classes.ManifestData
{
    public class DependencyLoaderData : ManifestBase, IManifestData
    {
        // TODO: Put Map Data Elsewhere.

        private static readonly string[] SplitCandidates = {"splits", "split"};
        private XElement _dependencyElement;
        private SideloaderMod.SideloaderMod _sideloaderModObject;
        public string ManifestName = "abdata";
        public bool UseDependency;
        public string Path { get; set; }
        public int Split { get; private set; }

        public (bool, string) IsValid()
        {
            if (!ReferenceEquals(null, _dependencyElement))
            {
                if (Split <= 0) return (false, "Split value cannot be zero or below.");
                if (Path.IsNullOrEmpty()) return (false, "Manifest target path cannot be empty");
                if (ManifestName.IsNullOrEmpty()) return (false, "Manifest name cannot be null");
            }

            return (true, null);
        }

        public void ParseData(in SideloaderMod.SideloaderMod modObject, in XElement modDocument)
        {
            _sideloaderModObject = modObject;
            var optionsElement = modDocument.Element("options");
            if (ReferenceEquals(null, optionsElement)) return;

            _dependencyElement = optionsElement.Element("use-dependency");
            if (ReferenceEquals(null, _dependencyElement)) return;

            ManifestName = _dependencyElement.Attr("manifest", _sideloaderModObject.MainData.Separator);
            Split = _dependencyElement.FindAttr(SplitCandidates, 5);
            Path = _dependencyElement.Attr("path", $"mod_dependency/{ManifestName}/bundles");
            UseDependency = true;
        }

        public void SaveData(ref XDocument document)
        {
            if (ReferenceEquals(null, _dependencyElement)) return;

            var hsDependency = new XElement("hs2-scene-dependency");
            hsDependency.SetAttributeValue("manifest", ManifestName);
            _sideloaderModObject.GameMapInfo.MapBundles.ForEach(mapAsset =>
            {
                var (bundle, asset) = mapAsset;
                hsDependency.Add(new XElement("dependency",
                    new XAttribute("bundle", bundle),
                    new XAttribute("asset", asset)
                ));
            });

            document.Root?.Add(hsDependency);
        }
    }
}