#if UNITY_EDITOR
using System;
using System.Globalization;
using System.Linq;
using System.Text.RegularExpressions;
using System.Xml;
using System.Xml.Linq;
using UnityEditor;
using UnityEngine;

public class TouchXML
{
    private static Regex boneRegex;
    private static readonly TextInfo textFormatObject = new CultureInfo("en-US", false).TextInfo;

    public static XDocument GetXMLObject(string xmlPath)
    {
        try
        {
            var modDocument = new XmlDocument();
            modDocument.Load(xmlPath);
            return XDocument.Parse(modDocument.OuterXml);
        }
        catch (Exception e)
        {
            EditorApplication.Beep();
            EditorUtility.DisplayDialog("Error!", "There is no XML Document!", "Dismiss");
        }

        return null;
    }

    public static string Prettify(string input)
    {
        input = Regex.Replace(input, "([a-z])([A-Z])", "$1 $2");
        input = Regex.Replace(input, "([_-])", " ");
        input = textFormatObject.ToTitleCase(input);

        return input;
    }

    public static void GenerateObjectString(XDocument document, GameObject[] gameObjects)
    {
        var firstItemList = document.Root.Element("build")
            .Elements("list")
            .FirstOrDefault(x => x.Attribute("type")?.Value == "studioitem");

        if (firstItemList != null)
        {
            firstItemList.RemoveNodes();

            foreach (var obj in gameObjects)
                if (obj.scene.name == null && obj.scene.rootCount == 0)
                    firstItemList.Add(new XElement("item",
                        new XAttribute("big-category", HoohTools.Category),
                        new XAttribute("mid-category", HoohTools.CategorySmall),
                        new XAttribute("name", Prettify(obj.name)),
                        new XAttribute("object", obj.name)
                    ));
        }
        else
        {
            EditorUtility.DisplayDialog("Warning", "Unable to find <list type=\"studioitem\">\nPlease add studioitem node inside of target .xml file.", "OK");
        }
    }

    public static int GetObjectIndex(XDocument document, string name)
    {
        var lists = document.Root.Element("build").Elements("list");

        foreach (var list in lists)
            if (list.Attribute("type").Value == "studioitem")
            {
                var index = 0;
                foreach (var item in list.Elements("item"))
                {
                    if (item.Attribute("object").Value == name)
                        return index;
                    index++;
                }

                break;
            }

        return -1;
    }

    public static void GenerateBoneString(XDocument document, GameObject[] gameObjects)
    {
        var lists = document.Root.Element("build").Elements("list");
        foreach (var list in lists)
            if (list.Attribute("type").Value == "studiobones")
            {
                foreach (var obj in gameObjects)
                {
                    var index = GetObjectIndex(document, obj.name);

                    foreach (var _node in list.Elements("item"))
                        if (_node.Attribute("index") != null && _node.Attribute("index").Value == index.ToString())
                        {
                            _node.Remove();
                            break;
                        }

                    var value = "";
                    foreach (var child in obj.GetComponentsInChildren<Transform>())
                        if (child.name != obj.name && !child.GetComponent<MeshRenderer>() && !child.GetComponent<SkinnedMeshRenderer>())
                            value += child.name + ",";
                    if (value.Length > 0) value = value.Substring(0, value.Length - 1);

                    Debug.Log(value);
                    var node = new XElement("item", new XAttribute("index", index));
                    node.Value = value;
                    list.Add(node);
                }

                break;
            }
    }

    public static void GenerateBundleString(XDocument document, GameObject[] gameObjects)
    {
        var bundles = document.Root.Element("bundles");
        bundles.RemoveNodes();

        var bundle = new XElement("bundle");
        foreach (var obj in gameObjects)
            if (obj.scene.name == null && obj.scene.rootCount == 0)
                bundle.Add(new XElement("asset",
                    new XAttribute("path", obj.name + ".prefab")
                ));
        bundles.Add(bundle);
    }
}
#endif