namespace ADV
{
    // Token: 0x02000440 RID: 1088
    public enum Command
    {
        // Token: 0x04002533 RID: 9523
        None,

        // Token: 0x04002534 RID: 9524
        VAR,

        // Token: 0x04002535 RID: 9525
        RandomVar,

        // Token: 0x04002536 RID: 9526
        Calc,

        // Token: 0x04002537 RID: 9527
        Clamp,

        // Token: 0x04002538 RID: 9528
        Min,

        // Token: 0x04002539 RID: 9529
        Max,

        // Token: 0x0400253A RID: 9530
        Lerp,

        // Token: 0x0400253B RID: 9531
        LerpAngle,

        // Token: 0x0400253C RID: 9532
        InverseLerp,

        // Token: 0x0400253D RID: 9533
        LerpV3,

        // Token: 0x0400253E RID: 9534
        LerpAngleV3,

        // Token: 0x0400253F RID: 9535
        Tag,

        // Token: 0x04002540 RID: 9536
        Format,

        // Token: 0x04002541 RID: 9537
        IF,

        // Token: 0x04002542 RID: 9538
        Switch,

        // Token: 0x04002543 RID: 9539
        Text,

        // Token: 0x04002544 RID: 9540
        Voice,

        // Token: 0x04002545 RID: 9541
        Motion,

        // Token: 0x04002546 RID: 9542
        Expression,

        // Token: 0x04002547 RID: 9543
        ExpressionIcon,

        // Token: 0x04002548 RID: 9544
        Open,

        // Token: 0x04002549 RID: 9545
        Close,

        // Token: 0x0400254A RID: 9546
        Jump,

        // Token: 0x0400254B RID: 9547
        Choice,

        // Token: 0x0400254C RID: 9548
        Wait,

        // Token: 0x0400254D RID: 9549
        TextClear,

        // Token: 0x0400254E RID: 9550
        FontColor,

        // Token: 0x0400254F RID: 9551
        WindowActive,

        // Token: 0x04002550 RID: 9552
        WindowImage,

        // Token: 0x04002551 RID: 9553
        Scene,

        // Token: 0x04002552 RID: 9554
        Regulate,

        // Token: 0x04002553 RID: 9555
        Replace,

        // Token: 0x04002554 RID: 9556
        Reset,

        // Token: 0x04002555 RID: 9557
        Vector,

        // Token: 0x04002556 RID: 9558
        NullLoad,

        // Token: 0x04002557 RID: 9559
        NullRelease,

        // Token: 0x04002558 RID: 9560
        NullSet,

        // Token: 0x04002559 RID: 9561
        BGLoad,

        // Token: 0x0400255A RID: 9562
        BGRelease,

        // Token: 0x0400255B RID: 9563
        BGVisible,

        // Token: 0x0400255C RID: 9564
        InfoAudioEco,

        // Token: 0x0400255D RID: 9565
        InfoAnimePlay,

        // Token: 0x0400255E RID: 9566
        Fade,

        // Token: 0x0400255F RID: 9567
        FadeColor,

        // Token: 0x04002560 RID: 9568
        SceneFade,

        // Token: 0x04002561 RID: 9569
        SceneFadeRegulate,

        // Token: 0x04002562 RID: 9570
        FilterImageLoad,

        // Token: 0x04002563 RID: 9571
        FilterImageRelease,

        // Token: 0x04002564 RID: 9572
        EjaculationEffect,

        // Token: 0x04002565 RID: 9573
        EcstacyEffect,

        // Token: 0x04002566 RID: 9574
        EcstacySyncEffect,

        // Token: 0x04002567 RID: 9575
        CrossFade,

        // Token: 0x04002568 RID: 9576
        CameraActive,

        // Token: 0x04002569 RID: 9577
        CameraAspect,

        // Token: 0x0400256A RID: 9578
        CameraChange,

        // Token: 0x0400256B RID: 9579
        CameraDirectionAdd,

        // Token: 0x0400256C RID: 9580
        CameraDirectionSet,

        // Token: 0x0400256D RID: 9581
        CameraLerpNullMove,

        // Token: 0x0400256E RID: 9582
        CameraLerpNullSet,

        // Token: 0x0400256F RID: 9583
        CameraLerpAdd,

