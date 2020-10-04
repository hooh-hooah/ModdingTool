using System.Collections.Generic;

// ReSharper disable NotAccessedField.Local
// ReSharper disable InconsistentNaming
#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649
namespace UnityEngine.AI
{
    [ExecuteInEditMode]
    [AddComponentMenu("Navigation/NavMeshModifier", 32)]
    [HelpURL("https://github.com/Unity-Technologies/NavMeshComponents#documentation-draft")]
    public class NavMeshModifier : MonoBehaviour
    {
        [SerializeField] private bool m_OverrideArea;
        [SerializeField] private int m_Area;
        [SerializeField] private bool m_IgnoreFromBuild;
        [SerializeField] private List<int> m_AffectedAgents = new List<int>(new[] {-1});

        public bool overrideArea
        {
            get => m_OverrideArea;
            set => m_OverrideArea = value;
        }

        public int area
        {
            get => m_Area;
            set => m_Area = value;
        }

        public bool ignoreFromBuild
        {
            get => m_IgnoreFromBuild;
            set => m_IgnoreFromBuild = value;
        }

        public static List<NavMeshModifier> activeModifiers { get; } = new List<NavMeshModifier>();

        private void OnEnable()
        {
            if (!activeModifiers.Contains(this)) activeModifiers.Add(this);
        }

        private void OnDisable()
        {
            activeModifiers.Remove(this);
        }

        public bool AffectsAgentType(int agentTypeID)
        {
            return m_AffectedAgents.Count != 0 && (m_AffectedAgents[0] == -1 || m_AffectedAgents.IndexOf(agentTypeID) != -1);
        }
    }
}