//
//  FootballballARView.swift
//  learnARcade
//
//  Created by Pascal Ahlner on 08.09.23.
//

import Combine
import ARKit
import RealityKit


// MARK: - Init

class FootballballARView: ARView {
    
    private var footballAnchor: Football._Football?
    
    func configuration() {
        
        let session = self.session
        session.run(self.arConfiguration)
        
        self.addSubview(self.coachingOverlay)
        
        do {
            self.footballAnchor = try Football.load_Football()
        } catch {
            fatalError(error.localizedDescription)
        }
        
        guard let footballAnchor else {
            return
        }
        
        self.scene.addAnchor(footballAnchor)
    }
}


private extension FootballballARView {
    
    var arConfiguration: ARWorldTrackingConfiguration {
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        return configuration
    }
    
    var coachingOverlay: ARCoachingOverlayView {
        
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.session = session
        coachingOverlay.goal = .horizontalPlane
        
        return coachingOverlay
    }
}
