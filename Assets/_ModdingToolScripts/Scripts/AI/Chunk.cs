using UnityEngine;

// ReSharper disable NotAccessedField.Local
// ReSharper disable InconsistentNaming
#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649
namespace AIProject
{
    public class Chunk : MonoBehaviour
    {
        [SerializeField] private int _id;

        [SerializeField] private Chunk[] _connectedChunks;

        [SerializeField] [Space(8f)] private MapArea[] _mapAreas;

        // BEHAVIORS
        // Awake:
        // ↳ assigns self to chunktable. 
        // ↳ get all maparea components and assign map areas automatically.
        // (Coroutine) Load:
        // ↳ Assign all points from the map area informations
        // LoadAppendActionPoints
        // ↳ appends the points. idk atm
    }
}