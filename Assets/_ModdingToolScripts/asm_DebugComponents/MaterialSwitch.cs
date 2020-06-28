using UnityEngine;

namespace DebugComponents
{
    [ExecuteInEditMode]
    public class MaterialSwitch : MonoBehaviour
    {
        private int LastMaterial, CurrentMaterial = 1;

        public Material[] MaterialList;
        private string MaterialName = "";

        public GameObject[] ObjectList;

        // public int Initialmaterial = 0;
        public bool ShowGUI = true;

        private void OnEnable()
        {
            if (ObjectList.Length > 0) LastMaterial = MaterialList.Length - 1;
        }

        private void SwitchMaterialNow()
        {
            if (CurrentMaterial > LastMaterial)
                CurrentMaterial = 1;
            if (CurrentMaterial == 0)
                CurrentMaterial = LastMaterial;
            for (var i = 0; i < ObjectList.Length; i++) ObjectList[i].GetComponent<Renderer>().material = MaterialList[CurrentMaterial];
            MaterialName = MaterialList[CurrentMaterial].name;
        }

        private void Update()
        {
            if (Input.GetKeyDown(KeyCode.RightArrow))
            {
                CurrentMaterial++;
                SwitchMaterialNow();
            }

            if (Input.GetKeyDown(KeyCode.LeftArrow))
            {
                CurrentMaterial--;

                SwitchMaterialNow();
            }

            //Initialmaterial = Mathf.Clamp(Initialmaterial, 0, MaterialList.Length);
        }

        private void OnGUI()
        {
            if (ShowGUI)
            {
                GUILayout.Label("  Use arrows to switch between materials");

                GUI.Label(new Rect(25, 25, 500, 20), "Material[" + CurrentMaterial + "]: " + MaterialName);
            }
        }
    }
}