using UnityEngine;

[AddComponentMenu("Dynamic Bone/Dynamic Bone Plane Collider")]
public class DynamicBonePlaneCollider : DynamicBoneColliderBase
{
    private void OnDrawGizmosSelected()
    {
        if (!enabled)
            return;

        if (m_Bound == Bound.Outside)
            Gizmos.color = Color.yellow;
        else
            Gizmos.color = Color.magenta;

        var normal = Vector3.up;
        switch (m_Direction)
        {
            case Direction.X:
                normal = transform.right;
                break;
            case Direction.Y:
                normal = transform.up;
                break;
            case Direction.Z:
                normal = transform.forward;
                break;
        }

        var p = transform.TransformPoint(m_Center);
        Gizmos.DrawLine(p, p + normal);
    }

    private void OnValidate()
    {
    }

    public override void Collide(ref Vector3 particlePosition, float particleRadius)
    {
        var normal = Vector3.up;
        switch (m_Direction)
        {
            case Direction.X:
                normal = transform.right;
                break;
            case Direction.Y:
                normal = transform.up;
                break;
            case Direction.Z:
                normal = transform.forward;
                break;
        }

        var p = transform.TransformPoint(m_Center);
        var plane = new Plane(normal, p);
        var d = plane.GetDistanceToPoint(particlePosition);

        if (m_Bound == Bound.Outside)
        {
            if (d < 0)
                particlePosition -= normal * d;
        }
        else
        {
            if (d > 0)
                particlePosition -= normal * d;
        }
    }
}