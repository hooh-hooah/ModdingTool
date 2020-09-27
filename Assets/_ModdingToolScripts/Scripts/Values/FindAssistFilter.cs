#if UNITY_EDITOR
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using UnityEngine;

// I really need to keep all collection filter process in one place.
public static class FindAssistFilter
{
    public enum Cloth
    {
        Top = 0,
        Bot = 1,
        TopHalf = 2,
        BotHalf = 3,
        FirstAccessory = 4,
        SecondAccessory = 5
    }

    private static readonly Regex SkirtRegex = new Regex(@"(cf_J_Legsk_[0-9]+_00)"); // select only root

    private static readonly Dictionary<Cloth, Regex> RegexCollection = new Dictionary<Cloth, Regex>
    {
        {Cloth.Top, new Regex(@"([A-z]_top_a|top_[0-9]+_a)|[A-z]_top_[A-z0-9]+_a|^top_a$")},
        {Cloth.TopHalf, new Regex(@"([A-z]_top_b|top_[0-9]+_b)|[A-z]_top_[A-z0-9]+_b|^top_b$")},
        {Cloth.Bot, new Regex(@"([A-z]_bot_a|bot_[0-9]+_a)|[A-z]_bot_[A-z0-9]+_a]|^bot_a$")},
        {Cloth.BotHalf, new Regex(@"([A-z]_bot_b|bot_[0-9]+_b)|[A-z]_bot_[A-z0-9]+_b|^bot_b$")}
    };

    public static bool IsAccessoryBone()
    {
        return true;
    }

    public static bool IsHairBone()
    {
        return true;
    }

    public static bool IsSkirtBone(string name)
    {
        return SkirtRegex.IsMatch(name);
    }

    public static GameObject[] GetSkirtBones(this FindAssist assist)
    {
        return (from kv in assist.DictObjName
            where IsSkirtBone(kv.Key)
            select kv.Value).ToArray();
    }

    public static bool IsBaseTransform()
    {
        return true;
    }

    public static GameObject GetClothPart(this FindAssist assist, Cloth part)
    {
        if (!RegexCollection.TryGetValue(part, out var regex)) return null;
        var gameObjects = from kv in assist.DictObjName
            where regex.IsMatch(kv.Key)
            select kv.Value;

        var enumerable = gameObjects as GameObject[] ?? gameObjects.ToArray();
        return enumerable.Any() ? enumerable.Single() : null;
    }

    public static GameObject[] GetClothParts(this FindAssist assist, Cloth part)
    {
        var names = assist.DictObjName;
        GameObject[] output = { };
        // TODO: Initialize regex operators.
        switch (part)
        {
            case Cloth.FirstAccessory:
                output = (from x in assist.DictObjName where x.Key.StartsWith("op1") select x.Value).ToArray();
                break;
            case Cloth.SecondAccessory:
                output = (from x in assist.DictObjName where x.Key.StartsWith("op2") select x.Value).ToArray();
                break;
            case Cloth.Top:
                break;
            case Cloth.Bot:
                break;
            case Cloth.TopHalf:
                break;
            case Cloth.BotHalf:
                break;
            default:
                throw new ArgumentOutOfRangeException(nameof(part), part, null);
        }

        return output;
    }

    public static Renderer[][] GetRendererParts(this FindAssist assist, int partIndexes = 3)
    {
        var result = new List<Renderer>[partIndexes];
        for (var i = partIndexes - 1; i >= 0; i--) result[i] = new List<Renderer>();

        var regex = new Regex(".*(group|color|col|grp|part)_(0*[0-9]).*");
        foreach (var skinnedMeshRenderer in assist.SkinnedMeshRenderers.Values)
        {
            var groups = regex.Match(skinnedMeshRenderer.name).Groups;
            if (int.TryParse(groups[groups.Count - 1].Value, out var rendererSlot))
                if (rendererSlot > 1 && rendererSlot <= partIndexes)
                {
                    result[rendererSlot - 1].Add(skinnedMeshRenderer);
                    continue;
                }

            result[0].Add(skinnedMeshRenderer);
        }

        return result.Select(x => x.ToArray()).ToArray();
    }
}
#endif