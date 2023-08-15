//
//  DiceARView.swift
//  learnARcade
//
//  Created by Pascal Ahlner on 15.08.23.
//

import ARKit
import RealityKit


// MARK: - Init

class DiceARView: ARView {
    
    private var diceAnchor: Dice._Dice?
    var isRolling = false
    var count = 1
    
    override init(
        frame frameRect: CGRect,
        cameraMode: ARView.CameraMode,
        automaticallyConfigureSession: Bool
    ) {
        super.init(
            frame: frameRect,
            cameraMode: cameraMode,
            automaticallyConfigureSession: automaticallyConfigureSession
        )
        
        self.setupUI()
    }
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        
        self.setupUI()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        
        self.setupUI()
    }
}


// MARK: - Setup

private extension DiceARView {
    
    var configuration: ARWorldTrackingConfiguration {
        
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
    
    func setupUI() {
        
        let session = self.session
        session.run(self.configuration)
        
        self.addSubview(self.coachingOverlay)
        
        do {
            self.diceAnchor = try Dice.load_Dice()
        } catch {
            fatalError(error.localizedDescription)
        }
        
        guard let diceAnchor = self.diceAnchor else {
            return
        }
        
        diceAnchor.dice?.transform.rotation = simd_quatf(angle: 0,axis: SIMD3<Float>(1,1,1))
        
        self.scene.addAnchor(diceAnchor)
        
        self.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(self.handleTap)
        ))
    }
}


// MARK: - Helper

private extension DiceARView {
    
    @objc
    func handleTap() {
        
        guard let diceAnchor = self.diceAnchor else {
            return
        }
        
        diceAnchor.actions.rotateDice.onAction = rotateDice(_:)
        
        if !self.isRolling {
            self.isRolling = true
            diceAnchor.notifications.startRolling.post()
        }
        
        print(self.count)
    }
    
    func rotateDice(_ entity: Entity?) {
        
        guard let entity = entity else {
            return
        }
        
        let randomInt = Int.random(in: 1...6)
        
        switch randomInt {
        case 1:
            self.rotation(entity: entity, angleX: 0, angleZ: 0)
        case 2:
            self.rotation(entity: entity, angleX: 0, angleZ: 90)
        case 3:
            self.rotation(entity: entity, angleX: 90, angleZ: 0)
        case 4:
            self.rotation(entity: entity, angleX: -90, angleZ: 0)
        case 5:
            self.rotation(entity: entity, angleX: 0, angleZ: -90)
        case 6:
            self.rotation(entity: entity, angleX: 0, angleZ: 180)
        default:
            fatalError("not possible number")
        }
        
        self.count = randomInt
    }
    
    func rotation(entity: Entity, angleX: Float, angleZ: Float) {
        
        let radiansX = angleX * Float.pi / 180.0
        let radiansZ = angleZ * Float.pi / 180.0
        
        if angleX != 0 {
            entity.children[0].transform.rotation = simd_quatf(angle: radiansX,axis: SIMD3<Float>(1,0,0))
        } else {
            entity.children[0].transform.rotation = simd_quatf(angle: radiansZ,axis: SIMD3<Float>(0,0,1))
        }
    }
}
