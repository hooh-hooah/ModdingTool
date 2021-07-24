using System;
using System.Collections.Generic;
using RootMotion;
using UnityEngine;
using UnityEngine.UI;

// ReSharper disable InconsistentNaming
// ReSharper disable IdentifierTypo
// ReSharper disable UnusedMember.Global
// ReSharper disable UnusedMember.Local
// ReSharper disable ClassNeverInstantiated.Global
#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649
#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414

public class CameraControl_Ver2
{
}

public class HSceneFlagCtrl : Singleton<HSceneFlagCtrl>
{
    public enum AnimType
    {
        Anal, NameKuwae, MaleShot, MataIjiri, KokanSonyu,
        AnalIjiri, OrgasmF, OloopH, Sonyu, Urine,
        Kunni, Kiss, Inside, InsideMouth, FemaleMain,
        MaleMain
    }

    public enum CharaCtrlKind { None = -1, Parallel, Height, Rotation }

    public enum ClickKind
    {
        None = -1, FinishBefore, FinishInSide, FinishOutSide, FinishSame,
        FinishDrink, FinishVomit, RecoverFaintness, Spnking, PeepingRestart,
        ParallelShiftInit, VerticalShiftInit, RotationShiftInit, LeaveItToYou, MovePointNext,
        MovePointBack, SceneEnd
    }

    [Flags]
    public enum JudgeSelect
    {
        Kiss = 1, Kokan = 2, Breast = 4, Anal = 8, Pain = 16,
        Constraint = 32
    }

    public string atariTamaName;
    public bool bFutanari;
    public int categoryMotionList = -1;
    public float changeAutoMotionTimeMax;
    public float changeAutoMotionTimeMin;
    public AnimationCurve changeMotionCurve;
    public float changeMotionMinRate;
    public float changeMotionTimeMax;
    public float changeMotionTimeMin;
    [Range(0.001f, 1f)] public float charaMoveSpeed = 0.05f;
    [Range(0.5f, 3f)] public float charaMoveSpeedAddRate = 1f;
    [Range(0.001f, 10f)] public float charaRotaionSpeed = 4f;
    public ClickKind click;
    [Tooltip("どの汁を制御するか")] public string ctrlSiru;
    public int ctrlSiruType;
    public int FaintnessType = -1;
    [Range(0f, 1f)] public float feel_f;
    [Range(0f, 1f)] public float feel_m;
    public float feelPain;
    [Range(0f, 1f)] public float feelSpnking;
    [Range(0f, 1f)] public float guageDecreaseRate;
    public float HBeforeHouchiTime;
    [Tooltip("Hポイントのマーカーを識別するID")] public int HPointID;
    public int initiative;
    public bool isAutoActionChange;
    public bool isFaintness;
    public bool isFaintnessVoice;
    public bool isGaugeHit;
    public bool isGaugeHit_M;
    public bool isInsert;
    public List<JudgeSelect> isJudgeSelect = new List<JudgeSelect>();
    public bool isLeaveItToYou;
    public bool isNotCtrl = true;
    public bool isPainAction;
    public bool isPainActionParam;
    public bool isUrine;
    public CharaCtrlKind kindCharaCtrl = CharaCtrlKind.None;
    public Light Light;

    public LoopSpeeds loopSpeeds = new LoopSpeeds
    {
        minLoopSpeedW = 1f,
        maxLoopSpeedW = 1.6f,
        minLoopSpeedS = 1.4f,
        maxLoopSpeedS = 2f,
        minLoopSpeedO = 1.4f,
        maxLoopSpeedO = 2f
    };

    [Tooltip("0:弱ループ 1:強ループ 2:絶頂前ループ 3:中ループ -1:その他")]
    public int loopType;

    public MasterbationLoopSpeeds masterbationSpeeds = new MasterbationLoopSpeeds
    {
        minLoopSpeedW = 1f,
        maxLoopSpeedW = 1.6f,
        minLoopSpeedS = 1.4f,
        maxLoopSpeedS = 2f,
        minLoopSpeedO = 1.4f,
        maxLoopSpeedO = 2f,
        minLoopSpeedM = 1f,
        maxLoopSpeedM = 1.6f
    };

    [Range(0f, 1f)] public float[] motions;
    [SerializeField] public HScene.AnimationListInfo nowAnimationInfo = new HScene.AnimationListInfo();
    public HPoint nowHPoint;
    public bool nowOrgasm;
    public bool nowSpeedStateFast;
    [Tooltip("現在の場所を示すID")] public int nPlace;
    public int numAibu;
    public int numAnal;
    public int numAnalOrgasm;
    public int numDrink;
    public int numFaintness;
    public int numHoushi;
    public int numInside;
    public int numKokan;
    public int numLeadFemale;
    public int numLes;
    public int numMulti;
    public int numOrgasm;
    public int numOrgasmF2;
    public int numOrgasmM2;
    public int numOrgasmSecond;
    public int numOrgasmTotal;
    public int numOutSide;