        // Token: 0x04002570 RID: 9584
        CameraLerpSet,

        // Token: 0x04002571 RID: 9585
        CameraLerpAnimationAdd,

        // Token: 0x04002572 RID: 9586
        CameraLerpAnimationSet,

        // Token: 0x04002573 RID: 9587
        CameraLerpTargetAdd,

        // Token: 0x04002574 RID: 9588
        CameraLerpTargetSet,

        // Token: 0x04002575 RID: 9589
        CameraPositionAdd,

        // Token: 0x04002576 RID: 9590
        CameraPositionSet,

        // Token: 0x04002577 RID: 9591
        CameraRotationAdd,

        // Token: 0x04002578 RID: 9592
        CameraRotationSet,

        // Token: 0x04002579 RID: 9593
        CameraDefault,

        // Token: 0x0400257A RID: 9594
        CameraParent,

        // Token: 0x0400257B RID: 9595
        CameraNull,

        // Token: 0x0400257C RID: 9596
        CameraTarget,

        // Token: 0x0400257D RID: 9597
        CameraTargetFront,

        // Token: 0x0400257E RID: 9598
        CameraTargetCharacter,

        // Token: 0x0400257F RID: 9599
        CameraReset,

        // Token: 0x04002580 RID: 9600
        CameraLock,

        // Token: 0x04002581 RID: 9601
        CameraGetFov,

        // Token: 0x04002582 RID: 9602
        CameraSetFov,

        // Token: 0x04002583 RID: 9603
        BGMPlay,

        // Token: 0x04002584 RID: 9604
        BGMStop,

        // Token: 0x04002585 RID: 9605
        EnvPlay,

        // Token: 0x04002586 RID: 9606
        EnvStop,

        // Token: 0x04002587 RID: 9607
        SE2DPlay,

        // Token: 0x04002588 RID: 9608
        SE2DStop,

        // Token: 0x04002589 RID: 9609
        SE3DPlay,

        // Token: 0x0400258A RID: 9610
        SE3DStop,

        // Token: 0x0400258B RID: 9611
        CharaCreate,

        // Token: 0x0400258C RID: 9612
        CharaFixCreate,

        // Token: 0x0400258D RID: 9613
        CharaMobCreate,

        // Token: 0x0400258E RID: 9614
        CharaDelete,

        // Token: 0x0400258F RID: 9615
        CharaStand,

        // Token: 0x04002590 RID: 9616
        CharaStandFind,

        // Token: 0x04002591 RID: 9617
        CharaPositionAdd,

        // Token: 0x04002592 RID: 9618
        CharaPositionSet,

        // Token: 0x04002593 RID: 9619
        CharaPositionLocalAdd,

        // Token: 0x04002594 RID: 9620
        CharaPositionLocalSet,

        // Token: 0x04002595 RID: 9621
        CharaMotion,

        // Token: 0x04002596 RID: 9622
        CharaMotionDefault,

        // Token: 0x04002597 RID: 9623
        CharaMotionWait,

        // Token: 0x04002598 RID: 9624
        CharaMotionLayerWeight,

        // Token: 0x04002599 RID: 9625
        CharaMotionSetParam,

        // Token: 0x0400259A RID: 9626
        CharaMotionIKSetPartner,

        // Token: 0x0400259B RID: 9627
        CharaExpression,

        // Token: 0x0400259C RID: 9628
        CharaFixEyes,

        // Token: 0x0400259D RID: 9629
        CharaFixMouth,

        // Token: 0x0400259E RID: 9630
        CharaExpressionIcon,

        // Token: 0x0400259F RID: 9631
        CharaGetShape,

        // Token: 0x040025A0 RID: 9632
        CharaCoordinate,

        // Token: 0x040025A1 RID: 9633
        CharaClothState,

        // Token: 0x040025A2 RID: 9634
        CharaSiruState,

        // Token: 0x040025A3 RID: 9635
        CharaVoicePlay,

        // Token: 0x040025A4 RID: 9636
        CharaVoiceStop,

        // Token: 0x040025A5 RID: 9637
        CharaVoiceStopAll,

        // Token: 0x040025A6 RID: 9638
        CharaVoiceWait,

        // Token: 0x040025A7 RID: 9639
        CharaVoiceWaitAll,

