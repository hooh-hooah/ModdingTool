using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Xml.Linq;
using hooh_ModdingTool.asm_Packer.Utility;
using LoremNET;
using ModPackerModule.Utility;
using UnityEditor;
using UnityEngine;

namespace ModPackerModule.Structure.SideloaderMod
{
    public partial class SideloaderMod
    {
        private const string TemplateModName = "Template Mod";
        private const string TemplateVersion = "0.0.1";
        private const string TemplateAuthor = "Anonymous";

        private static string Word()
        {
            return Lorem.Words(1, 1, false).ToLower();
        }

        private static string GetRandomName()
        {
            return $"{Word()}.{Word()}.{Word()}";
        }

        private static string GetTemplateDescription(string type)
        {
            return $"Template {type} Mod - Made with hooh's Modding Tool";
        }

        [MenuItem("Assets/Mod XML Templates/Basic Mod")]
        public static void MakeTemplate()
        {
            var assetPath = Path.Combine(Directory.GetCurrentDirectory(), PathUtils.GetProjectPath(), "mod.xml").ToUnixPath();
            var document = new XDocument();
            document.Add(new XElement("packer",
                new XElement("guid", GetRandomName()),
                new XElement("name", TemplateModName),
                new XElement("version", TemplateVersion),
                new XElement("author", TemplateAuthor),
                new XElement("description", GetTemplateDescription("Generic")),
                new XElement("bundles",
                    new XElement("folder", new XAttribute("auto-path", "prefabs"), new XAttribute("from", "output"), new XAttribute("filter", @"*.?\.prefab"))
                ),
                new XElement("build")
            ));
            document.NiceSave(assetPath);
            AssetDatabase.Refresh();
        }

        [MenuItem("Assets/Mod XML Templates/Studio Map and Items")]
        public static void MakeStudioModTemplate()
        {
            var assetPath = Path.Combine(Directory.GetCurrentDirectory(), PathUtils.GetProjectPath(), "mod.xml").ToUnixPath();
            var document = new XDocument();
            document.Add(new XElement("packer",
                new XElement("guid", GetRandomName()),
                new XElement("name", TemplateModName),
                new XElement("version", TemplateVersion),
                new XElement("author", TemplateAuthor),
                new XElement("description", GetTemplateDescription("Studio Maps and Item")),
                new XElement("bundles",
                    new XElement("folder", new XAttribute("auto-path", "prefabs"), new XAttribute("from", "prefabs"), new XAttribute("filter", @".*?\.prefab")),
                    new XElement("move", new XAttribute("auto-path", "studiothumb"), new XAttribute("from", "thumbs"), new XAttribute("filter", @".*?\.png"))
                ),
                new XElement("build",
                    new XElement("list", new XAttribute("type", "bigcategory"),
                        new XElement("item", new XAttribute("id", "2020"), new XAttribute("name", "Example Big Category"))
                    ),
                    new XElement("list", new XAttribute("type", "midcategory"),
                        new XElement("item", new XAttribute("big-category", "2020"), new XAttribute("id", "1"), new XAttribute("name", "Example Mid Category"))
                    ),
                    new XElement("list", new XAttribute("type", "studioitem"), "")
                )
            ));
            document.NiceSave(assetPath);
            AssetDatabase.Refresh();
        }

        [MenuItem("Assets/Mod XML Templates/Clothing")]
        public static void MakeCharacterModTemplate()
        {
        }

        [MenuItem("Assets/Mod XML Templates/Accessory")]
        public static void MakeAccessoryTemplate()
        {
        }

        private XElement GetListElement(string type)
        {
            var buildElement = _inputDocumentObject.Root?.Element("build");
            if (buildElement == null) return default;
            if (buildElement.Value != "") buildElement.Value = "";

            var itemList = buildElement.Elements()
                .FirstOrDefault(
                    element => element.Name.LocalName == "list" && element.Attribute("type")?.Value == type
                );
            if (!ReferenceEquals(itemList, null)) return itemList;

            itemList = new XElement("list", new XAttribute("type", type));
            buildElement.Add(itemList);
            return itemList;
        }

        public void UpsertClothing(string type)
        {
            // clothing has numerous variants.
            var studioItemList = GetListElement(type);
            if (ReferenceEquals(studioItemList, null)) return;
            Debug.Log("Attempting upsert clothing component");
        }

        public void UpsertStudioItems(IEnumerable<GameObject> gameObjects, int bigCategory = 0, int midCategory = 0)
        {
            // I really don't like the performance here, There must be the way to unfuck this mess.
            var studioItemList = GetListElement("studioitem");
            if (ReferenceEquals(studioItemList, null)) return;

            var existingItems = studioItemList.Elements("item").Where(x => x.Attribute("object") != null).ToDictionary(
                x => x.Attr("object"),
                x => x
            );

            foreach (var gameObject in gameObjects)
            {
                var name = gameObject.name;
                var prettyName = CommonUtils.Prettify(name);

                if (existingItems.ContainsKey(name))
                {
                    // Update
                    var item = existingItems[name];
                    item.SetAttributeValue("mid-category", midCategory);
                    item.SetAttributeValue("big-category", bigCategory);
                }
                else
                {
                    // Insert
                    studioItemList.Add(new XElement("item",
                        new XAttribute("object", name),
                        new XAttribute("name", prettyName),
                        new XAttribute("mid-category", midCategory),
                        new XAttribute("big-category", bigCategory)
                    ));
                }
            }
        }

        public void Save()
        {
            _inputDocumentObject.NiceSave(Path.Combine(AssetDirectory, FileName + ".xml").ToUnixPath());
        }
    }
}