    [Tooltip("通常絶頂回数もカウントされます 同時絶頂したら、こいつも+1、絶頂回数も+1、中出しか外出しも+1")]
    public int numSameOrgasm;

    public int numShotF2;
    public int numShotM2;
    public int numSonyu;
    public int numUrine;
    public int numVomit;
    public float peepingFadeW = 0.75f;
    public float peepingFadeY = 0.62f;
    public int peepingLoopNumW = 3;
    public int peepingLoopNumY = 3;
    public int peepingOutLoopNumW = 2;
    public int peepingOutLoopNumY = 2;
    public bool pointMoveAnimChange;
    [Range(0f, 1f)] public float rateNip;
    [Range(0f, 1f)] public float rateNipMax = 0.3f;
    [Range(0f, 1f)] public float rateTuya;
    [Range(0f, 1f)] public float rateWet;

    [Tooltip("0:Obi\u30001:パーティクル\u30002:なし")]
    public int semenType = 1;

    [Range(0f, 1f)] public float siriakaAddRate;
    [Range(0f, 1f)] public float siriakaDecreaseRate;
    [Range(0f, 2f)] public float speed;
    [Range(0f, 1f)] public float speedGuageRate = 0.01f;
    public float StartHouchiTime;
    public bool stopFeelFemale;
    public bool stopFeelMale;
    public Light[] SubLights = new Light[2];
    public float timeMasturbationChangeSpeed;
    [SerializeField] private List<int> urineIDs = new List<int> {3};
    public VoiceFlag voice = new VoiceFlag();
    [Tooltip("ホイール一回でどれだけ回したことにするか")] public float wheelActionCount = 0.05f;
    [Tooltip("0～100％で(小数不可)")] public int YobaiBareRate = 50;

    public readonly int gotoFaintnessCount = 3;
    public CameraControl_Ver2 cameraCtrl;
    private Dictionary<int, Dictionary<int, int>> EndAddTaiiParam = new Dictionary<int, Dictionary<int, int>>();
    private Dictionary<int, Dictionary<int, int[]>> FinishResistTaii = new Dictionary<int, Dictionary<int, int[]>>();

    public List<int>[,] lstSyncAnimLayers = new List<int>[2, 2];

    private bool[] mindJudge = new bool[4];
    private InputField nowInputForcus;
    public List<int> UrineIDs => urineIDs;
    public bool inputForcus => nowInputForcus != null && nowInputForcus.isFocused;
    public HScene.AnimationListInfo selectAnimationListInfo { get; set; }

    [Serializable]
    public struct LoopSpeeds
    {
        [Header("弱：最小")] public float minLoopSpeedW;
        [Header("弱：最大")] public float maxLoopSpeedW;
        [Header("強：最小")] public float minLoopSpeedS;
        [Header("強：最大")] public float maxLoopSpeedS;
        [Header("絶頂前：最小")] public float minLoopSpeedO;
        [Header("絶頂前：最大")] public float maxLoopSpeedO;
    }

    [Serializable]
    public struct MasterbationLoopSpeeds
    {
        [Header("弱：最小")] public float minLoopSpeedW;
        [Header("弱：最大")] public float maxLoopSpeedW;
        [Header("中：最小")] public float minLoopSpeedM;
        [Header("中：最大")] public float maxLoopSpeedM;
        [Header("強：最小")] public float minLoopSpeedS;
        [Header("強：最大")] public float maxLoopSpeedS;
        [Header("絶頂前：最小")] public float minLoopSpeedO;
        [Header("絶頂前：最大")] public float maxLoopSpeedO;
    }

    [Serializable]
    public class VoiceFlag
    {
        public bool dialog;
        public List<string> lstUseAsset = new List<string>();
        public List<AnimType> newAnimType = new List<AnimType>();
        public List<AnimType> oldAnimType = new List<AnimType>();
        public int oldFinish = -1;
        public int onaniEnterLoop;
        public int[] playShorts = {-1, -1};
        public int playStart = -1;
        public int playStartOld = -1;
        public bool[] playVoices = new bool[2];
        public bool sleep;
        public bool urineFlag;
        public bool[] urines = new bool[2];
        public Transform[] voiceTrs = new Transform[2];

        public void MemberInit()
        {
            playVoices = new bool[2];
            playShorts = new[] {-1, -1};
            oldFinish = -1;
            playStart = -1;
            dialog = false;
            urines = new bool[2];
            sleep = false;
            playStartOld = -1;
            voiceTrs = new Transform[2];
            lstUseAsset = new List<string>();
            oldAnimType = new List<AnimType>();
            newAnimType = new List<AnimType>();
        }
    }
}