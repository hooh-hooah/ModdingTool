using UnityEngine;
using System.Collections;

public class DynamicBoneDemo1 : MonoBehaviour
{
    public GameObject m_Player;

    void Update()
    {
        m_Player.transform.Rotate(new Vector3(0, Input.GetAxis("Horizontal") * Time.deltaTime * 200, 0));
        m_Player.transform.Translate(transform.forward * Input.GetAxis("Vertical") * Time.deltaTime * 4);
    }

    void OnGUI()
    {
        GUI.Label(new Rect(50, 50, 200, 20), "Press arrow key to move");
        Animation a = m_Player.GetComponentInChildren<Animation>();
        a.enabled = GUI.Toggle(new Rect(50, 70, 200, 20), a.enabled, "Play Animation");

        DynamicBone[] db = m_Player.GetComponents<DynamicBone>();
        GUI.Label(new Rect(50, 100, 200, 20), "Choose dynamic bone:");
        db[0].enabled = db[1].enabled = GUI.Toggle(new Rect(50, 120, 100, 20), db[0].enabled, "Breasts");
        db[2].enabled = GUI.Toggle(new Rect(50, 140, 100, 20), db[2].enabled, "Tail");
    }
}
