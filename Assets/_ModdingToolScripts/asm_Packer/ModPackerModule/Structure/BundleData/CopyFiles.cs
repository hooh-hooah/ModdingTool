using System.IO;
using System.Xml.Linq;
using ModPackerModule.Utility;

namespace ModPackerModule.Structure.BundleData
{
    public class CopyFiles : BundleBase, IBundleDirectory
    {
        public string To;

        public CopyFiles(in SideloaderMod.SideloaderMod sideloaderMod, XElement element) : base(in sideloaderMod, element)
        {
            From = element.Attribute("from")?.Value;
            To = element.Attribute("to")?.Value;
            Filter = element.Attribute("filter")?.Value;
        }

        public string From { get; set; }
        public string Filter { get; set; }

        public override void ResolveAutoPath()
        {
            To = GetAutoPath(
                SideloaderMod,
                AutoPathType,
                SideloaderMod.MainData.Separator,
                AutoPathParameter
            );
        }

        public void Copy(string dirFrom, string dirTo)
        {
            PathUtils.CopyDirectory(
                Path.Combine(dirFrom, From).ToUnixPath(),
                Path.Combine(dirTo, To).ToUnixPath()
            );
        }
    }
}