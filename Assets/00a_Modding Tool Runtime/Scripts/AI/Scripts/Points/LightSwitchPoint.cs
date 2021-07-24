using UnityEngine;


// ReSharper disable NotAccessedField.Local
// ReSharper disable InconsistentNaming
#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649
namespace AIProject
{
    public class LightSwitchPoint : Point
    {
        [SerializeField] private int _id = -1;
        [SerializeField] private bool _linkMapObject;
        [SerializeField] private int _linkID;
        [SerializeField] private GameObject[] _onModeObjects;
        [SerializeField] private GameObject[] _offModeObjects;
        [SerializeField] private bool _firstLightEnable;
        [SerializeField] private bool _useEnv3D;
        [SerializeField] private Env3DSEPoint _env3DSEPoint;
        [SerializeField] private bool _lightEnablePlaySE = true;
        [SerializeField] private Transform _commandBasePoint;
        [SerializeField] private Transform _labelPoint;
        [SerializeField] private float _rangeRadius;
        [SerializeField] private float _height;
        [SerializeField] private CommandType _commandType;
        private bool _lightEnable;
    }
}