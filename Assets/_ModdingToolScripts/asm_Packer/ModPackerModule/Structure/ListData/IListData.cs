using System.Collections.Generic;

namespace ModPackerModule.Structure.ListData
{
    public interface IListData
    {
        int Index { get; set; }
        string Manifest { get; set; }
        IEnumerable<(string, string)> GetAssetTuples { get; }
        IEnumerable<string> GetAssetNames { get; }
        IEnumerable<int> GetCategories { get; }
        bool IsValid(out string reason);
    }
}