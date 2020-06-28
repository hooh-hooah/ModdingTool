#if UNITY_EDITOR
using System.Linq;
using System.Text;
using System.Xml.Linq;

internal class ManifestBuilder
{
    private readonly XDocument document;

    public ManifestBuilder(XDocument document)
    {
        this.document = document;
    }

    public string Generate()
    {
        var builder = new StringBuilder();
        builder.AppendLine("<manifest schema-ver=\"1\">");

        #region Default Information

        builder.AppendLine(string.Format("\t<guid>{0}</guid>", document.Root.Element("guid").Value));
        builder.AppendLine(string.Format("\t<name>{0}</name>", document.Root.Element("name").Value));
        builder.AppendLine(string.Format("\t<version>{0}</version>", document.Root.Element("version").Value));
        builder.AppendLine(string.Format("\t<author>{0}</author>", document.Root.Element("author").Value));
        builder.AppendLine(string.Format("\t<description>{0}</description>", document.Root.Element("description").Value));

        #endregion

        #region HeelsInformation

        // Heels Information.
        if (document.Root.Element("heels") != null)
        {
            var heels = document.Root.Element("heels").Elements("heel");
            var index = 0;

            // I'm suck at XML I'm suck at XML I'm suck at XML I'm suck at XML
            if (heels != null && heels.Count() > 0)
            {
                builder.AppendLine("\t<AI_HeelsData>");
                foreach (var heel in heels)
                {
                    builder.AppendLine(string.Format("\t\t<heel id=\"{0}\">", index));
                    builder.AppendLine(string.Format("\t\t\t<root vec=\"{0}\"/>", heel.Element("root").Attribute("vec").Value));

                    #region FootInfo

                    XElement part;
                    XElement mod;
                    foreach (var text in new[] {"foot01", "foot02"})
                    {
                        part = heel.Element(text);
                        builder.AppendLine("\t\t\t<" + text + "> ");
                        mod = part.Element("roll");
                        builder.AppendLine(string.Format("\t\t\t\t<roll vec=\"{0}\" min=\"{1}\" max=\"{2}\"/>", mod.Attribute("vec").Value, mod.Attribute("min").Value,
                            mod.Attribute("max").Value));
                        mod = part.Element("move");
                        builder.AppendLine(string.Format("\t\t\t\t<move vec=\"{0}\"/>", mod.Attribute("vec").Value));
                        mod = part.Element("scale");
                        builder.AppendLine(string.Format("\t\t\t\t<scale vec=\"{0}\"/>", mod.Attribute("vec").Value));
                        builder.AppendLine("\t\t\t</" + text + ">");
                    }

                    #endregion

                    #region ToesInfo

                    part = heel.Element("toes01");
                    builder.AppendLine("\t\t\t<toes01>");
                    mod = part.Element("roll");
                    builder.AppendLine(string.Format("\t\t\t\t<roll vec=\"{0}\"/>", mod.Attribute("vec").Value));
                    mod = part.Element("move");
                    builder.AppendLine(string.Format("\t\t\t\t<move vec=\"{0}\"/>", mod.Attribute("vec").Value));
                    mod = part.Element("scale");
                    builder.AppendLine(string.Format("\t\t\t\t<scale vec=\"{0}\"/>", mod.Attribute("vec").Value));
                    builder.AppendLine("\t\t\t</toes01>");

                    #endregion

                    builder.AppendLine("\t\t</heel>");
                    index++;
                }

                builder.AppendLine("\t</AI_HeelsData>");
            }
        }

        #endregion

        builder.AppendLine("</manifest>");
        return builder.ToString();
    }
}

#endif