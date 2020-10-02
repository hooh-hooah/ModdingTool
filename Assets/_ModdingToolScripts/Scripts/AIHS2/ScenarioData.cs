using System;
using System.Collections.Generic;
using UnityEngine;

#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649

namespace ADV
{
    [CreateAssetMenu(fileName = "0", menuName = "AIHS2 Common/Create Scenario Data", order = 1)]
    public class ScenarioData : ScriptableObject
    {
        [SerializeField] public List<Param> list = new List<Param>();

        [Serializable]
        public class Param
        {
            [SerializeField] public int _hash;
            [SerializeField] public int _version;
            [SerializeField] public bool _multi;
            [SerializeField] public Command _command;
            [SerializeField] public string[] _args;
        }
    }
}