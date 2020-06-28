using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using UnityEngine;

public class HScene : MonoBehaviour
{
    [Serializable]
    public class AnimationListInfo
    {
        public int id = -1;
        public string nameAnimation = "";
        public string assetpathBaseM = "";
        public string assetBaseM = "";
        public string assetpathMale = "";
        public string fileMale = "";
        public bool isMaleHitObject;
        public string fileMotionNeckMale;
        public string assetpathBaseM2 = "";
        public string assetBaseM2 = "";
        public string assetpathMale2 = "";
        public string fileMale2 = "";
        public bool isMaleHitObject2;
        public string fileMotionNeckMale2;
        public string assetpathBaseF = "";
        public string assetBaseF = "";
        public string assetpathFemale;
        public string fileFemale;
        public bool isFemaleHitObject;
        public string fileMotionNeckFemale;
        public string fileMotionNeckFemalePlayer;
        public string assetpathBaseF2 = "";
        public string assetBaseF2 = "";
        public string assetpathFemale2 = "";
        public string fileFemale2 = "";
        public bool isFemaleHitObject2;
        public string fileMotionNeckFemale2;
        public ValueTuple<int, int> ActionCtrl = new ValueTuple<int, int>(-1, -1);
        public List<int> nPositons = new List<int>();
        public List<string> lstOffset = new List<string>();
        public bool isNeedItem;
        public int nDownPtn;
        public List<int> nStatePtns = new List<int>();
        public int nFaintnessLimit;
        public int nIyaAction = 1;
        public List<int> Achievments = new List<int>();
        public int nInitiativeFemale;
        public int nBackInitiativeID = -1;
        public List<int> lstSystem = new List<int>();
        public int nMaleSon = -1;
        public int[] nFemaleUpperCloths = new int[] {-1, -1};
        public int[] nFemaleLowerCloths = new int[] {-1, -1};
        public int nFeelHit;
        public string nameCamera;
        public string fileSiruPaste;
        public string fileSiruPasteSecond = "";
        public string fileSe;
        public int nShortBreahtPlay = 1;
        public HashSet<int> hasVoiceCategory = new HashSet<int>();
        public int nPromiscuity = -1;
        public bool reverseTaii;
        public List<int[]> Event = new List<int[]>();
        public int ParmID = -1;
    }
}