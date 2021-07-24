using UnityEngine;

[AddComponentMenu("Dynamic Bone/Dynamic Bone Collider")]
public class DynamicBoneCollider : DynamicBoneColliderBase
{
#if UNITY_5
	[Tooltip("The radius of the sphere or capsule.")]
#endif
    public float m_Radius = 0.5f;

#if UNITY_5
	[Tooltip("The height of the capsule.")]
#endif
    public float m_Height;

    private void OnValidate()
    {
        m_Radius = Mathf.Max(m_Radius, 0);
        m_Height = Mathf.Max(m_Height, 0);
    }

    public override void Collide(ref Vector3 particlePosition, float particleRadius)
    {
        var radius = m_Radius * Mathf.Abs(transform.lossyScale.x);
        var h = m_Height * 0.5f - m_Radius;
        if (h <= 0)
        {
            if (m_Bound == Bound.Outside)
                OutsideSphere(ref particlePosition, particleRadius, transform.TransformPoint(m_Center), radius);
            else
                InsideSphere(ref particlePosition, particleRadius, transform.TransformPoint(m_Center), radius);
        }
        else
        {
            var c0 = m_Center;
            var c1 = m_Center;

            switch (m_Direction)
            {
                case Direction.X:
                    c0.x -= h;
                    c1.x += h;
                    break;
                case Direction.Y:
                    c0.y -= h;
                    c1.y += h;
                    break;
                case Direction.Z:
                    c0.z -= h;
                    c1.z += h;
                    break;
            }

            if (m_Bound == Bound.Outside)
                OutsideCapsule(ref particlePosition, particleRadius, transform.TransformPoint(c0),
                    transform.TransformPoint(c1), radius);
            else
                InsideCapsule(ref particlePosition, particleRadius, transform.TransformPoint(c0),
                    transform.TransformPoint(c1), radius);
        }
    }

    private static void OutsideSphere(ref Vector3 particlePosition, float particleRadius, Vector3 sphereCenter,
        float sphereRadius)
    {
        var r = sphereRadius + particleRadius;
        var r2 = r * r;
        var d = particlePosition - sphereCenter;
        var len2 = d.sqrMagnitude;

        // if is inside sphere, project onto sphere surface
        if (len2 > 0 && len2 < r2)
        {
            var len = Mathf.Sqrt(len2);
            particlePosition = sphereCenter + d * (r / len);
        }
    }

    private static void InsideSphere(ref Vector3 particlePosition, float particleRadius, Vector3 sphereCenter,
        float sphereRadius)
    {
        var r = sphereRadius - particleRadius;
        var r2 = r * r;
        var d = particlePosition - sphereCenter;
        var len2 = d.sqrMagnitude;

        // if is outside sphere, project onto sphere surface
        if (len2 > r2)
        {
            var len = Mathf.Sqrt(len2);
            particlePosition = sphereCenter + d * (r / len);
        }
    }

    private static void OutsideCapsule(ref Vector3 particlePosition, float particleRadius, Vector3 capsuleP0,
        Vector3 capsuleP1, float capsuleRadius)
    {
        var r = capsuleRadius + particleRadius;
        var r2 = r * r;
        var dir = capsuleP1 - capsuleP0;
        var d = particlePosition - capsuleP0;
        var t = Vector3.Dot(d, dir);

        if (t <= 0)
        {
            // check sphere1
            var len2 = d.sqrMagnitude;
            if (len2 > 0 && len2 < r2)
            {
                var len = Mathf.Sqrt(len2);
                particlePosition = capsuleP0 + d * (r / len);
            }
        }
        else
        {
            var dl = dir.sqrMagnitude;
            if (t >= dl)
            {
                // check sphere2
                d = particlePosition - capsuleP1;
                var len2 = d.sqrMagnitude;
                if (len2 > 0 && len2 < r2)
                {
                    var len = Mathf.Sqrt(len2);
                    particlePosition = capsuleP1 + d * (r / len);
                }
            }
            else if (dl > 0)
            {
                // check cylinder
                t /= dl;
                d -= dir * t;
                var len2 = d.sqrMagnitude;
                if (len2 > 0 && len2 < r2)
                {
                    var len = Mathf.Sqrt(len2);
                    particlePosition += d * ((r - len) / len);
                }
            }
        }
    }

    private static void InsideCapsule(ref Vector3 particlePosition, float particleRadius, Vector3 capsuleP0,
        Vector3 capsuleP1, float capsuleRadius)
    {
        var r = capsuleRadius - particleRadius;
        var r2 = r * r;
        var dir = capsuleP1 - capsuleP0;
        var d = particlePosition - capsuleP0;
        var t = Vector3.Dot(d, dir);

        if (t <= 0)
        {
            // check sphere1
            var len2 = d.sqrMagnitude;
            if (len2 > r2)
            {
                var len = Mathf.Sqrt(len2);
                particlePosition = capsuleP0 + d * (r / len);
            }
        }
        else
        {
            var dl = dir.sqrMagnitude;
            if (t >= dl)
            {
                // check sphere2
                d = particlePosition - capsuleP1;
                var len2 = d.sqrMagnitude;
                if (len2 > r2)
                {
                    var len = Mathf.Sqrt(len2);
                    particlePosition = capsuleP1 + d * (r / len);
                }
            }
            else if (dl > 0)
            {
                // check cylinder
                t /= dl;
                d -= dir * t;
                var len2 = d.sqrMagnitude;
                if (len2 > r2)
                {
                    var len = Mathf.Sqrt(len2);
                    particlePosition += d * ((r - len) / len);
                }
            }
        }
    }

    private void OnDrawGizmosSelected()
    {
        if (!enabled)
            return;

        if (m_Bound == Bound.Outside)
            Gizmos.color = Color.yellow;
        else
            Gizmos.color = Color.magenta;
        var radius = m_Radius * Mathf.Abs(transform.lossyScale.x);
        var h = m_Height * 0.5f - m_Radius;
        if (h <= 0)
        {
            Gizmos.DrawWireSphere(transform.TransformPoint(m_Center), radius);
        }
        else
        {
            var c0 = m_Center;
            var c1 = m_Center;

            switch (m_Direction)
            {
                case Direction.X:
                    c0.x -= h;
                    c1.x += h;
                    break;
                case Direction.Y:
                    c0.y -= h;
                    c1.y += h;
                    break;
                case Direction.Z:
                    c0.z -= h;
                    c1.z += h;
                    break;
            }

            Gizmos.DrawWireSphere(transform.TransformPoint(c0), radius);
            Gizmos.DrawWireSphere(transform.TransformPoint(c1), radius);
        }
    }
}