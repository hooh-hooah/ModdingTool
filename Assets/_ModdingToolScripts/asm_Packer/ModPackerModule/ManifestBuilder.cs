#if UNITY_EDITOR
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;

namespace ModPackerModule
{
    internal class ManifestBuilder
    {
        public bool Hs2Support = false;
        private static readonly string[] DefaultInformation = {"guid", "name", "version", "author", "description"};
        private readonly XDocument _document;
        private readonly List<string> _rms = new List<string> {"roll", "move", "scale"};
        public List<object[]> Hs2Manifests;
        public string Hs2Manifest;

        public ManifestBuilder(XDocument document)
        {
            _document = document;
        }

        private static string Indent(int indent)
        {
            return new string('\t', indent);
        }

        private void BuildHeelsInformation(StringBuilder builder)
        {
            // Heels Information.
            // I'm suck at XML I'm suck at XML I'm suck at XML I'm suck at XML
            if (_document.Root?.Element("heels") != null)
            {
                var heels = _document.Root.Element("heels")?.Elements("heel");
                if (heels == null) return;

                var index = 0;
                var heelsInformation = heels as XElement[] ?? heels.ToArray();
                if (heelsInformation.Any())
                {
                    builder.AppendLine($"{Indent(1)}<AI_HeelsData>");
                    foreach (var heel in heelsInformation)
                    {
                        builder.AppendLine($"{Indent(2)}<heel id=\"{index}\">");
                        builder.AppendLine($"{Indent(3)}<root vec=\"{heel.Element("root")?.Attribute("vec")?.Value}\"/>");

                        #region FootInfo

                        XElement part;
                        XElement mod;
                        foreach (var text in new[] {"foot01", "foot02"})
                        {
                            part = heel.Element(text);
                            if (part == null) continue;
                            builder.AppendLine($"{Indent(3)}<" + text + "> ");

                            _rms.ForEach(x =>
                            {
                                mod = part.Element(x);
                                builder.AppendLine(x != "roll"
                                    ? $"{Indent(4)}<{x} vec=\"{mod?.Attribute("vec")?.Value}\"/>"
                                    : $"{Indent(4)}<{x} vec=\"{mod?.Attribute("vec")?.Value}\" min=\"{mod?.Attribute("min")?.Value}\" max=\"{mod?.Attribute("max")?.Value}\"/>");
                            });

                            builder.AppendLine($"{Indent(3)}</" + text + ">");
                        }

                        #endregion

                        #region ToesInfo

                        part = heel.Element("toes01");
                        if (part != null)
                        {
                            builder.AppendLine($"{Indent(3)}<toes01>");
                            _rms.ForEach(x =>
                            {
                                mod = part.Element(x);
                                builder.AppendLine($"{Indent(4)}<{_rms} vec=\"{mod?.Attribute("vec")?.Value}\"/>");
                            });
                            builder.AppendLine($"{Indent(3)}</toes01>");
                        }

                        #endregion

                        builder.AppendLine($"{Indent(2)}</heel>");
                        index++;
                    }

                    builder.AppendLine($"{Indent(1)}</AI_HeelsData>");
                }
            }
        }

        private void BuildHs2Manifests(StringBuilder builder)
        {
            if (!Hs2Support) return;
            
            builder.AppendLine($"{Indent(1)}<hs2-scene-dependency manifest=\"{Hs2Manifest}\">");
            Hs2Manifests.ForEach(x =>
            {
                var bundle = (string) x[0];
                var assets = (string[]) x[1];
                foreach (var asset in assets)
                {
                    builder.AppendLine($"{Indent(2)}<dependency bundle=\"{bundle}\" asset=\"{asset}\"/>");
                }
            });
            builder.AppendLine($"{Indent(1)}</hs2-scene-dependency>");
        }

        public string Generate()
        {
            var builder = new StringBuilder();
            builder.AppendLine("<manifest schema-ver=\"1\">");

            if (_document.Root == null) return "";

            #region Default Information

            foreach (var info in DefaultInformation) builder.AppendLine($"\t<{info}>{_document.Root.Element(info)?.Value}</{info}>");

            #endregion

            #region AdditionalPluginInformations

            BuildHeelsInformation(builder);

            #endregion

            BuildHs2Manifests(builder);

            builder.AppendLine("</manifest>");

            return builder.ToString();
        }
    }
}

#endif