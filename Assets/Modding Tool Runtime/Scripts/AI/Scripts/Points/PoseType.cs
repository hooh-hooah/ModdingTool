using System;


// ReSharper disable NotAccessedField.Local
// ReSharper disable InconsistentNaming
#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649
namespace AIProject
{
    [Flags]
    public enum PoseType
    {
        Stand = 1, Floor = 2, Sit = 4, Recline = 8, PairF2F = 16,
        PairSxS = 32
    }
}