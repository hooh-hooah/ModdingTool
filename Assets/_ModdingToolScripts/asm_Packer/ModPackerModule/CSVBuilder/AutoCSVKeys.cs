using System;
using System.Collections.Generic;
using System.Xml.Linq;

namespace ModPackerModule
{
    public static class AutoCSVKeys
    {
        public delegate string KeyDelegate(int index, string key, string parameter, XElement item, CSVBuilder instance);

        public static Dictionary<string, KeyDelegate> specialKeys = new Dictionary<string, KeyDelegate>
        {
            {"scene", GetBundleFromAsset},
            {"object", GetBundleFromAsset},
            {"thumb", GetBundleFromAsset},
            {"mesh-a", GetBundleFromAsset},
            {"tex-a", GetBundleFromAsset},
            {"bodymask-tex", GetBundleFromAsset},
            {"bramask-tex", GetBundleFromAsset},
            {"innermask-tb-tex", GetBundleFromAsset},
            {"innermask-b-tex", GetBundleFromAsset},
            {"panstmask-tex", GetBundleFromAsset},
            {"bodymask-b-tex", GetBundleFromAsset},
            {"manifest", InsertManifest},
            {"index", InsertIndex},
            {"set-hair", InsertNull},
            {"en-us", InsertNull},
            {"bones", BoneText},
            {"anime-controller", GetBundleFromAsset},
            {"anime-index", InsertAnimeIndex},
            {"anime-null", InsertAnimeNull} // temporal. I'll figure out later.
        };

        private static string GetBundleFromAsset(int index, string key, string assetName, XElement item, CSVBuilder instance)
        {
            var bundleName = "0";
            var bundles = instance.packData.AssetBundleList;
            var dashIndex = key.LastIndexOf('-') < 0 ? key.Length : key.LastIndexOf('-');
            var bundleKey = key.Substring(0, dashIndex) + "-bundle";

            if (item.Attribute(bundleKey) != null)
            {
                bundleName = item.Attribute(bundleKey)?.Value;
            }
            else
            {
                // TODO: Improve asset auto assignment search algorithms 
                // 1. reduce search string to essential parts such as filename or first part of directory.
                // 2. cache found filenames to avoid same filename traps.
                // 3. research about shitty case of search algorithms (similar names, fucky situations (like url parsing you fucker))

                var diffLength = int.MaxValue; // no meme value.
                bundles.ForEach(bundleInfo =>
                {
                    foreach (var name in bundleInfo.assetNames)
                    {
                        var fuckshit = name.Substring(name.LastIndexOf('/')); // yeah fuckoff you fucking cunt
                        if (fuckshit.Contains(assetName))
                        {
                            var length = Math.Abs(assetName.Length - fuckshit.Length);
                            if (diffLength > length)
                            {
                                diffLength = length;
                                bundleName = bundleInfo.assetBundleName.Replace("\\", "/");
                            }
                        }
                    }

                    //Debug.Log(string.Format("{0}: {1}", key, bundleName));
                    if (bundleName == "0")
                    {
                        //throw new Exception("Cannot find bundle that includes " + assetName);
                    }
                });
            }

            return $"{bundleName},{assetName},";
        }

        private static string InsertIndex(int index, string key, string parameter, XElement item, CSVBuilder instance)
        {
            return index + ",";
        }

        private static string InsertAnimeIndex(int index, string key, string parameter, XElement item, CSVBuilder instance)
        {
            return index + "," + index + ",";
        }

        private static string InsertNull(int index, string key, string parameter, XElement item, CSVBuilder instance)
        {
            return "0,";
        }

        private static string InsertManifest(int index, string key, string parameter, XElement item, CSVBuilder instance)
        {
            // manifests are used for resolving dependency between assets.
            return $"{instance?.packData?.DependencyManifest},";
        }

        private static string BoneText(int index, string key, string parameter, XElement item, CSVBuilder instance)
        {
            return item.Value;
        }

        private static string InsertAnimeNull(int index, string key, string parameter, XElement item, CSVBuilder instance)
        {
            return ",,,,,,,,,";
        }
    }
}