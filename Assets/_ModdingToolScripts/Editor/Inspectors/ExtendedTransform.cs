using Inspectors.Utilities;
using UnityEditor;
using UnityEngine;

[CanEditMultipleObjects]
[CustomEditor(typeof(Transform))]
public partial class ExtendedTransform : Editor
{
    private const float FIELD_WIDTH = 250; //controls the width of the input fields

    private const float POSITION_MAX = 100000.0f;

    private static readonly GUIContent rotationGUIContent = new GUIContent(LocalString("Rotation"),
        LocalString("The local rotation of this Game Object relative to the parent."));

    private static readonly string positionWarningText =
        LocalString(
            "Due to floating-point precision limitations, it is recommended to bring the world coordinates of the GameObject within a smaller range.");

    private static Texture2D icon_revert;
    private static Texture2D icon_locked;
    private static Texture2D icon_unlocked;

    public static bool UniformScaling; //Are we using uniform scaling mode?

    private static bool SHOW_UTILS; //Should we show the utilities section?

    private static bool unfoldTransformOptions = true;
    private static bool unfoldModdingOptions = true;

    private SerializedProperty positionProperty; //The position of this transform
    private SerializedProperty rotationProperty; //The rotation of this transform
    private SerializedProperty scaleProperty; //The scale of this transform

    private static bool ThinInspectorMode => EditorGUIUtility.currentViewWidth <= 300;

    public override void OnInspectorGUI()
    {
        serializedObject.Update();
        //Draw the inputs
        DrawPositionElement();
        DrawRotationElement();
        DrawScaleElement();

        //Draw the Utilities

        GUILayout.Space(5);
        unfoldTransformOptions = EditorGUILayout.Foldout(unfoldTransformOptions, "Additional Transform Options", true);
        if (unfoldTransformOptions) DrawUtilities();

        //Validate the transform of this object
        if (!ValidatePosition(((Transform) target).position))
            EditorGUILayout.HelpBox(positionWarningText, MessageType.Warning);

        //Apply the settings to the object
        serializedObject.ApplyModifiedProperties();
        EditorGUIUtility.labelWidth = 0;

        // unfoldModdingOptions = EditorGUILayout.Foldout(unfoldModdingOptions, "Initialize Modding Components", true);
        // if (unfoldModdingOptions) DrawQuickCommands(targets);
    }

    private void DrawPositionElement()
    {
        if (ThinInspectorMode)
        {
            GUILayout.BeginHorizontal();
            EditorGUILayout.LabelField("Position");
            DrawPositionReset();
            GUILayout.EndHorizontal();
        }

        var label = ThinInspectorMode ? "" : "Position";

        GUILayout.BeginHorizontal();
        EditorGUIUtility.labelWidth =
            EditorGUIUtility.currentViewWidth - FIELD_WIDTH - 64; // align field to right of inspector
        positionProperty.vector3Value = EditorUtils.Vector3InputField(label, positionProperty.vector3Value);
        if (!ThinInspectorMode)
            DrawPositionReset();
        GUILayout.EndHorizontal();
        EditorGUIUtility.labelWidth = 0;
    }

    private void DrawPositionReset()
    {
        GUILayout.Space(18);
        if (GUILayout.Button(new GUIContent("", icon_revert, "Reset this objects position"),
            EditorUtils.uEditorSkin.GetStyle("ResetButton"), GUILayout.Width(18), GUILayout.Height(18)))
            positionProperty.vector3Value = Vector3.zero;
    }

    private void DrawRotationElement()
    {
        if (ThinInspectorMode)
        {
            GUILayout.BeginHorizontal();
            EditorGUILayout.LabelField("Rotation");
            DrawRotationReset();
            GUILayout.EndHorizontal();
        }

        //Rotation layout
        GUILayout.BeginHorizontal();
        EditorGUIUtility.labelWidth =
            EditorGUIUtility.currentViewWidth - FIELD_WIDTH - 64; // align field to right of inspector
        RotationPropertyField(rotationProperty, ThinInspectorMode ? GUIContent.none : rotationGUIContent);
        if (!ThinInspectorMode)
            DrawRotationReset();
        GUILayout.EndHorizontal();
        EditorGUIUtility.labelWidth = 0;
    }

    private void DrawRotationReset()
    {
        GUILayout.Space(18);
        if (GUILayout.Button(new GUIContent("", icon_revert, "Reset this objects rotation"),
            EditorUtils.uEditorSkin.GetStyle("ResetButton"), GUILayout.Width(18), GUILayout.Height(18)))
            rotationProperty.quaternionValue = Quaternion.identity;
    }

