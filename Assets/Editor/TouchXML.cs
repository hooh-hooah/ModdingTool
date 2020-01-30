using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Text.RegularExpressions;
using System.Xml;
using System.IO;
using System.Xml.Linq;
using UnityEngine;
using UnityEditor;
using Object = UnityEngine.Object;

public class TouchXML {

    static Regex boneRegex;
    public static XDocument GetXMLObject(string xmlPath) {
        try {
            XmlDocument modDocument = new XmlDocument();
            modDocument.Load(xmlPath);
            return XDocument.Parse(modDocument.OuterXml);
        } catch (Exception e) {
            EditorApplication.Beep();
            EditorUtility.DisplayDialog("Error!", "There is no XML Document!", "Dismiss");
        }
        return null;
    }

    public static string Prettify(string input) {
        input = Regex.Replace(input, "([a-z])([A-Z])", "$1 $2");
        input = Regex.Replace(input, "([_-])", " ");
        return input;
    }
    public static void GenerateObjectString(XDocument document, GameObject[] gameObjects) {
        IEnumerable<XElement> lists = document.Root.Element("build").Elements("list");
        foreach (XElement list in lists) {
            if (list.Attribute("type").Value == "studioitem") {
                list.RemoveNodes();

                foreach (GameObject obj in gameObjects) {
                    if (obj.scene.name == null && obj.scene.rootCount == 0) {
                        list.Add(new XElement("item",
                            new XAttribute("big-category", HoohTools.category),
                            new XAttribute("mid-category", HoohTools.categorySmall),
                            new XAttribute("name", Prettify(obj.name)),
                            new XAttribute("object", obj.name)
                        ));
                    }
                }

                break;
            }
        }
    }

    public static int GetObjectIndex(XDocument document, string name) {
        IEnumerable<XElement> lists = document.Root.Element("build").Elements("list");

        foreach (XElement list in lists) {
            if (list.Attribute("type").Value == "studioitem") {
                int index = 0;
                foreach (XElement item in list.Elements("item")) {
                    if (item.Attribute("object").Value == name)
                        return index;
                    index++;
                }
                break;
            }
        }

        return -1;
    }
    public static void GenerateBoneString(XDocument document, GameObject[] gameObjects) {
        IEnumerable<XElement> lists = document.Root.Element("build").Elements("list");
        foreach (XElement list in lists) {
            if (list.Attribute("type").Value == "studiobones") {
                foreach (GameObject obj in gameObjects) {
                    int index = GetObjectIndex(document, obj.name);

                    foreach (var _node in list.Elements("item")) {
                        if (_node.Attribute("index") != null && (_node.Attribute("index").Value == index.ToString())) {
                            _node.Remove();
                            break;
                        }
                    }

                    string value = "";
                    foreach (Transform child in obj.GetComponentsInChildren<Transform>()) {
                        if (child.name != obj.name && !child.GetComponent<MeshRenderer>() && !child.GetComponent<SkinnedMeshRenderer>()) {
                            value += child.name + ",";
                        }
                    }
                    if (value.Length > 0) {
                        value = value.Substring(0, value.Length - 1);
                    }

                    Debug.Log(value);
                    XElement node = new XElement("item", new XAttribute("index", index));
                    node.Value = value;
                    list.Add(node);
                }

                break;
            }
        }
    }
    public static void GenerateBundleString(XDocument document, GameObject[] gameObjects) {
        XElement bundles = document.Root.Element("bundles");
        bundles.RemoveNodes();

        XElement bundle = new XElement("bundle", new XAttribute("path", HoohTools.sideloaderString));
        foreach (var obj in gameObjects) {
            if (obj.scene.name == null && obj.scene.rootCount == 0) {
                bundle.Add(new XElement("asset",
                    new XAttribute("path", obj.name + ".prefab")
                ));
            }
        }
        bundles.Add(bundle);
    }
}