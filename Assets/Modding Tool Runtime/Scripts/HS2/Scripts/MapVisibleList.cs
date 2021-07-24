using System.Collections.Generic;
using UnityEngine;

#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649
namespace Map
{
    public class MapVisibleList : MonoBehaviour
    {
        [SerializeField] private List<GameObject> _list = new List<GameObject>();

        [SerializeField] private int offButton;

        [SerializeField] private int onButton;

        public List<GameObject> list => _list;
    }
}