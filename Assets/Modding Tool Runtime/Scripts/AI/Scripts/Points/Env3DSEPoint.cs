using UnityEngine;

// ReSharper disable NotAccessedField.Local
// ReSharper disable InconsistentNaming
#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649
namespace AIProject
{
    public class Env3DSEPoint : Point
    {
        [SerializeField] private string _summary = string.Empty;
        [SerializeField] private int _clipID = -1;
        [SerializeField] private Transform _playRoot;
        [SerializeField] private bool _playOnAwake;
        [SerializeField] private Vector2 _decay;
        [SerializeField] private bool _isLoop = true;
        [SerializeField] private Vector2 _interval;
        [SerializeField] private bool _setFirstFadeTime;
        [SerializeField] private float _firstFadeTime;
    }
}