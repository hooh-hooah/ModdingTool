using System;
using System.Diagnostics;
using System.IO;
using System.Linq;
// TODO: Add Detailed Log file to see what the fuck went wrong
// TODO: make log file tail-able. latest.log -> [date]_mod.log copy

namespace ModPackerModule
{
    public static partial class ModPacker
    {
        public partial class ModPackInfo
        {
            public void SetupModFolder()
            {
                var zipPath = Path.Combine(TempFolder, _fileName).Replace("/", "\\");
                if (Directory.Exists(zipPath)) Directory.Delete(zipPath, true);
                Directory.CreateDirectory(zipPath);

                File.WriteAllText(Path.Combine(zipPath, "manifest.xml").Replace("\\", "/"), _manifestBuilder.Generate());

                var bundleList = AssetBundleList.Select(bundle => bundle.assetBundleName).ToList();
                bundleList.Add(DependencyManifest); // manifest file

                foreach (var bundle in bundleList)
                {
                    var postfix = bundle == DependencyManifest ? ".unity3d" : "";
                    var source = Path.Combine(BundleCachePath, DependencyManifest, bundle).Replace("\\", "/");
                    var dest = Path.Combine(zipPath, $"abdata\\{bundle}{postfix}").Replace("\\", "/");

                    Directory.CreateDirectory(Path.Combine(
                        zipPath,
                        Path.GetDirectoryName("abdata\\" + bundle) ?? throw new InvalidOperationException()
                    ).Replace("\\", "/"));

                    File.Copy(source, dest);
                }

                foreach (var builder in _builders)
                {
                    string assetPath;
                    if (builder.valid)
                        assetPath = builder.listPath != null
                            ? Path.Combine(zipPath, builder.listPath).Replace("\\", "/")
                            : Path.Combine(zipPath, builder.typeInfo.listPath).Replace("\\", "/");
                    else
                        continue;

                    Directory.CreateDirectory(Path.GetDirectoryName(assetPath) ?? throw new InvalidOperationException());
                    File.WriteAllText(assetPath, builder.buffer);
                }
            }

            public void DeployZipMod(string targetPath)
            {
                var srcPath = Path.Combine(TempFolder, Path.Combine(_fileName, "*")).Replace("\\", "/");
                var extPath = Path.Combine(targetPath, _fileName + ".zipmod").Replace("\\", "/");
                var zipExec = Path.Combine(Directory.GetCurrentDirectory(), "_External\\7za.exe").Replace("\\", "/");

                if (File.Exists(extPath)) File.Delete(extPath);
                
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
        }
    }
}