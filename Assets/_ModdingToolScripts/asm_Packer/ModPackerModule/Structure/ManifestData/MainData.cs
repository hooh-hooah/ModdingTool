using System.Diagnostics.CodeAnalysis;
using System.Xml.Linq;
using hooh_ModdingTool.asm_Packer.Utility;
using ModPackerModule.Structure.SideloaderMod;
using ModPackerModule.Utility;
using MyBox;

namespace ModPackerModule.Structure.Classes.ManifestData
{
    public class MainData : IManifestData
    {
        public string Author;
        public string Description;
        public TargetGame Game = TargetGame.HS2;
        public string Guid;
        public string Name;
        public string UniqueId;
        public string Version;

        // Separator for generic use
        public string Separator => (UniqueId.Length > 0 ? UniqueId : Guid.SanitizeNonCharacters()).ToLower();
        public string SafeName => Guid.SanitizeNonCharacters().ToLower();

        [SuppressMessage("ReSharper", "ConvertIfStatementToReturnStatement")]
        public (bool, string) IsValid()
        {
            if (Guid.IsNullOrEmpty()) return (false, "Invalid GUID");
            if (Name.IsNullOrEmpty()) return (false, "Invalid Mod Name");
            if (Version.IsNullOrEmpty()) return (false, "Invalid Version");
            return (true, null);
        }

        public void ParseData(in SideloaderMod.SideloaderMod modObject, in XElement modDocument)
        {
            Guid = modDocument.Element("guid")?.Value.Trim();
            Name = modDocument.Element("name")?.Value.Trim();
            Version = modDocument.Elem("version", "1.0.0").Trim();
            Author = modDocument.Elem("author", "Anonymous").Trim();
            Description = modDocument.Elem("description", "No Description Provided - Packed with Modding tool.").Trim();
            UniqueId = modDocument.Elem("mod-id", "").Trim();
        }

        public void SaveData(ref XDocument document)
        {
            var root = document.Root;
            if (ReferenceEquals(null, root)) return;

            root.Add(new XElement("guid", Guid));
            root.Add(new XElement("name", Name));
            root.Add(new XElement("version", Version));
            root.Add(new XElement("author", Author));
            root.Add(new XElement("description", Description));
        }
    }
}