        // Token: 0x040025A8 RID: 9640
        CharaLookEyes,

        // Token: 0x040025A9 RID: 9641
        CharaLookEyesTarget,

        // Token: 0x040025AA RID: 9642
        CharaLookEyesTargetChara,

        // Token: 0x040025AB RID: 9643
        CharaLookNeck,

        // Token: 0x040025AC RID: 9644
        CharaLookNeckTarget,

        // Token: 0x040025AD RID: 9645
        CharaLookNeckTargetChara,

        // Token: 0x040025AE RID: 9646
        CharaLookNeckSkip,

        // Token: 0x040025AF RID: 9647
        CharaItemCreate,

        // Token: 0x040025B0 RID: 9648
        CharaItemDelete,

        // Token: 0x040025B1 RID: 9649
        CharaItemAnime,

        // Token: 0x040025B2 RID: 9650
        CharaItemFind,

        // Token: 0x040025B3 RID: 9651
        EventCGSetting,

        // Token: 0x040025B4 RID: 9652
        EventCGRelease,

        // Token: 0x040025B5 RID: 9653
        EventCGNext,

        // Token: 0x040025B6 RID: 9654
        ObjectCreate,

        // Token: 0x040025B7 RID: 9655
        ObjectLoad,

        // Token: 0x040025B8 RID: 9656
        ObjectDelete,

        // Token: 0x040025B9 RID: 9657
        ObjectPosition,

        // Token: 0x040025BA RID: 9658
        ObjectRotation,

        // Token: 0x040025BB RID: 9659
        ObjectScale,

        // Token: 0x040025BC RID: 9660
        ObjectParent,

        // Token: 0x040025BD RID: 9661
        ObjectComponent,

        // Token: 0x040025BE RID: 9662
        ObjectAnimeParam,

        // Token: 0x040025BF RID: 9663
        MoviePlay,

        // Token: 0x040025C0 RID: 9664
        CharaActive,

        // Token: 0x040025C1 RID: 9665
        CharaVisible,

        // Token: 0x040025C2 RID: 9666
        CharaColor,

        // Token: 0x040025C3 RID: 9667
        CharaParam,

        // Token: 0x040025C4 RID: 9668
        CharaChange,

        // Token: 0x040025C5 RID: 9669
        CharaNameGet,

        // Token: 0x040025C6 RID: 9670
        CharaEvent,

        // Token: 0x040025C7 RID: 9671
        HeroineCallNameChange,

        // Token: 0x040025C8 RID: 9672
        HeroineFinCG,

        // Token: 0x040025C9 RID: 9673
        HeroineParam,

        // Token: 0x040025CA RID: 9674
        PlayerParam,

        // Token: 0x040025CB RID: 9675
        CycleChange,

        // Token: 0x040025CC RID: 9676
        WeekChange,

        // Token: 0x040025CD RID: 9677
        MapChange,

        // Token: 0x040025CE RID: 9678
        MapUnload,

        // Token: 0x040025CF RID: 9679
        MapVisible,

        // Token: 0x040025D0 RID: 9680
        MapObjectActive,

        // Token: 0x040025D1 RID: 9681
        DayTimeChange,

        // Token: 0x040025D2 RID: 9682
        GetGatePos,

        // Token: 0x040025D3 RID: 9683
        CameraLookAt,

        // Token: 0x040025D4 RID: 9684
        MozVisible,

        // Token: 0x040025D5 RID: 9685
        LookAtDankonAdd,

        // Token: 0x040025D6 RID: 9686
        LookAtDankonRemove,

        // Token: 0x040025D7 RID: 9687
        HMotionShakeAdd,

        // Token: 0x040025D8 RID: 9688
        HMotionShakeRemove,

        // Token: 0x040025D9 RID: 9689
        HitReaction,

        // Token: 0x040025DA RID: 9690
        AddPosture,

        // Token: 0x040025DB RID: 9691
        AddCollider,

        // Token: 0x040025DC RID: 9692
        ColliderSetActive,

        // Token: 0x040025DD RID: 9693
        AddNavMeshAgent,

        // Token: 0x040025DE RID: 9694
        NavMeshAgentSetActive,

        // Token: 0x040025DF RID: 9695
        BundleCheck,

