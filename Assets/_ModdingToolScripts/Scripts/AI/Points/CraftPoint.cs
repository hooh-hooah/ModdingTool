using UnityEngine;


// ReSharper disable NotAccessedField.Local
// ReSharper disable InconsistentNaming
#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649
namespace AIProject
{
    public class CraftPoint : Point
    {
        public enum CraftKind
        {
            Medicine,
            Pet,
            Recycling
        }

        [SerializeField] private CraftKind _kind;
        [SerializeField] private int _id;
        [SerializeField] private bool _enabledRangeCheck = true;
        [SerializeField] private float _radius = 1f;
        [SerializeField] private Transform _commandBasePoint;
    }
}