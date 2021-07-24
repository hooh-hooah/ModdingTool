using System;
using UnityEngine;

namespace Studio
{
	// Token: 0x02000276 RID: 630
	public class LightColor : MonoBehaviour
	{
		// Token: 0x17000720 RID: 1824
		// (set) Token: 0x06001980 RID: 6528 RVA: 0x000C7757 File Offset: 0x000C5957
		public Color color
		{
			set
			{
				if (this.material)
				{
					this.material.color = value;
				}
			}
		}

		// Token: 0x06001981 RID: 6529 RVA: 0x000C7772 File Offset: 0x000C5972
		public virtual void Awake()
		{
			this.material = this.renderer.material;
		}

		// Token: 0x04001611 RID: 5649
		[SerializeField]
		private Renderer renderer;

		// Token: 0x04001612 RID: 5650
		private Material material;
	}
}
