using UnityEngine;
using UnityEditor;
using Studio;
using System.Text.RegularExpressions;

[CustomEditor(typeof(ItemComponent))]
public class ItemComponentEditor : Editor {
    public override void OnInspectorGUI() {
        base.OnInspectorGUI();

        ItemComponent component = (ItemComponent)target;
        EditorGUILayout.LabelField("hoohTools Macros");
        if (GUILayout.Button("Fillout Animations")) {
            if (component != null) {
                GameObject gameObject = component.gameObject;
                Animator animator = gameObject.GetComponent<Animator>();
                RuntimeAnimatorController controller = animator.runtimeAnimatorController;
                AnimationClip[] clips = controller.animationClips;
                
                ItemComponent.AnimeInfo[] anims = new ItemComponent.AnimeInfo[clips.Length];
                int index = 0;
                foreach (var clip in clips) {
                    ItemComponent.AnimeInfo animInfo = new ItemComponent.AnimeInfo();
                    
                    // Make name not-developer friendly.
                    string niceName = clip.name;
                    if (niceName.IndexOf("|") > 0)
                        niceName = niceName.Substring(niceName.IndexOf("|")+1);
                    niceName = Regex.Replace(niceName, @"([a-z])([A-Z])", "$1 $2");
                    niceName = Regex.Replace(niceName, @"([_-])", " ");
                    niceName = Regex.Replace(niceName, @"(^| )[a-z]", m => m.ToString().ToUpper());

                    // But put those shit in developer friendly form.
                    animInfo.name = niceName;
                    animInfo.state = clip.name;
                    anims[index] = animInfo;
                    index++;

                    // Debug if you need em'
                    //Debug.Log(niceName);
                }
                component.animeInfos = anims;
            }
        }
    }
}

