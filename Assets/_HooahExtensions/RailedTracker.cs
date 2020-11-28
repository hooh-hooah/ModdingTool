using UnityEngine;

public class RailedTracker : MonoBehaviour
{
    public Transform start;
    public Transform mid;
    public Transform end;
    public Transform target;
    public Transform tracker;
    public float overflowLimit = 0.2f;
    public float overflowDrag = 11f;
    public float dragLerp = 0.3f;

    private readonly Vector3[] positions = new Vector3[3];
    private readonly Vector3[] localPositions = new Vector3[3];
    private float _factor;
    private Vector3 _targetNormal;
    private Vector3 _targetPosition;

    private void LateUpdate()
    {
        positions[0] = start.position;
        positions[1] = mid.position;
        positions[2] = end.position;
        localPositions[0] = start.localPosition;
        localPositions[1] = mid.localPosition;
        localPositions[2] = end.localPosition;
        _factor = CalculateFactor();
        _targetPosition = GetPointAtTime(_factor);
        target.position = Vector3.Lerp(target.position, _targetPosition, dragLerp);
        _targetNormal = GetDerivative(_factor);
        if (Vector3.SqrMagnitude(_targetNormal) < 0.01) return;
        target.rotation = Quaternion.LookRotation(_targetNormal, target.up);
    }

    // 0.0 >= t <= 1.0 In here be dragons and magic
    private Vector3 GetPointAtTime(float t)
    {
        t = Mathf.Max(t, 0);
        t = Mathf.Min(t, 1);
        var u = 1f - t;
        var tt = t * t;
        var uu = u * u;
        var p = uu * positions[0]; //first term
        p += 2 * u * t * positions[1]; //second term
        p += tt * positions[2]; //third term
        return p;
    }

    private Vector3 GetDerivative(float t)
    {
        return 2 * (1 - t) * (positions[1] - positions[0]) + 2 * t * (positions[2] - positions[1]);
    }

    private float CalculateFactor()
    {
        // bruh
        var factor = (Mathf.Abs(localPositions[0].x) - tracker.localPosition.x) / (Mathf.Abs(localPositions[2].x) + Mathf.Abs(localPositions[2].x));
        return Mathf.Max(0, Mathf.Min(1, factor));
    }

    private void ChaseTracker(Transform target)
    {
    }
}