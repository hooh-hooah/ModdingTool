using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using UnityEngine;
using Random = System.Random;

namespace ModPackerModule
{
    public class ListType
    {
        private static readonly Random random = new Random();
        public string catNum = "";
        public string headerText = "";
        public string[] keys;

        public string listPath;
        public List<string> studioKeys = new List<string> {"-1", "-2", "-3", "-5"};

        public ListType(Enum catNum, string listPath, string headerText, string[] keys)
        {
            this.catNum = catNum.ToString();
            this.listPath = listPath;
            this.headerText = headerText;
            this.keys = keys;
        }

        public ListType(string catNum, string listPath, string headerText, string[] keys)
        {
            this.catNum = catNum;
            this.listPath = listPath;
            this.headerText = headerText;
            this.keys = keys;
        }

        public bool isStudioMod => studioKeys.Contains(catNum);

        public static string RandomString(int length)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            return new string(Enumerable.Repeat(chars, length)
                .Select(s => s[random.Next(s.Length)]).ToArray());
        }

        public string GenerateHeader()
        {
            var builder = new StringBuilder();

            if (!isStudioMod)
            {
                builder.AppendLine(catNum);
                builder.AppendLine("0");
                builder.AppendLine(RandomString(32));
            }

            builder.AppendLine(headerText);

            return builder.ToString();
        }

        public string GetLine(int index, XElement item, CSVBuilder instance)
        {
            var buffer = "";

            foreach (var key in keys)
                try
                {
                    AutoCSVKeys.KeyDelegate spcKey;
                    if (AutoCSVKeys.specialKeys.TryGetValue(key, out spcKey))
                        buffer += spcKey(index, key, item.Attribute(key) != null ? item.Attribute(key).Value : "0", item, instance);
                    else
                        buffer += (item.Attribute(key) != null ? item.Attribute(key).Value : "0") + ",";
                }
                catch (Exception e)
                {
                    Debug.LogError(string.Format("An Error Occured while getting values from mod.xml : {0}", key));
                    Debug.LogWarning(e);
                }

            buffer = buffer.Substring(0, buffer.Length - 1); // fucker

            buffer += "\n";
            return buffer;
        }
    }
}