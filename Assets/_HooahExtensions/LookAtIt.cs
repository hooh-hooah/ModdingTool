using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LookAtIt : MonoBehaviour {
    GameObject target;
    public GameObject turnObject;
	// Use this for initialization
	void Awake () {
        StartCoroutine("FindTarget");
    }

    IEnumerator FindTarget() {
        while (true) {
            yield return new WaitForSeconds(.5f);

            if (target != null) {
                LookAtMe lam = gameObject.GetComponentInChildren<LookAtMe>();
                if (lam == null || lam.gameObject != target) {target = null;}
            }

            if (target == null) {
                LookAtMe lam = gameObject.GetComponentInChildren<LookAtMe>();
                if (lam != null) {
                    target = lam.gameObject;
                }
            }
        }
    }

	// Update is called once per frame
	void Update () {
        if (target != null) {
            turnObject.transform.LookAt(target.transform);
        } else {
            // maybe kickstart goddamn shits?
        }
	}
}
