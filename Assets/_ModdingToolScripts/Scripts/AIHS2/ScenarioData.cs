using System;
using System.Collections.Generic;
using UnityEngine;

namespace ADV
{
    // Token: 0x02000441 RID: 1089
    public class ScenarioData : ScriptableObject
    {
        // Token: 0x04002618 RID: 9752
        [SerializeField] public List<Param> list = new List<Param>();

        // Token: 0x02000E46 RID: 3654
        [Serializable]
        public class Param
        {
            // Token: 0x04005470 RID: 21616
            [SerializeField] public int _hash;

            // Token: 0x04005471 RID: 21617
            [SerializeField] public int _version;

            // Token: 0x04005472 RID: 21618
            [SerializeField] public bool _multi;

            // Token: 0x04005473 RID: 21619
            [SerializeField] public Command _command;

            // Token: 0x04005474 RID: 21620
            [SerializeField] public string[] _args;
        }
    }
}