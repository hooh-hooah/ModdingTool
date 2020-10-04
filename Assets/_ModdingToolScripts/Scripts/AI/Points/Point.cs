using UnityEngine;

// ReSharper disable NotAccessedField.Local
// ReSharper disable InconsistentNaming
#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649
namespace AIProject
{
    public abstract class Point : MonoBehaviour
    {
        [SerializeField] private MapArea _ownerArea;
        [SerializeField] private MapArea.AreaType _areaType;
    }
}