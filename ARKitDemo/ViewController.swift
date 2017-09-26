//
//  ViewController.swift
//  ARKitDemo
//
//  Created by Minni K Ang on 2017-09-26.
//  Copyright © 2017 CreativeIce. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        sceneView.session.run(configuration)
    }
    
    func addModel(name: String, position: SCNVector3) {
        let model = Model()
        model.loadModel(named: name)
        model.position = position
        
        sceneView.scene.rootNode.addChildNode(model)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: sceneView)
        let results = sceneView.hitTest(touchPoint, types: [.featurePoint])
        
        guard let result = results.last else {
            popUpWarning()
            return
        }
        let hitTransform = SCNMatrix4(result.worldTransform)
        let position = SCNVector3Make(hitTransform.m41, hitTransform.m42, hitTransform.m43)
        
        addModel(name: "cup", position: position)
    }
    
    @IBAction func chooseObjectToPlace(_ sender: Any) {
    }
    
    func popUpWarning() {
        let popUp = UIAlertController(title: "Insufficient context!", message: "Move your device around so it can see more features in your environment", preferredStyle: .alert)
        let popUpAction = UIAlertAction(title: "OK", style: .cancel)
        popUp.addAction(popUpAction)
        present(popUp, animated: true, completion: nil)
    }
}

