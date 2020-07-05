using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Xml.Linq;
using UnityEditor;
using Debug = UnityEngine.Debug;

public partial class ModPacker
{
    public class ModPackInfo
    {
        public static string BundleCacheName = "_BundleCache/abdata";
        public static string BundleCachePath = Path.Combine(Directory.GetCurrentDirectory(), BundleCacheName).Replace("\\", "/");
        public static string AiBundlePath = Path.Combine(Directory.GetCurrentDirectory(), "_AIResources").Replace("\\", "/");
        public static string TempFolder = Path.Combine(Directory.GetCurrentDirectory(), "_Temporary").Replace("\\", "/");
        private readonly string _fileName;
        private readonly ManifestBuilder _manifestBuilder;
        private readonly SBUScriptBuilder _sbuScriptBuilder;
        private Dictionary<string, string>[] _matswapTargets;
        public List<AssetBundleBuild> AssetBundleList;
        public CSVBuilder[] CsvBuilders;
        public string path;


        public ModPackInfo(XDocument documentInfo, string path)
        {
            this.path = Path.GetDirectoryName(path);

            if (documentInfo.Root != null)
            {
                ProcessAssetBundleTargets(documentInfo);

                #region Build Material Swap Script

                if (documentInfo.Root.Element("matswap") != null)
                    _sbuScriptBuilder = new SBUScriptBuilder(documentInfo.Root.Element("matswap"));

                #endregion

                #region Build Manifest Buffer

                _fileName = documentInfo.Root.Element("build")?.Attribute("name")?.Value;
                _manifestBuilder = new ManifestBuilder(documentInfo);

                #endregion

                #region Build CSV Buffer

                var buildLists = documentInfo.Root.Element("build")?.Elements("list");
                CsvBuilders = new CSVBuilder[buildLists.Count()];
                var csvIndex = 0;
                foreach (var list in buildLists)
                {
                    var type = list.Attribute("type")?.Value;

                    if (CSVBuilder.listTypeInfo.ContainsKey(type))
                    {
                        if (CSVBuilder.listTypeInfo[type].isStudioMod)
                            CsvBuilders[csvIndex] = new CSVBuilder(type, list.Attribute("path")?.Value, this);
                        else
                            CsvBuilders[csvIndex] = new CSVBuilder(type, this);
                    }
                    else
                    {
                        Debug.LogError($"Type \"{type}\" is an invalid list category.");
                    }

                    CsvBuilders[csvIndex].Generate(list.Elements("item"));
                    csvIndex++;
                }

                #endregion
            }
            else
            {
                Debug.LogError("Invalid XML Document.");
            }
        }

        public void ProcessAssetBundleTargets(XDocument documentInfo)
        {
            var bundlesObject = documentInfo.Root.Element("bundles");
            AssetBundleList = new List<AssetBundleBuild>();

            if (bundlesObject != null)
            {
                foreach (var bundle in bundlesObject.Elements("bundle"))
                    AssetBundleList.Add(
                        new AssetBundleBuild
                        {
                            assetBundleName = bundle.Attribute("path").Value,
                            assetNames = bundle.Elements("asset")
                                .Select(asset => ValidatePath(asset.Attribute("path").Value))
                                .ToArray()
                        });

                foreach (var each in bundlesObject.Elements("each"))
                {
                    var eachSequence = 0;
                    var bundleName = each.Attribute("path")?.Value;
                    var from = each.Attribute("from")?.Value;
                    if (bundleName != null)
                    {
                        foreach (var asset in each.Elements("asset"))
                        {
                            RegisterAssetBundle(bundleName.Replace("*", $"{eachSequence:D4}"), asset.Attribute("path")?.Value);
                            eachSequence++;
                        }
                        if (from == null) continue;
                        foreach (var file in GetFilesFromPath(@from, each.Attribute("filter")?.Value))
                        {
                            RegisterAssetBundle(bundleName.Replace("*", $"{eachSequence:D4}"), file);
                            eachSequence++;
                        }
                    }
                }
            }
        }

        private void RegisterAssetBundle(string name, string asset)
        {
            if (asset == null) throw new Exception("Invalid Path Name in <asset>");
            RegisterAssetBundle(name, new[] {asset});
        }

