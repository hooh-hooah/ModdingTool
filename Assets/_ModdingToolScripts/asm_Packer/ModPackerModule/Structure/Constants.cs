using System.Diagnostics.CodeAnalysis;
using System.IO;
using System.Text.RegularExpressions;
using ModPackerModule.Utility;

namespace ModPackerModule.Structure
{
    [SuppressMessage("ReSharper", "MemberCanBePrivate.Global")]
    public class Constants
    {
        public const string NameTempFolder = "_Temporary";
        public const string NameBundleCache = "_BundleCache";
        public const string NameGameResources = "_AIResources";

        public const string RegexPatternTextureExtension = @"png|tif|jpg|tga|psd|texture|dds|renderTexture";
        public const string RegexPatternNumbers = @"([0-9 _\t])";
        public const string RegexPatternState = @"(_on|_off|_[A-Z])$";
        public const string Empty = "";

        public static readonly string PathBundleCache = Path.Combine(Directory.GetCurrentDirectory(), NameBundleCache).ToUnixPath();
        public static readonly string PathGameResource = Path.Combine(Directory.GetCurrentDirectory(), NameGameResources).ToUnixPath();
        public static readonly string PathTempFolder = Path.Combine(Directory.GetCurrentDirectory(), NameTempFolder).ToUnixPath();

        public static readonly Regex RegexTextureExtension = new Regex(RegexPatternTextureExtension, RegexOptions.Compiled);
        public static readonly Regex RegexNumbers = new Regex(RegexPatternNumbers, RegexOptions.Compiled);
        public static readonly Regex RegexState = new Regex(RegexPatternState, RegexOptions.Compiled | RegexOptions.IgnoreCase);
    }
}