    private void DrawScaleElement()
    {
        if (ThinInspectorMode)
        {
            GUILayout.BeginHorizontal();
            EditorGUILayout.LabelField("Scale");
            DrawScaleReset();
            GUILayout.EndHorizontal();
        }

        var label = ThinInspectorMode ? "" : "Scale";

        //Scale Layout
        GUILayout.BeginHorizontal();
        EditorGUIUtility.labelWidth =
            EditorGUIUtility.currentViewWidth - FIELD_WIDTH - 64; // align field to right of inspector
        scaleProperty.vector3Value = EditorUtils.Vector3InputField(label, scaleProperty.vector3Value, false,
            UniformScaling, UniformScaling);
        if (!ThinInspectorMode)
            DrawScaleReset();
        GUILayout.EndHorizontal();
        EditorGUIUtility.labelWidth = 0;
    }

    private void DrawScaleReset()
    {
        if (GUILayout.Button(
            new GUIContent("", UniformScaling ? icon_locked : icon_unlocked,
                UniformScaling ? "Unlock Scale" : "Lock Scale"), EditorUtils.uEditorSkin.GetStyle("ResetButton"),
            GUILayout.Width(18), GUILayout.Height(18)))
            UniformScaling = !UniformScaling;

        if (GUILayout.Button(new GUIContent("", icon_revert, "Reset this objects scale"),
            EditorUtils.uEditorSkin.GetStyle("ResetButton"), GUILayout.Width(18), GUILayout.Height(18)))
            scaleProperty.vector3Value = Vector3.one;
    }

    private static string LocalString(string text)
    {
        return text;
    }

    private bool ValidatePosition(Vector3 position)
    {
        if (Mathf.Abs(position.x) > POSITION_MAX) return false;
        if (Mathf.Abs(position.y) > POSITION_MAX) return false;
        if (Mathf.Abs(position.z) > POSITION_MAX) return false;
        return true;
    }

    private void RotationPropertyField(SerializedProperty rotationProperty, GUIContent content)
    {
        var transform = (Transform) targets[0];
        var localRotation = transform.localRotation;
        foreach (var t in targets)
            if (!SameRotation(localRotation, ((Transform) t).localRotation))
            {
                EditorGUI.showMixedValue = true;
                break;
            }

        EditorGUI.BeginChangeCheck();

        var eulerAngles = EditorUtils.Vector3InputField(content.text, localRotation.eulerAngles);
        //Vector3 eulerAngles = EditorGUILayout.Vector3Field(content, localRotation.eulerAngles);

        if (EditorGUI.EndChangeCheck())
        {
            Undo.RecordObjects(targets, "Rotation Changed");
            foreach (var obj in targets)
            {
                var t = (Transform) obj;
                t.localEulerAngles = eulerAngles;
            }

            rotationProperty.serializedObject.SetIsDifferentCacheDirty();
        }

        EditorGUI.showMixedValue = false;
    }

    private bool SameRotation(Quaternion rot1, Quaternion rot2)
    {
        if (rot1.x != rot2.x) return false;
        if (rot1.y != rot2.y) return false;
        if (rot1.z != rot2.z) return false;
        if (rot1.w != rot2.w) return false;
        return true;
    }


    #region INITIALISATION

    public void OnEnable()
    {
        positionProperty = serializedObject.FindProperty("m_LocalPosition");
        rotationProperty = serializedObject.FindProperty("m_LocalRotation");
        scaleProperty = serializedObject.FindProperty("m_LocalScale");
        icon_revert = EditorGUIUtility.isProSkin
            ? Resources.Load("uEditor_Revert_pro") as Texture2D
            : Resources.Load("uEditor_Revert") as Texture2D;
        icon_locked = Resources.Load("uEditor_locked") as Texture2D;
        icon_unlocked = Resources.Load("uEditor_unlocked") as Texture2D;
        EditorApplication.update += EditorUpdate;
        unfoldTransformOptions = EditorPrefs.GetBool("hoohTool_unfoldAdvancedTransform", true);
    }

    private void OnDisable()
    {
        EditorApplication.update -= EditorUpdate;
    }

    private void EditorUpdate()
    {
        Repaint();
    }

    #endregion

    #region UTILITIES

    private static float snap_offset;
    private static Vector3 minRotation;
    private static Vector3 maxRotation = new Vector3(360, 360, 360);

    private void DrawUtilities()
    {
        var guiWidth = GUILayout.Width(160);
        var guiHeight = GUILayout.Height(EditorGUIUtility.singleLineHeight * 2);

        EditorGUIUtility.labelWidth = 30f;
        GUILayout.Space(5);
        GUILayout.BeginHorizontal();
        if (GUILayout.Button("Random Rotation", guiWidth, guiHeight))
            foreach (var tar in targets)
            {
                var t = (Transform) tar;
                Undo.RecordObject(t, "Random Rotation");
                t.RandomiseRotation(minRotation, maxRotation);
            }

        GUILayout.BeginVertical();
        minRotation = EditorGUILayout.Vector3Field("Min", minRotation);
        maxRotation = EditorGUILayout.Vector3Field("Max", maxRotation);
        GUILayout.EndVertical();
        GUILayout.EndHorizontal();

        EditorGUIUtility.labelWidth = 0;
    }

    #endregion
}