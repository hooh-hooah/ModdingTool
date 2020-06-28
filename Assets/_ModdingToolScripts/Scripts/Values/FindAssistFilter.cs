using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine;

// I really need to keep all collection filter process in one place.
public class FindAssistFilter
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
    
    private static readonly Regex _skirtRegex = new Regex(@"(.*_s)");
    private static readonly Dictionary<Cloth, Regex> regexCollection = new Dictionary<Cloth, Regex>
    {
        {Cloth.Top, new Regex(@"([A-z]_top_a|top_[0-9]+_a)|[A-z]_top_[A-z0-9]+_a")},
        {Cloth.TopHalf, new Regex(@"([A-z]_top_b|top_[0-9]+_b)|[A-z]_top_[A-z0-9]+_b")},
        {Cloth.Bot, new Regex(@"([A-z]_bot_a|bot_[0-9]+_a)|[A-z]_bot_[A-z0-9]+_a]")},
        {Cloth.BotHalf, new Regex(@"([A-z]_bot_b|bot_[0-9]+_b)|[A-z]_bot_[A-z0-9]+_b")}
    };

    public static bool IsAccessoryBone()
    {
        return true;
    }

    public static bool IsHairBone()
    {
        return true;
    }

    public static GameObject[] GetSkirtBones(FindAssist assist)
    {
        return (from kv in assist.dictObjName
            where _skirtRegex.IsMatch(kv.Key)
            select kv.Value).ToArray();
    }

    public static bool IsBaseTransform()
    {
        return true;
    }

    public static GameObject GetClothPart(Cloth part, FindAssist assist)
    {
        // TODO: Yes, it runs regex 4 times. I know that.
        // I will fix this shit later so don't bully me.

        if (regexCollection.TryGetValue(part, out var regex))
        {
            var g = from kv in assist.dictObjName
                where regex.IsMatch(kv.Key)
                select kv.Value;
            return g.Any() ? g.Single() : null;
        }

        return null;
    }

    public static GameObject[] GetClothParts(Cloth part, FindAssist assist)
    {
        var names = assist.dictObjName;
        GameObject[] output = { };
        // TODO: Initialize regex operators.
        switch (part)
        {
            case Cloth.FirstAccessory:
                output = (from x in assist.dictObjName where x.Key.StartsWith("op1") select x.Value).ToArray();
                break;
            case Cloth.SecondAccessory:
                output = (from x in assist.dictObjName where x.Key.StartsWith("op2") select x.Value).ToArray();
                break;
        }

        return output;
    }
}