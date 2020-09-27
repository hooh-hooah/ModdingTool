using UnityEngine;

#pragma warning disable 649
// ReSharper disable MemberCanBePrivate.Global
// ReSharper disable FieldCanBeMadeReadOnly.Global
// ReSharper disable ConvertToConstant.Global

namespace ModdingTool
{
    public class Presets
    {
        public static DynamicBonePreset[] Hairs =
        {
            new DynamicBonePreset
            {
                Name = "Heavy Hairs",
                Damping = 0.418f,
                Elasticity = 0.016f,
                Stiffness = 0.012f,
                Inert = 0.099f,
                Radius = 0.3f,
                EndLength = 1f,
                RadiusDistrib = new AnimationCurve
                {
                    keys = new[]
                    {
                        new Keyframe(0f, 1f),
                        new Keyframe(1f, 0.5f)
                    }
                },
                Force = new Vector3(0, -0.074f, 0)
            },
            new DynamicBonePreset
            {
                Name = "Light Hairs",
                Damping = 0.102f,
                Elasticity = 0.019f,
                Stiffness = 0.144f,
                Inert = 0.072f,
                Radius = 0.14f,
                Gravity = new Vector3(0, -0.01f, 0)
            }
        };

        public static DynamicBonePreset[] Clothing =
        {
            new DynamicBonePreset
            {
                Name = "Light Skirt",
                Damping = 0.102f,
                Elasticity = 0.019f,
                Stiffness = 0.144f,
                Inert = 0.072f,
                Radius = 0.14f,
                Gravity = new Vector3(0, -0.01f, 0)
            },
            new DynamicBonePreset
            {
                Name = "Long Cloth",
                Damping = 0.355f,
                Elasticity = 0.0f,
                Stiffness = 0.0f,
                Inert = 0.443f,
                Radius = 0.18f,
                Force = new Vector3(0, -0.15f, 0)
            },
            new DynamicBonePreset
            {
                Name = "Long Cloth 02",
                Damping = 1f,
                DampingCurve = new AnimationCurve
                {
                    keys = new[]
                    {
                        new Keyframe(0, 0.8f),
                        new Keyframe(0, 0.85f)
                    }
                },
                Elasticity = 0.0f,
                Stiffness = 0.0f,
                Inert = 0.072f,
                Radius = 0.18f,
                Force = new Vector3(0, -0.15f, 0)
            }
        };

        public static AIHSBodyPreset[] Body = AIHSPresetLoader.presets;
    }

    public class DynamicBonePreset
    {
        internal float Damping;
        internal AnimationCurve DampingCurve;
        internal float Elasticity;
        internal AnimationCurve ElasticityCurve;
        internal float EndLength;
        internal Vector3 Force = Vector3.zero;
        internal Vector3 Gravity = Vector3.zero;
        internal float Inert;
        internal AnimationCurve InertCurve;
        public string Name = "";
        internal float Radius;
        internal AnimationCurve RadiusDistrib;
        internal float Stiffness;
        internal AnimationCurve StiffnessCurve;
        internal DynamicBone.UpdateMode UpdateMode = DynamicBone.UpdateMode.Normal;
        internal int UpdateRate = 60;

        public void Apply(DynamicBone bone)
        {
            bone.m_DampingDistrib = DampingCurve;
            bone.m_ElasticityDistrib = ElasticityCurve;
            bone.m_StiffnessDistrib = StiffnessCurve;
            bone.m_StiffnessDistrib = InertCurve;
            bone.m_RadiusDistrib = RadiusDistrib;

            bone.m_UpdateRate = UpdateRate;
            bone.m_UpdateMode = UpdateMode;
            bone.m_Damping = Damping;
            bone.m_Elasticity = Elasticity;
            bone.m_Radius = Radius;
            bone.m_Stiffness = Stiffness;
            bone.m_Inert = Inert;
            bone.m_EndLength = EndLength;
            bone.m_Gravity = Gravity;
            bone.m_Force = Force;
        }
    }
}