using System;
using System.Globalization;
using System.Text.RegularExpressions;

namespace hooh_ModdingTool.asm_Packer.Utility
{
    public static class CommonUtils
    {
        private static readonly TextInfo textFormatObject = new CultureInfo("en-US", false).TextInfo;

        public static string Prettify(string input)
        {
            input = Regex.Replace(input, "([a-z])([A-Z])", "$1 $2");
            input = Regex.Replace(input, "([_-])", " ");
            input = textFormatObject.ToTitleCase(input);

            return input;
        }

        public static int Clamp(this int value, int min, int max)
        {
            return Math.Min(max, Math.Max(min, value));
        }

        public static int ClampMax(this int value, int max)
        {
            return Math.Min(value, max);
        }

        public static int ClampMin(this int value, int min)
        {
            return Math.Max(value, min);
        }
    }
}