        // Token: 0x040025E0 RID: 9696
        CharaPersonal,

        // Token: 0x040025E1 RID: 9697
        HNamaOK,

        // Token: 0x040025E2 RID: 9698
        HNamaNG,

        // Token: 0x040025E3 RID: 9699
        CameraShakePos,

        // Token: 0x040025E4 RID: 9700
        CameraShakeRot,

        // Token: 0x040025E5 RID: 9701
        Prob,

        // Token: 0x040025E6 RID: 9702
        Probs,

        // Token: 0x040025E7 RID: 9703
        FormatVAR,

        // Token: 0x040025E8 RID: 9704
        CharaKaraokePlay,

        // Token: 0x040025E9 RID: 9705
        CharaKaraokeStop,

        // Token: 0x040025EA RID: 9706
        Task,

        // Token: 0x040025EB RID: 9707
        TaskWait,

        // Token: 0x040025EC RID: 9708
        TaskEnd,

        // Token: 0x040025ED RID: 9709
        ParameterFile,

        // Token: 0x040025EE RID: 9710
        Log,

        // Token: 0x040025EF RID: 9711
        HSafeDaySet,

        // Token: 0x040025F0 RID: 9712
        HDangerDaySet,

        // Token: 0x040025F1 RID: 9713
        HeroineWeddingInfo,

        // Token: 0x040025F2 RID: 9714
        CameraLightOffset,

        // Token: 0x040025F3 RID: 9715
        CharaSetShape,

        // Token: 0x040025F4 RID: 9716
        CharaCoordinateChange,

        // Token: 0x040025F5 RID: 9717
        CharaShoesChange,

        // Token: 0x040025F6 RID: 9718
        CameraAnimeLoad,

        // Token: 0x040025F7 RID: 9719
        CameraAnimePlay,

        // Token: 0x040025F8 RID: 9720
        CameraAnimeWait,

        // Token: 0x040025F9 RID: 9721
        CameraAnimeLayerWeight,

        // Token: 0x040025FA RID: 9722
        CameraAnimeSetParam,

        // Token: 0x040025FB RID: 9723
        CameraAnimeRelease,

        // Token: 0x040025FC RID: 9724
        CameraLightActive,

        // Token: 0x040025FD RID: 9725
        CameraLightAngle,

        // Token: 0x040025FE RID: 9726
        InfoAudio,

        // Token: 0x040025FF RID: 9727
        CharaCreateEmpty,

        // Token: 0x04002600 RID: 9728
        CharaCreateDummy,

        // Token: 0x04002601 RID: 9729
        CharaFixCreateDummy,

        // Token: 0x04002602 RID: 9730
        CharaMobCreateDummy,

        // Token: 0x04002603 RID: 9731
        ReplaceLanguage,

        // Token: 0x04002604 RID: 9732
        SendCommandData,

        // Token: 0x04002605 RID: 9733
        SendCommandDataList,

        // Token: 0x04002606 RID: 9734
        IFVAR,

        // Token: 0x04002607 RID: 9735
        CreateConcierge,

        // Token: 0x04002608 RID: 9736
        SceneFadeWait,

        // Token: 0x04002609 RID: 9737
        DOFTargetMove,

        // Token: 0x0400260A RID: 9738
        DOFTargetSet,

        // Token: 0x0400260B RID: 9739
        BlurEffect,

        // Token: 0x0400260C RID: 9740
        DOFTarget,

        // Token: 0x0400260D RID: 9741
        SepiaEffect,

        // Token: 0x0400260E RID: 9742
        VarLanguage,

        // Token: 0x0400260F RID: 9743
        TransitionFade,

        // Token: 0x04002610 RID: 9744
        TransitionFadeTexture,

        // Token: 0x04002611 RID: 9745
        SceneFadeColor,

        // Token: 0x04002612 RID: 9746
        SceneFadeTime,

        // Token: 0x04002613 RID: 9747
        MapObjectAnimation,

        // Token: 0x04002614 RID: 9748
        NowLoadingDraw,

        // Token: 0x04002615 RID: 9749
        DOFDefault,

        // Token: 0x04002616 RID: 9750
        WaitAbs,

        // Token: 0x04002617 RID: 9751
        CharaWet
    }
}