        private void RegisterAssetBundle(string name, string[] bundles)
        {
            AssetBundleList.Add(new AssetBundleBuild
            {
                assetBundleName = name,
                assetNames = bundles.Select(ValidatePath).ToArray()
            });
        }

        public string[] GetFilesFromPath(string path, string regex = null)
        {
            // things must be sorted in order to make things more consistent.
            var regexObject = regex != null ? new Regex(regex) : null;
            var searchPath = Path.Combine(Directory.GetCurrentDirectory(), this.path, path);
            return Directory.GetFiles(searchPath)
                .Where(x => !x.EndsWith(".meta") && (!regexObject?.IsMatch(path) ?? true))
                .Select(x => Path.Combine(path, Path.GetFileName(x)))
                .OrderBy(x => x)
                .ToArray();
        }

        private string ValidatePath(string targetPath)
        {
            var result = Path.Combine(path, targetPath).Replace("\\", "/");
            if (string.IsNullOrEmpty(AssetDatabase.AssetPathToGUID(result)))
            {
                Debug.LogError("Mod Packer was not able to find following asset from folder.");
                Debug.LogError($">> {result}");
                throw new Exception("Mod Packer was not able to find specified asset from folder.");
            }

            return result;
        }

        public void SwapMaterial()
        {
            _sbuScriptBuilder?.Execute();
        }

        public void SetupModFolder()
        {
            var zipPath = Path.Combine(TempFolder, _fileName).Replace("\\", "/");
            try
            {
                var info = new DirectoryInfo(zipPath);
                foreach (var subDirectory in info.GetDirectories())
                    subDirectory.Delete(true);
            }
            catch (DirectoryNotFoundException e)
            {
            }
            catch (Exception e)
            {
                Debug.Log(e);
            }
            finally
            {
                Directory.CreateDirectory(zipPath);
            }

            File.WriteAllText(Path.Combine(zipPath, "manifest.xml").Replace("\\", "/"), _manifestBuilder.Generate());

            foreach (var bundle in AssetBundleList.Select(bundle => bundle.assetBundleName))
            {
                var source = Path.Combine(BundleCachePath, bundle).Replace("\\", "/");
                var dest = Path.Combine(zipPath, "abdata\\" + bundle).Replace("\\", "/");

                Directory.CreateDirectory(Path.Combine(
                    zipPath,
                    Path.GetDirectoryName("abdata\\" + bundle)
                ).Replace("\\", "/"));
                File.Copy(source, dest);
            }

            foreach (var builder in CsvBuilders)
            {
                var path = "";
                if (builder.valid)
                    path = builder.listPath != null
                        ? Path.Combine(zipPath, builder.listPath).Replace("\\", "/")
                        : Path.Combine(zipPath, builder.typeInfo.listPath).Replace("\\", "/");
                else
                    continue;

                Directory.CreateDirectory(Path.GetDirectoryName(path));
                File.WriteAllText(path, builder.buffer);
            }
        }

        public void DeployZipMod(string targetPath)
        {
            // TODO: Make it modular.
            var srcPath = Path.Combine(TempFolder, Path.Combine(_fileName, "*")).Replace("\\", "/");
            var extPath = Path.Combine(targetPath, _fileName + ".zipmod").Replace("\\", "/");
            var zipExec = Path.Combine(Directory.GetCurrentDirectory(), "_External\\7za.exe").Replace("\\", "/");

            var p = new Process
            {
                StartInfo =
                {
                    UseShellExecute = false, FileName = zipExec, Arguments = $"a -tzip -aoa -w{Environment.GetEnvironmentVariable("TEMP")} \"{extPath}\" \"{srcPath}\""
                }
            };
            p.Start();
            p.WaitForExit();
            if (p.ExitCode != 0)
                throw new Exception("Failed to make zip file. (" + p.ExitCode + ")");
        }

        public void BuildAssetBundles()
        {
            var result = BuildPipeline.BuildAssetBundles(BundleCacheName, AssetBundleList.ToArray(),
                BuildAssetBundleOptions.ChunkBasedCompression | BuildAssetBundleOptions.StrictMode,
                BuildTarget.StandaloneWindows64);

            if (!result)
                throw new Exception("Failed to pack asset bundle.");
        }
    }
}