using System.Collections;
using System.Collections.Generic;
using UnityEngine;
//using UnityEditor;

namespace Flockaroo
{
[ExecuteInEditMode]
[RequireComponent(typeof (Camera))]
//[AddComponentMenu("Image Effects/Artistic/ColoredPencils")]
public class ColoredPencilsEffect : MonoBehaviour {
    private Shader shader = null;
    private Shader gradShader = null;
    private Texture2D RandTex = null;
    private Material mat = null;
    private Material gradMat = null;
    private int actWidth = 0;
    private int actHeight = 0;

    [Header("Input/Output")]

    [Tooltip("take a texture as input instead of the camera")]
    public Texture inputTexture;
    [Tooltip("render to a texture instead of the screen")]
    public bool renderToTexture;
    [Tooltip("texture being rendered to if above is checked")]
    public RenderTexture outputTexture;
    [Tooltip("generate mipmap for output texture")]
    public bool outputMipmap;

    [Header("Effect Masking")]
    [Tooltip("take a texture as effect mask (effect only activated where mask is white)")]
    public Texture effectMaskTexture;
    //public bool effectMaskEnable=true;
    [Range(0.0f,1.0f)]   public float effectMaskFade=0.0f;
    //public float effectMaskOffs=0.0f;
    //public float effectMaskClampMin=0.0f;
    //public float effectMaskClampMax=1.0f;

    [Header("Main faders")]
    [Range(0.0f,1.0f)]   public float fade=0.0f;
    [Range(0.0f,1.0f)]   public float panFade=0.0f;
    [Header("Source")]
    [Range(0.0f,2.0f)]   public float brightness=1.0f;
    [Range(0.0f,2.0f)]   public float contrast=1.0f;
    [Range(0.0f,2.0f)]   public float color=1.0f;
    [Header("Effect")]
    [Range(0,2)]        public int shaderMethod=0;
    private int shaderMethodOld=0;
    [Range(0.0f,2.0f)]   public float outlines=1.0f;
    [Range(0.0f,2.0f)]   public float hatches=1.0f;
    [Range(0.0f,2.0f)]   public float outlineError=1.0f;
    [Range(0.0f,1.0f)]   public float flicker=0.3f;
    [Range(0.0f,100.0f)] public float flickerFreq=10.0f;
    [Range(0.0f,1.0f)]   public float fixedHatchDir=0.0f;
    public bool precalcGradient=false;
    public bool precalcGradientFlipY=false;
    [Range(0.7f,1.5f)]   public float hatchScale=1.0f;
    [Range(0.0f,10.0f)]  public float hatchAngle=0.0f;
    [Range(0.001f,200.0f)] public float hatchLength=10.0f;
    [Range(0.0f,3.0f)]   public float mipLevel=0.0f;
    private bool useMipmaps=false;
    [Range(0.0f,1.0f)]   public float vignetting=1.0f;
    [Range(0.0f,1.0f)]   public float contentVignetting=0.0f;
    [Header("Background")]
    public Color paperTint = new Color(1.0f,0.97f,0.85f);
    [Range(0.0f,2.0f)]   public float paperRoughness = 1.0f;
    public Texture2D paperTex = null;
    [Header("Other")]
    public bool flipY=false;
    private RenderTexture rtmip = null;
    private RenderTexture rtgrad = null;
    private RenderTexture inputrt = null;
    private Mesh mesh;
    private bool isShaderooGeom = false;
    List<Mesh> meshes;
        
        // Use this for initialization

        /*protected Material mat
        {
            get
            {
                if (m_Material == null)
                {
                    m_Material = new Material(shader);
                    m_Material.hideFlags = HideFlags.HideAndDontSave;
                }
                return m_Material;
            }
        }*/

        void initShader()
        {

            if (shader == null)
            {
                if     (shaderMethod==0)
                    shader = Resources.Load<Shader>("flockaroo_ColoredPencils/imageEffShader");
                else 
                    shader = Resources.Load<Shader>("flockaroo_ColoredPencils/imageEffShader"+shaderMethod);
                /*else if(shaderMethod==10)
                    shader = Resources.Load<Shader>("flockaroo_ColoredPencils/imageEffShader10");
                else
                    shader = Resources.Load<Shader>("flockaroo_ColoredPencils/imageEffShader");*/
            }
            if (gradShader == null)
            {
                gradShader = Resources.Load<Shader>("flockaroo_ColoredPencils/gradientPrecalc");
            }
            //if (shader == null)
            //    shader = Resources.Load<Shader>("Assets/pencil-effect/imageEffShader");
        }

        RenderTexture createRenderTex(int w = -1, int h = -1, bool mip = false, int aa = 1)
        {
            RenderTexture rt;
            //if(w==-1) w=Screen.width;
            //if(h==-1) h=Screen.height;
            if(w==-1) w=actWidth;
            if(h==-1) h=actHeight;
            rt = new RenderTexture(w, h,0,RenderTextureFormat.ARGBFloat);
            rt.antiAliasing=aa; // must be 1 for mipmapping to work!!
            rt.useMipMap=mip;
            return rt;
        }

