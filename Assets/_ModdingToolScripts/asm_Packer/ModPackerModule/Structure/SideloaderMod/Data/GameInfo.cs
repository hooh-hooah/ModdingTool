using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using hooh_ModdingTool.asm_Packer.Utility;
using ModPackerModule.Structure.ListData;
using ModPackerModule.Utility;
using MyBox;

namespace ModPackerModule.Structure.SideloaderMod.Data
{
    public class GameInfo
    {
        private readonly string _target;
        public readonly Dictionary<Type, List<ListBase>> ItemList = new Dictionary<Type, List<ListBase>>();

        public GameInfo(string target)
        {
            _target = target;
        }

        public void Insert(Type type, ListBase list)
        {
            ItemList.Insert(type, list);
        }

        public void WriteCsvFiles(string targetFolder, string folderName)
        {
            // build csv list
            foreach (var pairs in ItemList)
            {
                var type = pairs.Key;
                var value = pairs.Value;

                if (ListIdMidCategory.IsMidCategory(type))
                {
                    foreach (var group in value.Cast<ListIdMidCategory>().GroupBy(list => list.Category))
                    {
                        var groupType = group.Key;
                        var lowestGroup = group.Min(list => list.Index);
                        if (GetCsvFileInfo(type, new object[] {folderName, lowestGroup, groupType}, out var csvPath, out var csvHeader))
                            WriteCsv(targetFolder, csvPath, csvHeader, group);
                    }
                }
                else if (type.IsSubclassOf(typeof(ListClothingBase)))
                {
                    foreach (var group in value.Cast<ListClothing>().GroupBy(list => list.Category))
                    {
                        var groupType = group.Key;
                        if (!GetCsvFileInfo(type, new object[] {groupType}, out var csvPath, out var csvHeader)) continue;
                        csvHeader = $"{groupType}\n0\n{DateTime.Now.Ticks.ToString().SanitizeNonCharacters()}_{_target}\n" + csvHeader; 
                        WriteCsv(targetFolder, csvPath, csvHeader, group);
                    }
                }
                else if (type.IsSubclassOf(typeof(ListCharacterBase)))
                {
                    foreach (var group in value.Cast<ListCharacterBase>().GroupBy(list => list.Category))
                    {
                        var groupType = group.Key;
                        if (!GetCsvFileInfo(type, new object[] {groupType}, out var csvPath, out var csvHeader)) continue;
                        csvHeader = $"{groupType}\n0\n{DateTime.Now.Ticks.ToString().SanitizeNonCharacters()}_{_target}\n" + csvHeader; 
                        WriteCsv(targetFolder, csvPath, csvHeader, group);
                    }
                }
                else if (type == typeof(ListStudioItem))
                {
                    var studioItems = value.Cast<ListStudioItem>();
                    var listStudioItems = studioItems as ListStudioItem[] ?? studioItems.ToArray();
                    var midCategory = listStudioItems.Min(item => item.MidCategory);
                    var bigCategory = listStudioItems.Min(item => item.BigCategory);
                    if (GetCsvFileInfo(type, new object[] {folderName, midCategory, bigCategory}, out var csvPath, out var csvHeader))
                        WriteCsv(targetFolder, csvPath, csvHeader, listStudioItems);
                }
                else if (type == typeof(ListAnimation))
                {
                    var studioItems = value.Cast<ListAnimation>();
                    var listStudioItems = studioItems as ListAnimation[] ?? studioItems.ToArray();
                    var midCategory = listStudioItems.Min(item => item.MidCategory);
                    var bigCategory = listStudioItems.Min(item => item.BigCategory);
                    if (GetCsvFileInfo(type, new object[] {folderName, midCategory, bigCategory}, out var csvPath, out var csvHeader))
                        WriteCsv(targetFolder, csvPath, csvHeader, listStudioItems);
                }
                else if (type == typeof(ListMapCollider))
                {
                    // TODO: this does nothing yet.
                    throw new NotImplementedException();
                }
                else if (GetCsvFileInfo(type, new object[] {folderName}, out var csvPath, out var csvHeader))
                {
                    WriteCsv(targetFolder, csvPath, csvHeader, value);
                }
            }
        }

        private static void WriteCsv<T>(string targetPath, string csvPath, string csvHeader, IEnumerable<T> value) where T : ListBase
        {
            var destPath = Path.Combine(targetPath, csvPath).ToUnixPath();
            if (File.Exists(destPath)) File.Delete(destPath);
            Directory.CreateDirectory(Path.GetDirectoryName(destPath) ?? throw new Exception("Failed to create CSV directory."));
            using (var stream = new StreamWriter(destPath))
            {
                stream.WriteLine(csvHeader);
                foreach (var list in value) stream.WriteLine(list.ToString());
                stream.Close();
            }
        }

        private static bool GetCsvFileInfo(Type type, IEnumerable<object> parameters, out string path, out string header)
        {
            path = default;
            header = default;
            if (!GetName(type, parameters, out var csvPath) || !GetHeader(type, out var csvHeader)) return false;
            if (csvHeader.IsNullOrEmpty() || csvPath.IsNullOrEmpty()) return false;
            path = csvPath;
            header = csvHeader;
            return true;
        }

        private static bool GetName(Type type, IEnumerable parameters, out string name)
        {
            name = default;
            if (!type.TryGetInvokeReturn<string>("GetOutputName", new object[] {parameters}, out var csvPath)) return false;
            name = csvPath;
            return true;
        }

        private static bool GetHeader(Type type, out string header)
        {
            header = default;
            if (!type.TryGetInvokeReturn<string>("GetOutputHeader", out var csvHeader)) return false;
            header = csvHeader;
            return true;
        }
    }
}