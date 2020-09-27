using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.Linq;
using System.Xml.Linq;
using hooh_ModdingTool.asm_Packer.Utility;
using MyBox;

namespace ModPackerModule.Structure.ListData
{
    /// <summary>
    ///     Index, Manifest
    /// </summary>
    public abstract class ListBase : IListData
    {
        // This should be referenced through all list to validate data efficiently.
        protected readonly SideloaderMod.SideloaderMod SideloaderMod;

        protected ListBase(in SideloaderMod.SideloaderMod sideloaderMod, in XElement element)
        {
            SideloaderMod = sideloaderMod;
            Index = element.Attr("id", CalculateIndex()).ClampMin(0);
            Manifest = element.Attr("manifest", sideloaderMod.DependencyData.ManifestName);
        }

        public int Index { get; set; }
        public string Manifest { get; set; }

        public virtual bool IsValid(out string reason)
        {
            reason = default;

            if (Index < 0)
            {
                reason = "Invalid Index Information, it should be above 0";
                return false;
            }

            if (Manifest.IsNullOrEmpty())
            {
                reason = "Manifest information is empty. it should be 'abdata' for default manifest value.";
                return false;
            }

            var tuples = GetAssetTuples;
            if (!tuples.IsNullOrEmpty() && !SideloaderMod.IsValidAssets(out var invalidAssetName, GetAssetTuples))
            {
                reason = invalidAssetName.Item1.IsNullOrEmpty()
                    ? "Asset Bundle Path cannot be empty."
                    : $"Unable to find asset '{invalidAssetName.Item2}', please reference valid asset in asset folder or provide external bundle path.";

                return false;
            }

            var names = GetAssetNames;
            if (!names.IsNullOrEmpty() && !ValidateUtils.BulkValidCheck(GetAssetNames.ToArray()))
            {
                reason = "The name is cannot be empty.";
                return false;
            }

            var numbers = GetCategories;
            if (!numbers.IsNullOrEmpty() && !ValidateUtils.BulkValidCheckMin(0, numbers.ToArray())) reason = "Index or Category cannot be below zero.";

            return true;
        }

        public abstract IEnumerable<(string, string)> GetAssetTuples { get; } // Things must be there
        public abstract IEnumerable<string> GetAssetNames { get; } // Things must not be empty
        public virtual IEnumerable<int> GetCategories => new[] {Index}; // Things must higher or equal than 0


        // Initialize Category index to avoid local id collision.
        // Also, the order of automatic index should be assured.
        // This does not applies when id is specified.
        private int InitializeIndex()
        {
            return 0;
        }

        private int CalculateIndex()
        {
            return SideloaderMod.IndexOffset++;
        }

        protected string GetBundleFromName(string name, string defaultBundle = default)
        {
            return SideloaderMod.Assets.GetBundleFromName(name, defaultBundle);
        }

        internal static string ToCsvLine(params object[] parameters)
        {
            return string.Join(",", parameters);
        }

        [SuppressMessage("ReSharper", "UnusedMember.Global")]
        public static string GetOutputName(IEnumerable<object> parameters)
        {
            return "generic.csv";
        }

        [SuppressMessage("ReSharper", "UnusedMember.Global")]
        public static string GetOutputHeader()
        {
            return "CSVHeader,SiderloadMod";
        }
    }
}