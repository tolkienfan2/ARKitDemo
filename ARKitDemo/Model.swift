//
//  Model.swift
//  ARKitDemo
//
//  Created by Minni K Ang on 2017-09-26.
//  Copyright © 2017 CreativeIce. All rights reserved.
//

import ARKit

class Model: SCNNode {
    
    func loadModel(named: String) {
        guard let model = SCNScene(named: "Models.scnassets/\(named)/\(named).scn") else { return }
        
        let wrapper = SCNNode()
        
        for child in model.rootNode.childNodes {
            wrapper.addChildNode(child)
        }
        
        self.addChildNode(wrapper)
    }
}
