using System;
using System.Collections.Generic;
using UnityEngine;


#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649
public class HScene : MonoBehaviour
{
    [Serializable]
    public class AnimationListInfo
    {
        public List<int> Achievments = new List<int>();
        public string assetBaseF = "";
        public string assetBaseF2 = "";
        public string assetBaseM = "";
        public string assetBaseM2 = "";
        public string assetpathBaseF = "";
        public string assetpathBaseF2 = "";
        public string assetpathBaseM = "";
        public string assetpathBaseM2 = "";
        public string assetpathFemale;
        public string assetpathFemale2 = "";
        public string assetpathMale = "";
        public string assetpathMale2 = "";
        public string fileFemale;
        public string fileFemale2 = "";
        public string fileMale = "";
        public string fileMale2 = "";
        public string fileMotionNeckFemale;
        public string fileMotionNeckFemale2;
        public string fileMotionNeckFemalePlayer;
        public string fileMotionNeckMale;
        public string fileMotionNeckMale2;
        public string fileSe;
        public string fileSiruPaste;
        public string fileSiruPasteSecond = "";
        public int id = -1;
        public bool isFemaleHitObject;
        public bool isFemaleHitObject2;
        public bool isMaleHitObject;
        public bool isMaleHitObject2;
        public bool isNeedItem;
        public List<string> lstOffset = new List<string>();
        public List<int> lstSystem = new List<int>();
        public string nameAnimation = "";
        public string nameCamera;
        public int nBackInitiativeID = -1;
        public int nDownPtn;
        public int nFaintnessLimit;
        public int nFeelHit;
        public int[] nFemaleLowerCloths = {-1, -1};
        public int[] nFemaleUpperCloths = {-1, -1};
        public int nInitiativeFemale;
        public int nIyaAction = 1;
        public int nMaleSon = -1;
        public List<int> nPositons = new List<int>();
        public int nPromiscuity = -1;
        public int nShortBreahtPlay = 1;
        public List<int> nStatePtns = new List<int>();
        public int ParmID = -1;
        public bool reverseTaii;
        public ValueTuple<int, int> ActionCtrl = new ValueTuple<int, int>(-1, -1);
        public List<int[]> Event = new List<int[]>();
        public HashSet<int> hasVoiceCategory = new HashSet<int>();
    }
}