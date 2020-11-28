using System;
using System.Linq;
using hooh_ModdingTool.asm_Packer.Editor;
using UnityEditor;
using UnityEngine;
using UnityEngine.UI;

public partial class HoohTools
{
    public enum Command
    {
        Hair,
        Clothing,
        Accessory,
        AccessoryWithTransform,
        AccessorySkinned,
        StudioItem,
        HS2Map = 10,
        AIMap = 20,
        AIFurniture,
        RemoveAll = 999
    }

    public void DrawModSetup(SerializedObject serializedObject)
    {
        WindowUtility.VerticalLayout(() =>
        {
            WindowUtility.Button("Initialize HS2 Map", () => { });
            WindowUtility.Button("Setup Mod Folder", () => { });
        });

        WindowUtility.VerticalLayout(() =>
        {
            GUILayout.Label("Initialize Mod Components");
            WindowUtility.HorizontalLayout(() =>
            {
                WindowUtility.Dropdown("Common", new[]
                {
                    new WindowUtility.DropDownItem {Name = "Hair", On = false, Callback = InitializeObject, Parameter = Command.Hair},
                    new WindowUtility.DropDownItem {Name = "Clothing", On = false, Callback = InitializeObject, Parameter = Command.Clothing},
                    new WindowUtility.DropDownItem {Name = "Accessory/Initialize with Existing N_Move", On = false, Callback = InitializeObject, Parameter = Command.Accessory},
                    new WindowUtility.DropDownItem
                        {Name = "Accessory/Initialize with New N_Move", On = false, Callback = InitializeObject, Parameter = Command.AccessoryWithTransform},
                    new WindowUtility.DropDownItem {Name = "Accessory/Skinned Accessory", On = false, Callback = InitializeObject, Parameter = Command.AccessorySkinned},
                    new WindowUtility.DropDownItem {Name = "Studio Item", On = false, Callback = InitializeObject, Parameter = Command.StudioItem},
                    new WindowUtility.DropDownItem {Name = "Remove All Mod Related Components", On = false, Callback = InitializeObject, Parameter = Command.RemoveAll},
                });

                WindowUtility.Dropdown("HS2", new[]
                {
                    new WindowUtility.DropDownItem {Name = "Playable Map", On = false, Callback = InitializeObject, Parameter = Command.HS2Map},
                });

                WindowUtility.Dropdown("AI", new[]
                {
                    new WindowUtility.DropDownItem {Name = "Furniture Data", On = false, Callback = InitializeObject, Parameter = Command.AIFurniture},
                    new WindowUtility.DropDownItem {Name = "Playable Map", On = false, Callback = InitializeObject, Parameter = Command.AIMap},
                });
            }, false);
        });
    }

    public void CallHelper(string functionName, params object[] parameters)
    {
        Type.GetType("AIObjectHelper, Assembly-CSharp-Editor")?.GetMethod(functionName)?.Invoke(null, parameters);
    }

    private void InitializeObject(object _command)
    {
        var command = (Command) _command;

        foreach (var o in Selection.gameObjects.Select(x => x.GetComponent<Transform>()))
        {
            var transform = (Transform) o;

            switch (command)
            {
                case Command.Hair:
                    CallHelper("InitializeHair", transform.gameObject);
                    break;
                case Command.Clothing:
                    CallHelper("InitializeClothes", transform.gameObject);
                    break;
                case Command.Accessory:
                    CallHelper("InitializeAccessory", transform.gameObject);
                    break;
                case Command.AccessoryWithTransform:
                    CallHelper("InitializeAccessory", transform.gameObject, true);
                    break;
                case Command.AccessorySkinned:
                    CallHelper("InitializeSkinnedAccessory", transform.gameObject);
                    break;
                case Command.StudioItem:
                    CallHelper("InitializeItem", transform.gameObject);
                    break;
                case Command.AIFurniture:
                    CallHelper("InitializeFurniture", transform.gameObject);
                    break;
                case Command.RemoveAll:
                    CallHelper("RemoveAllModRelatedObjects", transform.gameObject);
                    break;
                case Command.AIMap:
                    break;
                case Command.HS2Map:
                    break;
                default:
                    throw new ArgumentOutOfRangeException();
            }
        }
    }
}