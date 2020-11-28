using hooh_ModdingTool.asm_Packer.Editor;
using UnityEditor;

public partial class HoohTools
{
    public void DrawXMLGenerator(SerializedObject serializedObject)
    {
        WindowUtility.VerticalLayout(() =>
        {
            WindowUtility.Button("Create Mod Template", () => { });
        });
    }
}