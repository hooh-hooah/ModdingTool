using System.Xml.Linq;
using JetBrains.Annotations;

namespace ModPackerModule.Structure.Classes.ManifestData
{
    public interface IManifestData
    {
        // check if the manifest data is valid.
        (bool, string) IsValid();

        // Save data into the class.
        // Make sure modDocument is pointing input document.
        void ParseData([NotNull] in SideloaderMod.SideloaderMod modObject, [NotNull] in XElement modDocument);

        // Save data to document.
        // Make sure modDocument is pointing output document.
        void SaveData([NotNull] ref XDocument document);
    }
}