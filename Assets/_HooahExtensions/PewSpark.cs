using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PewSpark : MonoBehaviour {
    public ParticleSystem[] emitters;
	
    public void FireEmitter() {
        foreach (var emitter in emitters) {
            emitter.Emit(1);
            emitter.randomSeed = (uint)Random.Range(0, 1000);
        }
    }
}
