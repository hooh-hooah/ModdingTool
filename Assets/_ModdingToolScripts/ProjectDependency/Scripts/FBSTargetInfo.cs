using System;
using UnityEngine;

// Token: 0x02001036 RID: 4150
[Serializable]
public class FBSTargetInfo
{
    // Token: 0x0600867C RID: 34428 RVA: 0x0034A6C0 File Offset: 0x00348AC0
    public void SetSkinnedMeshRenderer()
    {
        if (this.ObjTarget)
        {
            this.smrTarget = this.ObjTarget.GetComponent<SkinnedMeshRenderer>();
        }
    }

    // Token: 0x0600867D RID: 34429 RVA: 0x0034A6E3 File Offset: 0x00348AE3
    public SkinnedMeshRenderer GetSkinnedMeshRenderer()
    {
        return this.smrTarget;
    }

    // Token: 0x0600867E RID: 34430 RVA: 0x0034A6EB File Offset: 0x00348AEB
    public void Clear()
    {
        this.ObjTarget = null;
        this.PtnSet = null;
        this.smrTarget = null;
    }

    // Token: 0x04006CFC RID: 27900
    public GameObject ObjTarget;

    // Token: 0x04006CFD RID: 27901
    public FBSTargetInfo.CloseOpen[] PtnSet;

    // Token: 0x04006CFE RID: 27902
    private SkinnedMeshRenderer smrTarget;

    // Token: 0x02001037 RID: 4151
    [Serializable]
    public class CloseOpen
    {
        // Token: 0x04006CFF RID: 27903
        public string CloseName;
        public int Close;

        // Token: 0x04006D00 RID: 27904
        public string OpenName;
        public int Open;
    }

    private CloseOpen csOpen;


}
