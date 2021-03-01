using UnityEngine;
using Random = UnityEngine.Random;


public class SoundContainer : MonoBehaviour
{
    private AudioSource source;
    public AudioClip[] clips;
    public float pLow;
    public float pHigh;

    private void Start()
    {
        if (source == null) source = gameObject.AddComponent<AudioSource>();
        source.spatialBlend = 1f;
        source.minDistance = 0.2f;
        source.maxDistance = 6f;
        source.spread = 0f;
        source.dopplerLevel = 1f;
    }

    public void PlayRandomSound()
    {
        if (clips.Length == 0) return;
        var id = Random.Range(0, clips.Length);
        var clip = clips[id];
        source.pitch = Random.Range(pLow, pHigh);
        source.PlayOneShot(clip);
    }
}