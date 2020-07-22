using System.Xml.Linq;
using static System.Int32;

namespace ModPackerModule
{
    public static partial class ModPacker
    {
        public partial class ModPackInfo
        {
            private bool _dependencyEnabled;
            private int _dependencySplits = 5;
            private string _dependencyPath;
            private string _dependencyManifest;
            private bool _hs2Support;

            private void ParseOption(XContainer documentInfo)
            {
                if (documentInfo == null) return;
                #region Is Manifested Bundle?

                var dependency = documentInfo.Element("use-dependency");
                _dependencyEnabled = dependency != null;
                if (dependency == null) return;


                _dependencyManifest = dependency.Attribute("manifest")?.Value;
                _dependencyPath = dependency.Attribute("path")?.Value;
                _dependencySplits = Parse(dependency.Attribute("splits")?.Value ?? "5");
                if (_dependencySplits <= 0) _dependencySplits = 5;

                #endregion

                #region Has Honey Select 2 Compatible Maps?

                var hs2Support = documentInfo.Element("hs2-game-support");
                _hs2Support = hs2Support != null;

                #endregion
            }
        }
    }
}