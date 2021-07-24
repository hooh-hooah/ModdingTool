using UnityEngine;

// Token: 0x02001025 RID: 4133
public class EyeLookController : MonoBehaviour
{
    // Token: 0x04006C72 RID: 27762
    public EyeLookCalc eyeLookScript;

    // Token: 0x04006C73 RID: 27763
    public int ptnNo;

    // Token: 0x04006C74 RID: 27764
    public Transform target;

    // Token: 0x06008632 RID: 34354 RVA: 0x003473A7 File Offset: 0x003457A7
    private void Start()
    {
        if (!target && Camera.main) target = Camera.main.transform;
    }

    // Token: 0x06008633 RID: 34355 RVA: 0x003473D8 File Offset: 0x003457D8
    private void LateUpdate()
    {
        if (target != null && null != eyeLookScript) eyeLookScript.EyeUpdateCalc(target.position, ptnNo);
    }

    // Token: 0x06008634 RID: 34356 RVA: 0x00347418 File Offset: 0x00345818
    public void ForceLateUpdate()
    {
        LateUpdate();
    }
}