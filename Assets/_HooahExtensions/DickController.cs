using System;
using System.Collections;
using System.Linq;
using HooahComponents;
using UniRx;
using Unity.Collections;
using Unity.Jobs;
using UnityEngine;
using UnityEngine.Jobs;
using UnityEngine.Serialization;
using Random = System.Random;

namespace HooahComponents
{
    [Serializable]
    public class VertexShapeGraph
    {
        public string key;
        public AnimationCurve curve;
        public int index;
    }
}

public class DickController : MonoBehaviour, ISerializationCallbackReceiver
{
    private const float UPDATE_INTERPOLATION_RATE = 0.98f;
    private static readonly Quaternion RotationA = Quaternion.Euler(90, 0, 0) * Quaternion.Euler(0, 90, 0);

    [Header("Audio References")] public AudioClip[] pewSounds;
    public AudioSource audioPlayer;
    [Header("GameObject References")] public GameObject curveEnd;
    public GameObject curveMiddle;
    public GameObject curveStart;

    public GameObject[] dickChains;

    // TODO: make dickmesh more modular..
    public SkinnedMeshRenderer dickMesh;
    public Transform pullProxy;
    public Transform pullProxyRoot;

    [Header("Navigation Control")] public float dockDistance = 2.1f;
    [FormerlySerializedAs("steepness")] public float pullLength = 1f;

    [FormerlySerializedAs("followClosestNavigator")]
    public bool useNearestNavigator;

    public bool useNearestProxy;

    [Header("Shape Animation")]
    // Fuck you unity
    public string[] _dataKey;

    public AnimationCurve[] _dataCurve;
    public int[] _dataIndex;

    // Drivate stuffs
    private readonly Random _random = new Random();
    private Animator _animator;
    private bool _canMorph;
    private DickNavigator _dickNavigator;
    private Transform[] _dickTransforms;
    private ApproachTarget[] _dickTransformTarget;
    private NativeArray<ApproachTarget> _dickTransformTargetNative;
    private Vector3 _endPos;
    private NativeArray<float> _factor;
    private float _firstDistance;
    private Vector3 _midPos;
    private Vector3 _startPos;
    private JobHandle _moveHandle;
    private JobHandle _pullHandle;
    private Transform _pullTransform;
    private float _renderPullFactor;
    private VertexShapeGraph[] _shapeGraphs;
    private TransformAccessArray _transformAccessArray;
    private bool _disposed;
    private ApplyTransformJob _applyTransformJob;
    private DickPositionCalcuationJob _jobPosCalc;
    private DickPullCalculationJob _jobCalcPull;
    private TransformAccessArray _transformParentArray;

    private void Start()
    {
        // Reference animator for sound pitch control
        _animator = GetComponent<Animator>();

        // Initialize Unity Jobs
        _applyTransformJob = new ApplyTransformJob();
        _jobPosCalc = new DickPositionCalcuationJob();
        _jobCalcPull = new DickPullCalculationJob();

        // Register shape keys to make pull proxy works
        if (_shapeGraphs == null) return;
        foreach (var i in Enumerable.Range(0, dickMesh.sharedMesh.blendShapeCount))
        {
            var blendShapeName = dickMesh.sharedMesh.GetBlendShapeName(i);
            if (blendShapeName == null || blendShapeName.Length <= 0) continue;
            var data = _shapeGraphs.FirstOrDefault(x => x.key == blendShapeName);
            if (data == null) continue;
            data.index = i;
        }
    }

    public void FixedUpdate()
    {
        if (ReferenceEquals(curveEnd, null) || ReferenceEquals(curveMiddle, null) || ReferenceEquals(curveStart, null)) return;
        UpdateNavigatorPosition();

        var benisScale = transform.localScale.z;
        PullFactorCalculation(benisScale);
        NavigationCalculation(benisScale);
    }

    private void LateUpdate()
    {
        _applyTransformJob.Targets = _dickTransformTargetNative;
        _applyTransformJob.LerpFactor = UPDATE_INTERPOLATION_RATE;
        var applyTransformJobHandle = _applyTransformJob.Schedule(_transformAccessArray);
        applyTransformJobHandle.Complete();

        _renderPullFactor = Mathf.Lerp(_renderPullFactor, _factor[0], UPDATE_INTERPOLATION_RATE);
        if (_shapeGraphs == null) return;
        foreach (var vertexShapeGraph in _shapeGraphs) dickMesh.SetBlendShapeWeight(vertexShapeGraph.index, vertexShapeGraph.curve.Evaluate(_renderPullFactor) * 100);
    }


