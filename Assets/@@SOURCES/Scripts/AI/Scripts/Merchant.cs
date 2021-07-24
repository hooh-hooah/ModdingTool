using System;

// ReSharper disable NotAccessedField.Local
// ReSharper disable InconsistentNaming
#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649
namespace AIProject.Definitions
{
    public static class Merchant
    {
        public enum ActionType
        {
            ToAbsent, Absent, ToWait, Wait, ToSearch,
            Search, TalkWithPlayer, TalkWithAgent, HWithPlayer, HWithAgent,
            Encounter, Idle, GotoLesbianSpotFollow
        }

        [Flags]
        public enum EventType { Wait = 1, Search = 2 }

        public enum StateType
        {
            Absent, Wait, Search, TalkWithPlayer, TalkWithAgent,
            HWithPlayer, HWithAgent, Encounter, Idle, GotoLesbianSpotFollow
        }
    }
}