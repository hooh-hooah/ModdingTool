#if UNITY_EDITOR
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
        foreach (var gameObject in selections) gameObject.name = gameObject.name + postfix;
    }

    public static void ReplaceTextOfName(string search, string to)
    {
        var selections = Selection.gameObjects;
        foreach (var gameObject in selections) gameObject.name = gameObject.name.Replace(search, to);
    }

    public static void SetName(string name)
    {
        var selections = Selection.gameObjects;
        foreach (var gameObject in selections) gameObject.name = name;
    }

    public static void SetNameSequence(string name)
    {
        var selections = Selection.gameObjects;
        var index = 0;
        foreach (var gameObject in selections)
        {
            gameObject.name = name + index;
            index++;
        }
    }

    public static void WrapObjectWithScale()
    {
    }
}
#endif