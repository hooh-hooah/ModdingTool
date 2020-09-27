using System;
using System.IO;
using System.Text;
using System.Xml;
using System.Xml.Linq;
using MyBox;

namespace hooh_ModdingTool.asm_Packer.Utility
{
    public static class XmlUtils
    {
        public static T Attr<T>(this XElement element, string key, T def = default)
        {
            var value = element.Attribute(key)?.Value;
            if (ReferenceEquals(value, null) || ReferenceEquals(value, default(T)))
                return def;
            return (T) Convert.ChangeType(value, typeof(T));
        }

        // Consider string "" as null.
        public static string Attr(this XElement element, string key, string def = default)
        {
            var value = element.Attribute(key)?.Value;
            return value.IsNullOrEmpty() ? def.IsNullOrEmpty() ? null : def : value;
        }

        public static T Elem<T>(this XElement element, string key, T def = default)
        {
            var value = element.Element(key)?.Value;
            if (ReferenceEquals(value, null) || ReferenceEquals(value, default(T)))
                return def;
            return (T) Convert.ChangeType(value, typeof(T));
        }

        public static T FindAttr<T>(this XElement element, string[] keys, T def = default)
        {
            foreach (var key in keys)
            {
                var value = element.Attribute(key)?.Value;
                if (!ReferenceEquals(null, value) && !ReferenceEquals(value, default(T)))
                    return (T) Convert.ChangeType(value, typeof(T));
            }

            return def;
        }

        public static XDocument GetManifestTemplate()
        {
            return new XDocument(
                new XElement("manifest",
                    new XAttribute("schema-ver", 1)
                )
            );
        }

        public static void NiceSave(this XDocument document, string path)
        {
            var sb = new StringBuilder();
            var settings = new XmlWriterSettings
            {
                Indent = true,
                OmitXmlDeclaration = true,
                IndentChars = "    ",
                NewLineChars = "\n",
                NewLineHandling = NewLineHandling.Replace
            };
            using (var writer = XmlWriter.Create(sb, settings))
            {
                if (writer != null)
                    document.Save(writer);
            }

            File.WriteAllText(path, sb.ToString());
        }
    }
}