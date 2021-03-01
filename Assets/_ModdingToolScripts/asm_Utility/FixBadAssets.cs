#if UNITY_EDITOR
using System;
using System.IO;
using System.Linq;
using UnityEditor;
using UnityEngine;
using static System.String;

public static class FixBadAsset
{
    //https://stackoverflow.com/questions/28647002/find-most-accurate-match-in-strings
    public static int LevenshteinDistance(string source, string target)
    {
        if (IsNullOrEmpty(source))
        {
            return IsNullOrEmpty(target) ? 0 : target.Length;
        }

        if (IsNullOrEmpty(target)) return source.Length;

        if (source.Length > target.Length)
        {
            var temp = target;
            target = source;
            source = temp;
        }

        var m = target.Length;
        var n = source.Length;
        var distance = new int[2, m + 1];
        // Initialize the distance 'matrix'
        for (var j = 1; j <= m; j++) distance[0, j] = j;

        var currentRow = 0;
        for (var i = 1; i <= n; ++i)
        {
            currentRow = i & 1;
            distance[currentRow, 0] = i;
            var previousRow = currentRow ^ 1;
            for (var j = 1; j <= m; j++)
            {
                var cost = (target[j - 1] == source[i - 1] ? 0 : 1);
                distance[currentRow, j] = Math.Min(Math.Min(
                        distance[previousRow, j] + 1,
                        distance[currentRow, j - 1] + 1),
                    distance[previousRow, j - 1] + cost);
            }
        }

        return distance[currentRow, m];
    }

    [MenuItem("Assets/Unity Macros/Fix Mesh Filters")]
    public static void CompileScenarioDataCollection()
    {
        foreach (var gameObject in Selection.objects.Cast<GameObject>())
        {
            foreach (var meshFilter in new[]
            {
                gameObject.GetComponents<MeshFilter>().ToArray(),
                gameObject.GetComponentsInChildren<MeshFilter>().ToArray()
            }.SelectMany(x=>x))
            {
                try
                {
                    var name = meshFilter.gameObject.name;
                    var assetPath = (AssetDatabase.FindAssets($"t:Mesh {name}")
                        .Select(AssetDatabase.GUIDToAssetPath)
                        .Select(path => (path, distance: LevenshteinDistance(name, Path.GetFileNameWithoutExtension(path))))
                        .OrderBy(tuple => tuple.distance)
                        .FirstOrDefault()).path;
                    meshFilter.mesh = AssetDatabase.LoadAssetAtPath<Mesh>(assetPath);
                }
                catch
                {
                    // ignored
                }
            }
        }
    }
}
#endif