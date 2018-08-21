using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class MeshSpliter : MonoBehaviour
{

	public Renderer TargetRenderer;
	public GameObject TargetCenterPos;
	[Range(0, 1)]
	public float Distance = 0.5f;

	private Material m_TargetMat;

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		if (m_TargetMat == null) {
			m_TargetMat = TargetRenderer.sharedMaterial;
		}

		// set position
		Vector3 worldTargetPos = TargetCenterPos.transform.position;
		Vector3 worldMoveVector = transform.localToWorldMatrix.MultiplyVector (new Vector3(0, 0, -Distance));
		transform.position = worldTargetPos + worldMoveVector;

		// set material
		Matrix4x4 world2SpliterMatrix = transform.worldToLocalMatrix;
		m_TargetMat.SetMatrix ("_World2SpliterMatrix", world2SpliterMatrix);
	}
}
