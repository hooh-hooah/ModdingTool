using System;
using UnityEngine;

[AddComponentMenu("Rendering/SetRenderQueue")]
public class SetRenderQueue : MonoBehaviour
{
    [SerializeField]
    protected int[] m_queues = new int[]
    {
        3000
    };

    public virtual void Awake()
    {
        Material[] materials = base.GetComponent<Renderer>().materials;
        int num = 0;
        while (num < materials.Length && num < this.m_queues.Length)
        {
            materials[num].renderQueue = this.m_queues[num];
            num++;
        }
    }
}
