using System;
using System.Linq;
using UnityEngine;
using Random = System.Random;

public class NomiEventConsumer : EventConsumer
{
    public int eventThresold = 5;
    public AudioClip[] _audioClips;
    [SerializeField] private Animator _animator;
    [SerializeField] private AudioSource audioPlayer;
    private int _eventStored = 0;
    private readonly Random _random = new Random();

    private void Awake()
    {
    }

    internal override void DoEvent()
    {
        _eventStored++;
        if (_eventStored < eventThresold) return;
        _eventStored = 0;
        _animator.Play("nomi", -1, 0f);
    }

    private void PlaySound()
    {
        if (!_audioClips.Any() || audioPlayer == null) return;
        audioPlayer.Stop();
        var randomIndex = _random.Next(0, _audioClips.Length - 1);
        audioPlayer.pitch =  (_animator != null ? _animator.speed : 1f) + Convert.ToSingle(_random.NextDouble()*0.4);
        audioPlayer.PlayOneShot(_audioClips[randomIndex]);
    }
}