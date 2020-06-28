#if WIP
using UnityEngine;
using UnityEditor;
using UnityEditor.Animations;
using System.Collections;
using Studio;
using System.Text.RegularExpressions;

[CustomEditor(typeof(AnimatorController))]
public class AnimationControllerMacro: Editor {
    public override void OnInspectorGUI() {
        base.OnInspectorGUI();

        AnimatorController component = (AnimatorController)target;
        EditorGUILayout.LabelField("hoohTools Macros");
        if (GUILayout.Button("Connect all disconnected animations")) {
            if (component != null) {
                var animationClips = component.animationClips;
            }
        }
    }
}
#endif