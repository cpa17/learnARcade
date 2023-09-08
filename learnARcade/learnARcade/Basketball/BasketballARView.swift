//
//  BasketballARView.swift
//  learnARcade
//
//  Created by Pascal Ahlner on 08.09.23.
//

import Combine
import ARKit
import RealityKit


// MARK: - Init

class BasketballARView: ARView {
    
    func configuration() {
        
        let session = self.session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        session.run(config)

        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.session = session
        coachingOverlay.goal = .horizontalPlane
        self.addSubview(coachingOverlay)
    }
}


private extension BasketballARView {
    
    
}
