using System.Linq;
using System.Runtime.CompilerServices;
using AIChara;
using UnityEngine;
using UnityEditor;

// i love cum
public partial class ExtendedTransform
{
    public void DrawQuickCommands(Object[] targets)
    {
        GUILayout.BeginVertical("box");
        GUILayout.Label("Initialize Mod Components");
        GUILayout.BeginHorizontal();
        if (EditorGUILayout.DropdownButton(new GUIContent("Common"), FocusType.Passive, EditorStyles.toolbarDropDown))
        {
            var menu = new GenericMenu();
            menu.AddItem(new GUIContent("Hair"), false, InitializeObject, AIObjectHelper.Command.Hair);
            menu.AddItem(new GUIContent("Clothing"), false, InitializeObject, AIObjectHelper.Command.Clothing);
            menu.AddItem(new GUIContent("Accessory"), false, InitializeObject, AIObjectHelper.Command.Accessory);
            menu.AddItem(new GUIContent("Studio Item"), false, InitializeObject, AIObjectHelper.Command.StudioItem);
            menu.AddSeparator(null);
            menu.AddItem(new GUIContent("Remove All Mod Related Components"),false, InitializeObject, AIObjectHelper.Command.RemoveAll);
            menu.ShowAsContext();
        }

        if (EditorGUILayout.DropdownButton(new GUIContent("HS2"), FocusType.Passive, EditorStyles.toolbarDropDown))
        {
            var menu = new GenericMenu();
            menu.AddItem(new GUIContent("Playable Map"), false, InitializeObject, AIObjectHelper.Command.HS2Map);
            menu.ShowAsContext();
        }

        if (EditorGUILayout.DropdownButton(new GUIContent("AI"), FocusType.Passive, EditorStyles.toolbarDropDown))
        {
            var menu = new GenericMenu();
            menu.ShowAsContext();
        }

        GUILayout.EndHorizontal();
        GUILayout.EndVertical();

        GUILayout.Space(5);
    }

    private void InitializeObject(object _command)
    {
        // Well definently i'm not going to mistake command casting, so no nullref lmao
        AIObjectHelper.Command command = (AIObjectHelper.Command) _command;

        foreach (var o in targets)
        {
            var transform = (Transform) o;
            
            switch (command)
            {
                case AIObjectHelper.Command.Hair:
                    AIObjectHelper.InitializeHair(transform.gameObject);
                    break;
                case AIObjectHelper.Command.Clothing:
                    AIObjectHelper.InitializeClothes(transform.gameObject);
                    break;
                case AIObjectHelper.Command.Accessory:
                    AIObjectHelper.InitializeAccessory(transform.gameObject);
                    break;
                case AIObjectHelper.Command.StudioItem:
                    AIObjectHelper.InitializeItem(transform.gameObject);
                    break;
                case AIObjectHelper.Command.HS2Map:
                    break;
                case AIObjectHelper.Command.RemoveAll:
                    // Fuck shit up if it's related with god damn shits
                    transform.gameObject.GetComponents<Component>().Where(x => x is CmpBase).ToList().ForEach(DestroyImmediate);
                    break;
            }
        }
    }
}