    private void OnEnable()
    {
        _startPos = curveStart != null ? curveStart.transform.position : Vector3.zero;
        _endPos = curveEnd != null ? curveEnd.transform.position : Vector3.zero;
        _midPos = curveMiddle != null ? curveMiddle.transform.position : Vector3.zero;
        _firstDistance = Vector3.Distance(_startPos, _midPos) + Vector3.Distance(_midPos, _endPos);

        MainThreadDispatcher.StartFixedUpdateMicroCoroutine(UpdateProxyInformation());

        var chainTransforms = dickChains.Select(o => o.transform).ToArray();
        _transformAccessArray = new TransformAccessArray(chainTransforms, chainTransforms.Length);
        _transformParentArray = new TransformAccessArray(chainTransforms.Select(o => o.parent).ToArray(), chainTransforms.Length);
        _dickTransformTargetNative = new NativeArray<ApproachTarget>(dickChains.Length, Allocator.Persistent);
        _factor = new NativeArray<float>(1, Allocator.Persistent) {[0] = 0f};

        _disposed = false;
    }

    private void DisposeNativeJobAndArray()
    {
        if (_disposed) return;
        _moveHandle.Complete();
        _pullHandle.Complete();
        _dickTransformTargetNative.Dispose();
        _factor.Dispose();
        _transformAccessArray.Dispose();
        _disposed = true;
    }

    private void OnDisable() => DisposeNativeJobAndArray();

    private void OnDestroy() => DisposeNativeJobAndArray();

#if UNITY_EDITOR
    private void EditorDrawDickChains()
    {
        if (dickChains == null) return;
        foreach (var dickChain in dickChains)
        {
            var t = dickChain.transform;
            var p = t.position;
            Gizmos.color = Color.yellow;
            Gizmos.DrawSphere(p, .1f);
            Gizmos.color = Color.blue;
            Gizmos.DrawLine(p, p + t.forward * 1);
            Gizmos.color = Color.green;
            Gizmos.DrawLine(p, p + t.up * 1);
            Gizmos.color = Color.red;
            Gizmos.DrawLine(p, p + t.right * 1);
        }
    }

    private void EditorDrawProxy()
    {
        if (pullProxyRoot == null) return;
        var t = pullProxyRoot;
        var p = t.position;
        Gizmos.color = Color.cyan;
        Gizmos.DrawSphere(p, .1f);
        Gizmos.color = Color.blue;
        Gizmos.DrawLine(p, p + t.forward * 1);
        Gizmos.color = Color.green;
        Gizmos.DrawLine(p, p + t.up * 1);
        Gizmos.color = Color.red;
        Gizmos.DrawLine(p, p + t.right * 1);
    }

    private void OnDrawGizmos()
    {
        EditorDrawDickChains();
        EditorDrawProxy();
    }
#endif

    public void OnBeforeSerialize()
    {
        if (_shapeGraphs == null || _shapeGraphs.Length == 0) return;
        for (var i = _shapeGraphs.Length - 1; i >= 0; i--)
        {
            var structData = _shapeGraphs[i];
            if (structData == null) continue;
            _dataIndex[i] = structData.index;
        }
    }

    public void OnAfterDeserialize()
    {
        if (_dataCurve == null || _dataKey == null || _dataIndex == null ||
            _dataCurve.Length == 0 || _dataKey.Length == 0 || _dataIndex.Length == 0 ||
            _dataCurve.Length != _dataKey.Length || _dataCurve.Length != _dataIndex.Length ||
            _dataKey.Length != _dataIndex.Length
        ) return;

        _shapeGraphs = new VertexShapeGraph[_dataCurve.Length];
        for (var i = _shapeGraphs.Length - 1; i >= 0; i--)
        {
            if (_dataIndex[i] < 0 || _dataKey[i] == null || _dataCurve[i] == null) continue;
            _shapeGraphs[i] = new VertexShapeGraph {key = _dataKey[i], curve = _dataCurve[i], index = _dataIndex[i]};
        }
    }

    private void PullFactorCalculation(float benisScale)
    {
        var pullProxyTransform = _pullTransform ? _pullTransform : pullProxy;
        if (ReferenceEquals(pullProxyTransform, null)) return;
        _jobCalcPull.Root = pullProxy.position;
        _jobCalcPull.Target = pullProxyTransform.position;
        _jobCalcPull.Factor = _factor;
        _jobCalcPull.PullLength = pullLength;
        _jobCalcPull.BenisScale = benisScale;
        _jobCalcPull.Up = pullProxyRoot.up;
        _pullHandle = _jobCalcPull.Schedule();
        _pullHandle.Complete();
    }

    private void NavigationCalculation(float benisScale)
    {
        _jobPosCalc.DickTransformTarget = _dickTransformTargetNative;
        _jobPosCalc.Start = curveStart.transform.position;
        _jobPosCalc.End = _endPos;
        _jobPosCalc.Middle = _midPos;
        _jobPosCalc.Right = transform.right;
        _jobPosCalc.BenisScale = benisScale;
        _jobPosCalc.ChainsLength = _dickTransformTargetNative.Length - 1;
        _jobPosCalc.FirstDistance = _firstDistance * benisScale;
        _moveHandle = _jobPosCalc.Schedule(_dickTransformTargetNative.Length, 5);
        _moveHandle.Complete();
    }


    private void AssignNearestDickNavigator()
    {
        if (!useNearestNavigator || DickNavigator.Instances.Count <= 0) return;
        _dickNavigator = DickNavigator.Instances
            .OrderBy(x => (x.dickMidPoint.position - _startPos).sqrMagnitude)
            .FirstOrDefault();
    }

