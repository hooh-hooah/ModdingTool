using UnityEngine;

namespace FBSAssist
{
    // Token: 0x02001034 RID: 4148
    public class AudioAssist
    {
        // Token: 0x04006CF2 RID: 27890
        private float[] _samples = new float[1024];

        // Token: 0x04006CF1 RID: 27889
        private float beforeVolume;

        // Token: 0x06008670 RID: 34416 RVA: 0x00349EC8 File Offset: 0x003482C8
        private float RMS(ref float[] samples)
        {
            var num = 0f;
            for (var i = 0; i < samples.Length; i++) num += samples[i] * samples[i];
            num /= samples.Length;
            return Mathf.Sqrt(num);
        }

        // Token: 0x06008671 RID: 34417 RVA: 0x00349F0C File Offset: 0x0034830C
        public float GetAudioWaveValue(AudioSource audioSource, float correct = 2f)
        {
            var result = 0f;
            if (!audioSource.clip) return result;
            if (audioSource.isPlaying)
            {
                var max = 1f;
                var num = audioSource.clip.samples * audioSource.clip.channels - audioSource.timeSamples;
                if (num <= 1024) return result;
                audioSource.clip.GetData(_samples, audioSource.timeSamples);
                var num2 = RMS(ref _samples);
                var num3 = Mathf.Clamp(num2 * correct, 0f, max);
                if (num3 < beforeVolume)
                    result = num3 * 0.2f + beforeVolume * 0.8f;
                else
                    result = (num3 + beforeVolume) * 0.5f;
                beforeVolume = num3;
            }

            return result;
        }
    }
}