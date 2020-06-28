#if UNITY_EDITOR
using System.Text.RegularExpressions;
using UnityEditor;

internal class UnityMacros
{
    public static void AddPrefixOnName(string prefix)
    {
        var selections = Selection.gameObjects;
        foreach (var gameObject in selections) gameObject.name = prefix + gameObject.name;
    }

    public static void AddPostfixOnName(string postfix)
    {
        var selections = Selection.gameObjects;
        foreach (var gameObject in selections) gameObject.name = postfix + gameObject.name;
    }

    public static void ReplaceTextOfName(string search, string to)
    {
        var selections = Selection.gameObjects;
        foreach (var gameObject in selections) gameObject.name = gameObject.name.Replace(search, to);
    }

    public static void ReplaceTextOnName(Regex searchRegex, string to)
    {
    }

    public static void WrapObject()
    {
    }

    public static void WrapObjectWithScale()
    {
    }
}
#endif