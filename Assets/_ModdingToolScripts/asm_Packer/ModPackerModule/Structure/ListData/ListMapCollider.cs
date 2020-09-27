using System.Collections.Generic;
using System.Xml.Linq;

namespace ModPackerModule.Structure.ListData
{
    public class ListMapCollider : ListBase
    {
        public ListMapCollider(in SideloaderMod.SideloaderMod sideloaderMod, in XElement element) : base(in sideloaderMod, in element)
        {
        }

        public override IEnumerable<(string, string)> GetAssetTuples { get; }
        public override IEnumerable<string> GetAssetNames { get; }

        public override string ToString()
        {
            return base.ToString();
        }

        public override bool IsValid(out string reason)
        {
            return base.IsValid(out reason);
        }
    }
}