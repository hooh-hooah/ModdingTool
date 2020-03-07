using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PewSpark : MonoBehaviour {
    public ParticleSystem[] emitters;
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		
	}

    public void FireEmitter() {
        foreach (var emitter in emitters) {
            emitter.Emit(1);
        }
    }
}
