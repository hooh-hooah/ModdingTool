using System;
using UnityEngine;

// Token: 0x020010D4 RID: 4308
[AttributeUsage(AttributeTargets.Field, Inherited = true, AllowMultiple = true)]
public sealed class ButtonAttribute : PropertyAttribute
{
    // Token: 0x06008ADE RID: 35550 RVA: 0x0035E3F9 File Offset: 0x0035C7F9
    public ButtonAttribute(string function, string name, params object[] parameters)
    {
        this.Function = function;
        this.Name = name;
        this.Parameters = parameters;
    }

    // Token: 0x17001D30 RID: 7472
    // (get) Token: 0x06008ADF RID: 35551 RVA: 0x0035E416 File Offset: 0x0035C816
    // (set) Token: 0x06008AE0 RID: 35552 RVA: 0x0035E41E File Offset: 0x0035C81E
    public string Function { get; private set; }

    // Token: 0x17001D31 RID: 7473
    // (get) Token: 0x06008AE1 RID: 35553 RVA: 0x0035E427 File Offset: 0x0035C827
    // (set) Token: 0x06008AE2 RID: 35554 RVA: 0x0035E42F File Offset: 0x0035C82F
    public string Name { get; private set; }

    // Token: 0x17001D32 RID: 7474
    // (get) Token: 0x06008AE3 RID: 35555 RVA: 0x0035E438 File Offset: 0x0035C838
    // (set) Token: 0x06008AE4 RID: 35556 RVA: 0x0035E440 File Offset: 0x0035C840
    public object[] Parameters { get; private set; }
}