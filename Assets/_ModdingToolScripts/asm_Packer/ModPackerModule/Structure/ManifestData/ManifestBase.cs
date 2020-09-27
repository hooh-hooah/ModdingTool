using System.Xml.Linq;

namespace ModPackerModule.Structure.Classes.ManifestData
{
    public abstract class ManifestBase
    {
        public static bool TryGetElementWithCandidates(XElement element, string[] candidates, out XElement candidate)
        {
            candidate = null;

            foreach (var target in candidates)
            {
                candidate = element.Element(target);
                if (!ReferenceEquals(null, candidate)) return true;
            }

            return false;
        }

        public static bool TryGetAttributeWithCandidates(XElement element, string[] candidates, out XAttribute attribute)
        {
            attribute = null;

            foreach (var candidate in candidates)
            {
                attribute = element.Attribute(candidate);
                if (!ReferenceEquals(null, attribute)) return true;
            }

            return false;
        }
    }
}