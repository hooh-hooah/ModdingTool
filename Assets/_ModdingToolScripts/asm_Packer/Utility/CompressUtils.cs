using System;
using System.Collections.Generic;
using System.IO;
using ICSharpCode.SharpZipLib.Core;
using ICSharpCode.SharpZipLib.Zip;
using ICSharpCode.SharpZipLib.Zip.Compression;
using UnityEngine;

namespace hooh_ModdingTool.asm_Packer.Utility
{
    public static class CompressUtils
    {
        private const int BLOCK_SIZE = 8192;


        private static readonly HashSet<string> compressTargets = new HashSet<string>
        {
            ".unity3d"
        };

        // TODO: add mod compression options
        // Mode 1: Sanic Mode
        // Mode 2: Distribution Mode
        // Mode 3: I don't want to use mod Mode
        public static void CreateFromDirectory(string from, string to)
        {
            try
            {
                using (var fileStream = File.Create(to))
                using (var zipStream = new ZipOutputStream(fileStream))
                {
                    zipStream.SetLevel(Deflater.NO_COMPRESSION);
                    zipStream.UseZip64 = UseZip64.On;

                    var folderOffset = from.Length + (from.EndsWith("\\") ? 0 : 1);
                    CompressFolder(from, zipStream, folderOffset);
                }
            }
            catch (Exception)
            {
                Debug.LogError($"An Error Occured wile Compressing {Path.GetFileName(to)}. Check if the game is still running or other program is opening it.");
            }
        }

        // Recursively compresses a folder structure
        private static void CompressFolder(string path, ZipOutputStream zipStream, int folderOffset)
        {
            var files = Directory.GetFiles(path);

            foreach (var filename in files)
            {
                var fi = new FileInfo(filename);

                // Make the name in zip based on the folder
                var entryName = filename.Substring(folderOffset);

                // Remove drive from name and fix slash direction
                entryName = ZipEntry.CleanName(entryName);
                var newEntry = new ZipEntry(entryName)
                {
                    DateTime = DateTime.Now, // It is important to keep WHEN the mod is built
                    Size = fi.Length
                };

                if (fi.Length > BLOCK_SIZE || compressTargets.Contains(Path.GetExtension(filename)))
                    newEntry.CompressionMethod = CompressionMethod.Stored;

                zipStream.PutNextEntry(newEntry);

                var buffer = new byte[BLOCK_SIZE];
                using (var fsInput = File.OpenRead(filename))
                {
                    StreamUtils.Copy(fsInput, zipStream, buffer);
                }

                zipStream.CloseEntry();
            }

            var folders = Directory.GetDirectories(path);
            foreach (var folder in folders) CompressFolder(folder, zipStream, folderOffset);
        }
    }
}