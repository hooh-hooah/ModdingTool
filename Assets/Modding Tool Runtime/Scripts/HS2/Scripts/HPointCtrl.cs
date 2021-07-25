using System.Collections.Generic;
using RootMotion;
using UnityEngine;

#pragma warning disable 0168
#pragma warning disable 0219
#pragma warning disable 0414
#pragma warning disable 649
public class HPointCtrl : Singleton<HPointCtrl>
{
    [SerializeField] private HSceneFlagCtrl ctrlFlag;
    [SerializeField] private HPointList hPointList;
    [SerializeField] private HScene hScene;
    public List<HScene.AnimationListInfo>[] lstAnimInfo = new List<HScene.AnimationListInfo>[7];

    public HPointList HPointList
    {
        get => hPointList;
        set => hPointList = value;
    }
}