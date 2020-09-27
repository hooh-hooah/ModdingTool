using UnityEngine;

[AddComponentMenu("Rendering/SetRenderQueue")]
public class SetRenderQueue : MonoBehaviour
{
    [SerializeField] protected int[] m_queues =
    {
        3000
    };

    public virtual void Awake()
    {
        var materials = GetComponent<Renderer>().materials;
        var num = 0;
        while (num < materials.Length && num < m_queues.Length)
        {
            materials[num].renderQueue = m_queues[num];
            num++;
        }
    }
}