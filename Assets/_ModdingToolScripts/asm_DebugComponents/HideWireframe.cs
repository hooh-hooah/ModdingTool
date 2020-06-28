using UnityEngine;

#if UNITY_EDITOR

#endif
namespace DebugComponents
{
    [ExecuteInEditMode]
    public class HideWireframe : MonoBehaviour
    {
        public bool Hide = true;

//Deprecated in 5.5
//    static public void Wireframe(GameObject Obj, bool Enable)
//    {
//#if UNITY_EDITOR
//        EditorUtility.SetSelectedWireframeHidden(Obj.GetComponent<Renderer>(), Enable);
//#endif
//    }
        private void OnWillRenderObject()
        {
//#if UNITY_EDITOR
//        Wireframe(gameObject, Hide);
//#endif
        }
    }
}