    private void AssignNearestPullProxy()
    {
        if (!useNearestProxy) return;
        if (DickPuller.Instances.Count > 0)
            _pullTransform = DickPuller.Instances
                .OrderBy(x => (x.transform.position - pullProxyRoot.transform.position).sqrMagnitude)
                .First().gameObject.transform;
        else
            _pullTransform = pullProxy;
    }

    // TODO: Move this to the manager or background cycle.
    private IEnumerator UpdateProxyInformation()
    {
        while (true)
        {
            if (this == null || !isActiveAndEnabled) yield break;
            AssignNearestDickNavigator();
            AssignNearestPullProxy();
            yield return null;
        }
    }

    private void UpdateNavigatorPosition()
    {
        try
        {
            if (ReferenceEquals(null, _dickNavigator)) return;
            var benisScale = transform.localScale.z;
            _startPos = curveStart.transform.position;
            var position = _dickNavigator.dickMidPoint.position;
            var distFactor = Vector3.Distance(position, _startPos) / (dockDistance * 1.25f * benisScale);
            var lerpFactor = 1f - Mathf.Clamp(distFactor - 1f, 0f, 1f);
            var up = curveStart.transform.up;

            _midPos = Vector3.Lerp(_startPos + up * (1f * benisScale), position, lerpFactor);
            _endPos = Vector3.Lerp(_startPos + up * (2f * benisScale), _dickNavigator.dickEndPoint.position, lerpFactor);
        }
        catch (MissingReferenceException)
        {
            _dickNavigator = null;
        }
    }

    public void PlayPew()
    {
        if (!pewSounds.Any() || audioPlayer == null) return;
        audioPlayer.Stop();
        var randomIndex = _random.Next(0, pewSounds.Length - 1);
        audioPlayer.pitch = (_animator != null ? _animator.speed : 1f) + Convert.ToSingle(_random.NextDouble() * 0.4);
        audioPlayer.PlayOneShot(pewSounds[randomIndex]);
        EventConsumer.EmitEvent(EventConsumer.EventType.Nomi);
    }

    private static Vector3 Linear(Vector3 p0, Vector3 p1, Vector3 p2, float mp, float t) =>
        t <= mp ? Vector3.Lerp(p0, p1, t * (1 / mp)) : Vector3.Lerp(p1, p2, (t - mp * 1f) / (1f - mp));

    public struct ApproachTarget
    {
        public Vector3 Position;
        public Quaternion Rotation;
    }

    private struct ApplyTransformJob : IJobParallelForTransform
    {
        [ReadOnly] public NativeArray<ApproachTarget> Targets;
        [ReadOnly] public float LerpFactor;

        public void Execute(int i, TransformAccess transform)
        {
            transform.position = Vector3.Lerp(transform.position, Targets[i].Position, LerpFactor);
            if (i == 0) return;
            transform.rotation = Quaternion.Lerp(transform.rotation, Targets[i].Rotation, LerpFactor);
        }
    }

    private struct DickPositionCalcuationJob : IJobParallelFor
    {
        public NativeArray<ApproachTarget> DickTransformTarget;
        [ReadOnly] public Vector3 Start;
        [ReadOnly] public Vector3 End;
        [ReadOnly] public Vector3 Middle;
        [ReadOnly] public Vector3 Right;
        [ReadOnly] public float ChainsLength;
        [ReadOnly] public float FirstDistance;
        [ReadOnly] public float BenisScale;

        public void Execute(int index)
        {
            if (ChainsLength == 0) return; // no divide by zero
            var rodLength = Vector3.Distance(Start, Middle) + Vector3.Distance(Middle, End);
            if (rodLength == 0) return; // no divide by zero
            var chainLength = FirstDistance / rodLength / ChainsLength;
            var approachTarget = DickTransformTarget[index];
            var benisMiddlePoint = Vector3.Distance(Start, Middle) / rodLength;
            approachTarget.Position = Linear(Start, Middle, End, benisMiddlePoint, index * chainLength * BenisScale);
            DickTransformTarget[index] = approachTarget;

            if (index == 0) return;
            var target = DickTransformTarget[index - 1];
            var previousTarget = target;
            var dir = (approachTarget.Position - previousTarget.Position).normalized;
            if (dir == Vector3.zero) return;

            var q = Quaternion.LookRotation(dir, Right);
            q *= RotationA;
            target.Rotation = q;
            DickTransformTarget[index - 1] = target;
        }
    }

    private struct DickPullCalculationJob : IJob
    {
        [ReadOnly] public Vector3 Root;
        [ReadOnly] public Vector3 Target;
        public NativeArray<float> Factor;
        [ReadOnly] public float PullLength;
        [ReadOnly] public float BenisScale;
        [ReadOnly] public Vector3 Up;

        public void Execute()
        {
            var distance = Vector3.Distance(Root, Target);
            var crossDot = Vector3.Dot((Root - Target).normalized, Up); // 1 to -1, 0 is exact match.
            Factor[0] = (distance * crossDot / PullLength * BenisScale + 1) / 2;
        }
    }
}
