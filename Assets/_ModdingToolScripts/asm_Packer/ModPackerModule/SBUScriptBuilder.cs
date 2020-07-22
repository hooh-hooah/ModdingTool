#if UNITY_EDITOR
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Text;
using System.Xml.Linq;

namespace ModPackerModule
{
    internal class SBUScriptBuilder
    {
        private static readonly string execPath = Path.Combine(Directory.GetCurrentDirectory(), "_External\\sb3\\SB3UtilityScript.exe").Replace("\\", "/");
        private static readonly string tempPath = Path.Combine(Directory.GetCurrentDirectory(), "_Temporary\\__temp__.txt").Replace("\\", "/");

        private readonly XElement document;

        public SBUScriptBuilder(XElement document)
        {
            this.document = document;
        }

        public string Generate()
        {
            var builder = new StringBuilder();

            #region Initialize Variables

            var targets = document.Elements("target");
            var index = 0;
            var uniqueBundles = new Dictionary<string, int>();

            #endregion

            #region Replace Material and assign Textures

            foreach (var target in targets)
            {
                var meshPath = Path.Combine(ModPacker.ModPackInfo.BundleCachePath, target.Attribute("mesh-bundle").Value).Replace("/", "\\");

                #region Declare Bundle Information

                builder.AppendLine("LoadPlugin(PluginDirectory + \"UnityPlugin.dll\")");
                builder.AppendLine($"meshPath{index} = \"{meshPath}\"");
                builder.AppendLine($"texPath{index} = \"{Path.Combine(ModPacker.ModPackInfo.BundleCachePath, target.Attribute("tex-bundle").Value).Replace("/", "\\")}\"");
                builder.AppendLine($"matPath{index} = \"{Path.Combine(ModPacker.ModPackInfo.AiBundlePath, target.Attribute("mat-bundle").Value).Replace("/", "\\")}\"");
                builder.AppendLine();

                #endregion

                #region Initialize SB3 Bundles

                builder.AppendLine($"meshParser{index} = OpenUnity3d(path=meshPath{index})");
                builder.AppendLine($"meshEditor{index} = Unity3dEditor(parser=meshParser{index})");
                builder.AppendLine($"meshEditor{index}.GetAssetNames(filter=True)");
                builder.AppendLine($"texParser{index} = OpenUnity3d(path=texPath{index})");
                builder.AppendLine($"texEditor{index} = Unity3dEditor(parser=texParser{index})");
                builder.AppendLine($"texEditor{index}.GetAssetNames(filter=True)");
                builder.AppendLine($"matParser{index} = OpenUnity3d(path=matPath{index})");
                builder.AppendLine($"matEditor{index} = Unity3dEditor(parser=matParser{index})");
                builder.AppendLine($"matEditor{index}.GetAssetNames(filter=True)");
                builder.AppendLine();

                #endregion

                #region Initialize Animators

                builder.AppendLine($"compIdx{index} = meshEditor{index}.ComponentIndex(name=\"{target.Attribute("mesh-object").Value}\", clsIDname=\"Animator\")");
                builder.AppendLine($"texAnimator{index} = AnimatorEditor(cabinet=texParser{index}.Cabinet)");
                builder.AppendLine($"matAnimator{index} = AnimatorEditor(cabinet=matParser{index}.Cabinet)");
                builder.AppendLine($"meshAnimator{index} = meshEditor{index}.OpenAnimator(componentIndex=compIdx{index})");
                builder.AppendLine($"meshAnimEditor{index} = AnimatorEditor(parser=meshAnimator{index})");
                builder.AppendLine($"texEditor{index}.GetAssetNames(filter=True)");
                builder.AppendLine();

                #endregion

                #region Transfer Materials

                builder.AppendLine($"meshEditor{index}.BeginTransfer()");
                builder.AppendLine($"\tmatIndex{index} = matEditor{index}.ComponentIndex(name=\"{target.Attribute("mat-name").Value}\", clsIDname=\"Material\")");
                builder.AppendLine($"\tsrcMat{index} = matParser{index}.Cabinet.Components[matIndex{index}]");
                builder.AppendLine($"\tsrcMat{index} = matAnimator{index}.AddMaterialToEditor(srcMat{index})");
                builder.AppendLine($"\tmeshAnimEditor{index}.MergeMaterial(mat=srcMat{index})");
                builder.AppendLine($"\tmeshEditor{index}.GetAssetNames(filter=True)");
                builder.AppendLine($"meshEditor{index}.EndTransfer()");
                builder.AppendLine();

                #endregion

                #region Assign Material to Object

                builder.AppendLine($"meshEditor{index}.GetAssetNames(filter=True)");
                builder.AppendLine($"copyMatCompIndex{index} = meshEditor{index}.ComponentIndex(name=\"{target.Attribute("mat-name").Value}\", clsIDname=\"Material\")");
                builder.AppendLine($"meshAnimEditor{index}.AddMaterialToEditor(meshEditor{index}.Parser.Cabinet.Components[copyMatCompIndex{index}])");
                builder.AppendLine($"meshEditor{index}.GetAssetNames(filter=True)");
                builder.AppendLine($"copyMatIndex{index} = meshAnimEditor{index}.GetMaterialId(\"{target.Attribute("mat-name").Value}\")");
                builder.AppendLine($"meshAnimEditor{index}.SetSubMeshMaterial(meshId=0, subMeshId=0, material=copyMatIndex{index})");
                builder.AppendLine($"meshEditor{index}.GetAssetNames(filter=True)");
                builder.AppendLine();

                #endregion

                #region Refer Textures

                var texIndex = 0;
                foreach (var texture in target.Elements("texture"))
                {
                    builder.AppendLine($"texCompIdx{texIndex} = texEditor{index}.ComponentIndex(name=\"{texture.Attribute("tex-name").Value}\", clsIDname=\"Texture2D\")");
                    builder.AppendLine($"sourceTex{texIndex} = texParser{index}.Cabinet.Components[texCompIdx{texIndex}]");
                    builder.AppendLine($"meshAnimEditor{index}.AddTextureToEditor(sourceTex{texIndex})");
                    texIndex++;
                }

                builder.AppendLine($"texAnimator{index}.InitLists()");
                texIndex = 0;
                foreach (var texture in target.Elements("texture"))
                {
                    builder.AppendLine(
                        $"meshAnimEditor{index}.SetMaterialTexture(id=copyMatIndex{index}, index={texture.Attribute("mat-slot").Value}, editor=texEditor{index}, texIndex=texAnimator{index}.GetTextureId(\"{texture.Attribute("tex-name").Value}\"))");
                    texIndex++;
                }

                builder.AppendLine();

                #endregion

                #region Assign Material Values

                foreach (var matvalue in target.Elements("matvalue"))
                {
                    var key = matvalue.Attribute("key");
                    var value = matvalue.Attribute("value");

                    if (key != null && value != null)
                        builder.AppendLine($"meshAnimEditor{index}.SetMaterialValue(id=copyMatIndex{index}, name=\"{key.Value}\", value={value.Value})");
                }

                #endregion

                if (!uniqueBundles.ContainsKey(meshPath)) uniqueBundles.Add(meshPath, index);
                index++;
            }

            #endregion

            #region Save Changed AssetBundles

            foreach (var kv in uniqueBundles)
            {
                var bundleIndex = kv.Value;
                builder.AppendLine(
                    $"meshEditor{bundleIndex}.SaveUnity3d(keepBackup = False, backupExtension = \".unit-y3d\", background = False, clearMainAsset = True, pathIDsMode = -1)");
            }

            #endregion

            return builder.ToString();
        }

        public void Execute()
        {
            File.WriteAllText(tempPath, Generate());

            var p = new Process();
            p.StartInfo.UseShellExecute = false;
            p.StartInfo.FileName = execPath;
            p.StartInfo.Arguments = tempPath;
            p.Start();
            p.WaitForExit();
        }
    }
}

#endif