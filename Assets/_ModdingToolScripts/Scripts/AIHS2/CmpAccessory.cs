using System.Linq;
using UnityEngine;

namespace AIChara
{
    [DisallowMultipleComponent]
    public class CmpAccessory : CmpBase
    {
        public Color defColor01 = Color.white;
        public Color defColor02 = Color.white;
        public Color defColor03 = Color.white;
        public Color defColor04 = Color.white;
        public float defGlossPower01 = 0.5f;
        public float defGlossPower02 = 0.5f;
        public float defGlossPower03 = 0.5f;
        public float defGlossPower04 = 0.5f;
        public float defMetallicPower01 = 0.5f;
        public float defMetallicPower02 = 0.5f;
        public float defMetallicPower03 = 0.5f;
        public float defMetallicPower04 = 0.5f;
        public Renderer[] rendAlpha;
        public Renderer[] rendNormal;
        [HideInInspector] public int setcolor;
        public Transform trfMove01;
        public Transform trfMove02;
        public bool typeHair;
        public bool useColor01;
        public bool useColor02;
        public bool useColor03;
        public bool useGloss01 = true;
        public bool useGloss02 = true;
        public bool useGloss03 = true;
        public bool useGloss04 = true;
        public bool useMetallic01 = true;
        public bool useMetallic02 = true;
        public bool useMetallic03 = true;
        public bool useMetallic04 = true;

        public CmpAccessory() : base(true)
        {
        }

        public override void SetReferenceObject()
        {
            gameObject.layer = 10;
            gameObject.GetComponentsInChildren<Transform>().ToList().ForEach(x => x.gameObject.layer = 10);
            
            rendNormal = GetComponentsInChildren<Renderer>().ToArray();
            var findAssist = new FindAssist();
            findAssist.Initialize(transform);
            trfMove01 = findAssist.GetTransformFromName("N_move");
            trfMove02 = findAssist.GetTransformFromName("N_move2");
            SyncMaterialDefaultValues();
        }

        public void SyncMaterialDefaultValues()
        {
            if (rendNormal != null && rendNormal.Length != 0)
            {
                var sharedMaterial = rendNormal[0].sharedMaterial;
                if (null != sharedMaterial)
                {
                    if (sharedMaterial.HasProperty("_Color")) defColor01 = sharedMaterial.GetColor("_Color");
                    if (sharedMaterial.HasProperty("_Glossiness")) defGlossPower01 = sharedMaterial.GetFloat("_Glossiness");
                    if (sharedMaterial.HasProperty("_Metallic")) defMetallicPower01 = sharedMaterial.GetFloat("_Metallic");
                    if (sharedMaterial.HasProperty("_Color2")) defColor02 = sharedMaterial.GetColor("_Color2");
                    if (sharedMaterial.HasProperty("_Glossiness2")) defGlossPower02 = sharedMaterial.GetFloat("_Glossiness2");
                    if (sharedMaterial.HasProperty("_Metallic2")) defMetallicPower02 = sharedMaterial.GetFloat("_Metallic2");
                    if (sharedMaterial.HasProperty("_Color3")) defColor03 = sharedMaterial.GetColor("_Color3");
                    if (sharedMaterial.HasProperty("_Glossiness3")) defGlossPower03 = sharedMaterial.GetFloat("_Glossiness3");
                    if (sharedMaterial.HasProperty("_Metallic3")) defMetallicPower03 = sharedMaterial.GetFloat("_Metallic3");
                }
            }

            if (rendAlpha != null && rendAlpha.Length != 0)
            {
                var sharedMaterial2 = rendAlpha[0].sharedMaterial;
                if (null != sharedMaterial2)
                {
                    if (sharedMaterial2.HasProperty("_Color")) defColor04 = sharedMaterial2.GetColor("_Color");
                    if (sharedMaterial2.HasProperty("_Glossiness4")) defGlossPower04 = sharedMaterial2.GetFloat("_Glossiness4");
                    if (sharedMaterial2.HasProperty("_Metallic4")) defMetallicPower04 = sharedMaterial2.GetFloat("_Metallic4");
                }
            }
        }
    }
}