        void initRandTex()
        {
            //if (RandTex == null)
            //    RandTex = Resources.Load<Texture2D>("rand256");
            if (RandTex == null)
            {
                //RandTex = new Texture2D(256, 256, TextureFormat.RGBAFloat, true);
                //RandTex = new Texture2D(256, 256, TextureFormat.RGBAHalf, true);
                if(shaderMethod==10)
                    RandTex = new Texture2D(64, 64, TextureFormat.RGBA32, true);
                else
                    RandTex = new Texture2D(256, 256, TextureFormat.RGBA32, true);

                for (int x = 0; x < RandTex.width; x++)
                {
                    for (int y = 0; y < RandTex.height; y++)
                    {
                        float r = Random.Range(0.0f, 1.0f);
                        float g = Random.Range(0.0f, 1.0f);
                        float b = Random.Range(0.0f, 1.0f);
                        float a = Random.Range(0.0f, 1.0f);
                        RandTex.SetPixel(x, y, new Color(r, g, b, a) );
                    }
                }

                RandTex.Apply();
            }
        }
		
		void initMipmapRenderTexture(RenderTexture src)
		{
                    if(rtmip == null || rtmip.width!=src.width || rtmip.height!=src.height)
                    {
                        rtmip = createRenderTex(src.width, src.height, true, 1);
                        //new RenderTexture(src.width, src.height,0,RenderTextureFormat.ARGB32);
#if UNITY_5_5_OR_NEWER
                        //rtmip.autoGenerateMips=false;
#endif
                    }

		}

		void initGradRenderTexture(RenderTexture src)
                {
                    int W=src.width/4;
                    int H=src.height/4;
		    if(rtgrad == null || rtgrad.width!=W || rtgrad.height!=H)
                    {
                        rtgrad = createRenderTex(W,H);
                             //new RenderTexture(src.width/4, src.height/4,0,RenderTextureFormat.ARGB32);
#if UNITY_5_5_OR_NEWER
                        //rtmip.autoGenerateMips=false;
#endif
                    }
		}

        void Start () {
            Camera cam = GetComponent<Camera>();
            cam.depthTextureMode = cam.depthTextureMode | DepthTextureMode.Depth;
            initShader();
            initRandTex();
            if (isShaderooGeom)
            {
              meshes = new List<Mesh>();
              int trinum = 300000;
              int maxMeshSize = 0x10000/3*3;
              int mnum = (trinum*3+maxMeshSize-1)/maxMeshSize;
              for(int j=0;j<mnum;j++)
              {
	        mesh = new Mesh();
                meshes.Add(mesh);
                mesh.Clear();
                //GetComponent<MeshFilter>().mesh = mesh;
                int vnum = maxMeshSize;
                Vector3[] verts = new Vector3 [vnum];
                //Vector2[] uvs   = new Vector2 [vnum];
                int[] tris  = new int [vnum];
                for(int i=0;i<vnum;i++)
                {
                    verts[i].x=i+j*maxMeshSize;
                    verts[i].y=1;
                    verts[i].z=2;
                    //uvs[i].x=i;
                    //uvs[i].y=0;
                    tris[i]=i;
                }
	        mesh.vertices = verts;
                //mesh.uv = uvs;
	        mesh.triangles = tris;
              }  
            }
	}
	
