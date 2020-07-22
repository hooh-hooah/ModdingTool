using Inspectors.Utilities;
using UnityEditor;

public abstract class CustomComponentBase : Editor
{
    protected Styles Styles;

    protected void InitStyles()
    {
        if (Styles == null) Styles = new Styles();
    }
}