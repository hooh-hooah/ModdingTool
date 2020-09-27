using System.Collections.Generic;
using UnityEngine;

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