	// Update is called once per frame
	void Update () {
		
	}
        private void OnRenderImage(RenderTexture src, RenderTexture dest) {
            actWidth = src.width;
            actHeight = src.height;

            RenderTexture mySrc=src;
            if(inputTexture)
            {
                if(inputrt==null || inputrt.width!=inputTexture.width || inputrt.height!=inputTexture.height)
                    inputrt =  createRenderTex(inputTexture.width, inputTexture.height);
                mySrc = inputrt;
                    //new RenderTexture(inputTexture.width, inputTexture.height, 0, RenderTextureFormat.ARGBFloat);
                Graphics.Blit(inputTexture, mySrc);
            }

            if(renderToTexture)
            {
                if(outputTexture==null
                   || outputTexture.width!=mySrc.width
                   || outputTexture.height!=mySrc.height)
                {
                    outputTexture = createRenderTex(inputTexture.width, inputTexture.height );
                    //outputTexture = new RenderTexture(mySrc.width, mySrc.height, 0, RenderTextureFormat.ARGBFloat);
                    if(outputMipmap)
                    {
                        outputTexture.antiAliasing=1; // must be for mipmapping to work!!
                        outputTexture.useMipMap=true;
                        outputTexture.filterMode=FilterMode.Trilinear;
                    }
                }
            }
            else
                outputTexture = null;

            if(shaderMethodOld!=shaderMethod) { shader=null; mat=null; RandTex=null; shaderMethodOld=shaderMethod; }

            initShader();
            initRandTex();

            if(precalcGradient)
            {
                initGradRenderTexture(src);
                //if ( gradShader!=null )
                //{
                    if (gradMat == null)
                    {
                        gradMat = new Material(gradShader);
                        gradMat.hideFlags = HideFlags.HideAndDontSave;
                    }
                    gradMat.SetTexture("_MainTex", src);
					gradMat.SetFloat("flipY", precalcGradientFlipY?1.0f:0.0f);
                    Graphics.Blit(src, rtgrad, gradMat);
                //}
            }

            if (mat == null)
            {
                mat = new Material(shader);
                mat.hideFlags = HideFlags.HideAndDontSave;
            }

            mat.SetFloat("iResolutionWidth", actWidth);
            mat.SetFloat("iResolutionHeight", actHeight);

            mat.SetTexture("_PaperTex", paperTex);
            mat.SetTexture("_RandTex", RandTex);
            mat.SetTexture("_MaskTex", effectMaskTexture);
            if(precalcGradient)
                mat.SetTexture("_GradTex", rtgrad);
            mat.SetFloat("precalcGradient", precalcGradient?1.0f:0.0f);
            mat.SetFloat("effectFade", fade);
            mat.SetFloat("panFade", panFade);
            mat.SetFloat("brightness", brightness);
            mat.SetFloat("contrast", contrast);
            mat.SetFloat("colorStrength", color);
            mat.SetFloat("flicker", flicker);
            mat.SetFloat("flickerFreq", flickerFreq);
            mat.SetFloat("fixedHatchDir", fixedHatchDir);
            mat.SetFloat("outlines", outlines);
            mat.SetFloat("hatches", hatches);
            mat.SetFloat("outlineRand", outlineError);
            mat.SetFloat("vignetting", vignetting);
            mat.SetFloat("contentWhiteVign", contentVignetting);
            mat.SetFloat("hatchScale", hatchScale);
            mat.SetFloat("hatchLen", hatchLength);
            mat.SetFloat("hatchAngle", hatchAngle);
            mat.SetFloat("mipLevel", mipLevel);
            mat.SetFloat("flipY", flipY?1.0f:0.0f);
            mat.SetColor("paperTint", paperTint);
            mat.SetFloat("paperRough", paperRoughness);
            mat.SetFloat("paperTexFade", (paperTex==null)?0.0f:1.0f);

            mat.SetFloat("effectMaskFade",    effectMaskFade);
            //mat.SetFloat("effectMaskOffs",     effectMaskOffs);
            //mat.SetFloat("effectMaskClampMin", effectMaskClampMin);
            //mat.SetFloat("effectMaskClampMax", effectMaskClampMax);

            mat.SetInt("_FrameCount", Time.frameCount);
            useMipmaps=(mipLevel>0.0001f);

            if (useMipmaps)
            {
                initMipmapRenderTexture(mySrc);
                Graphics.Blit(mySrc, rtmip);
#if UNITY_5_5_OR_NEWER
                //rtmip.GenerateMips();
#endif
                Graphics.SetRenderTarget(dest);
                mat.SetTexture("_MainTex", rtmip);
				Graphics.Blit(rtmip, dest, mat);
                //rtmip.filterMode = FilterMode.Trilinear;
            }
            else
            {
                mat.SetTexture("_MainTex", src);

                if(isShaderooGeom)
                {
					//initMipmapRenderTexture(src);
                    Graphics.Blit(src, dest);
                    //Graphics.SetRenderTarget(rtmip);
                    //rtmip.DiscardContents(true,true);
                    //Graphics.SetRenderTarget(dest);
                    mat.SetPass(0);
                    foreach(Mesh mesh in meshes)
                    {
                        Graphics.DrawMeshNow(mesh, Vector3.zero, Quaternion.identity);
                    }
                    //rtmip.GenerateMips();
                    //Graphics.SetRenderTarget(dest);
                    //Graphics.Blit(rtmip, dest);
                }
                else
                {
                    if(outputTexture)
                    {
                        Graphics.Blit(mySrc, outputTexture, mat);
                        // default blit of screen - no effect
                        Graphics.Blit(src, dest);
                    }
                    else
                        Graphics.Blit(mySrc, dest, mat);
                }
            }
        }
        /*public void OnPostRender() {
            if (mat == null)
            {
                mat = new Material(shader);
                mat.hideFlags = HideFlags.HideAndDontSave;
            }
            mat.SetPass(0);
            Graphics.DrawMeshNow(mesh, Vector3.zero, Quaternion.identity);
        }*/

}

/*
[CustomEditor(typeof(ColoredPencilsEffect))]
public class ColoredPencilsEffectEditor : Editor
{
    override public void OnInspectorGUI()
    {
        List<string> excludedProperties = new List<string>();
        var myScript = target as ColoredPencilsEffect;
        if(myScript.shaderMethod==10)
        {
            excludedProperties.Add("outlines");
            excludedProperties.Add("fixedHatchDir");
            excludedProperties.Add("MipLevel");
            excludedProperties.Add("vignetting");
            excludedProperties.Add("contentVignetting");
            excludedProperties.Add("paperTint");
            excludedProperties.Add("paperRoughness");
            excludedProperties.Add("paperTex");
        }
        DrawPropertiesExcluding(serializedObject,excludedProperties.ToArray());
        if (GUI.changed) {
            EditorUtility.SetDirty(myScript);
        }
    }
}
*/
}
