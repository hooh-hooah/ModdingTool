using UnityEngine;

namespace ModdingTool
{
    public class Presets
    {
        public static DynamicBonePreset[] Hairs =
        {
            new DynamicBonePreset
            {
                name = "Heavy Hairs",
                damping = 0.418f,
                elasticity = 0.016f,
                stiffness = 0.012f,
                inert = 0.099f,
                radius = 0.3f,
                endLength = 1f,
                radiusDistrib = new AnimationCurve
                {
                    keys = new[]
                    {
                        new Keyframe(0f, 1f),
                        new Keyframe(1f, 0.5f)
                    }
                },
                force = new Vector3(0, -0.074f, 0)
            },
            new DynamicBonePreset
            {
                name = "Light Hairs",
                damping = 0.102f,
                elasticity = 0.019f,
                stiffness = 0.144f,
                inert = 0.072f,
                radius = 0.14f,
                gravity = new Vector3(0, -0.01f, 0)
            }
        };

        public static DynamicBonePreset[] Clothing =
        {
            new DynamicBonePreset
            {
                name = "Light Skirt",
                damping = 0.102f,
                elasticity = 0.019f,
                stiffness = 0.144f,
                inert = 0.072f,
                radius = 0.14f,
                gravity = new Vector3(0, -0.01f, 0)
            },
            new DynamicBonePreset
            {
                name = "Long Cloth",
                damping = 0.355f,
                elasticity = 0.0f,
                stiffness = 0.0f,
                inert = 0.443f,
                radius = 0.18f,
                force = new Vector3(0, -0.15f, 0)
            },
            new DynamicBonePreset
            {
                name = "Long Cloth 02",
                damping = 1f,
                dampingCurve = new AnimationCurve
                {
                    keys = new[]
                    {
                        new Keyframe(0, 0.8f),
                        new Keyframe(0, 0.85f)
                    }
                },
                elasticity = 0.0f,
                stiffness = 0.0f,
                inert = 0.072f,
                radius = 0.18f,
                force = new Vector3(0, -0.15f, 0)
            }
        };

        public static AIHSBodyPreset[] Body = AIHSPresetLoader.presets;
    }

    public class DynamicBonePreset
    {
        internal float damping;
        internal AnimationCurve dampingCurve;
        internal float elasticity;
        internal AnimationCurve elasticityCurve;
        internal float endLength;
        internal Vector3 force = Vector3.zero;
        internal Vector3 gravity = Vector3.zero;
        internal float inert;
        internal AnimationCurve inertCurve;
        public string name = "";
        internal float radius;
        internal AnimationCurve radiusDistrib;
        internal float stiffness;
        internal AnimationCurve stiffnessCurve;
        internal DynamicBone.UpdateMode updateMode = DynamicBone.UpdateMode.Normal;
        internal int updateRate = 60;

        public void Apply(DynamicBone bone)
        {
            bone.m_UpdateRate = updateRate;
            bone.m_UpdateMode = updateMode;
            bone.m_Damping = damping;
            bone.m_DampingDistrib = dampingCurve;
            bone.m_Elasticity = elasticity;
            bone.m_ElasticityDistrib = elasticityCurve;
            bone.m_Stiffness = stiffness;
            bone.m_StiffnessDistrib = stiffnessCurve;
            bone.m_Inert = inert;
            bone.m_StiffnessDistrib = inertCurve;
            bone.m_EndLength = endLength;
            bone.m_Gravity = gravity;
            bone.m_Force = force;
        }
    }
}