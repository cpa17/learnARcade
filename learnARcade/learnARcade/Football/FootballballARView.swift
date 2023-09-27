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
    private var isShooting = false
    private var level: Int = 0
    private var arguments = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    private var startPosition1: SIMD3<Float>?
    private var startPosition2: SIMD3<Float>?
    private var startPosition3: SIMD3<Float>?
    private var winView: WinView?
    
    
    func configuration(level: Int = 0) {
        
        self.level = level
        
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
        
        self.startPosition1 = footballAnchor.football1?.position
        self.startPosition2 = footballAnchor.football2?.position
        self.startPosition3 = footballAnchor.football3?.position
        
        self.setup()
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
    
    func setup() {
        
        arguments.shuffle()
        
        if arguments.isEmpty {
            
            self.winView = WinView(frame: frame)
            self.winView?.backgroundColor = UIColor(red: 251/255, green: 245/255, blue: 242/255, alpha: 1.0)
            self.addSubview(self.winView!)
            
            print("ende")
        }
        
        print(arguments)
        
        if self.level == 0 {
            
            let arg1 = arguments[Int.random(in: 0...9)]
            let arg2 = arguments[Int.random(in: 0...9)]
            
            guard let answer = self.answerGen(arg1: arg1, arg2: arg2) else {
                return
            }
            
            self.addChilds(answer: answer, arg1: arg1, arg2: arg2)
        } else {
            
            let arg1 = self.level
            guard let arg2 = arguments.first,
                  let answer = self.answerGen(arg1: arg1, arg2: arg2)
            else {
                return
            }
            
            arguments.removeFirst()
            self.addChilds(answer: answer, arg1: arg1, arg2: arg2)
        }
    }
    
    func addChilds(answer: [Entity], arg1: Int, arg2: Int) {
        
        guard let footballAnchor else {
            return
        }
        
        self.addActions(position: answer[0].position)
        
        footballAnchor.addChild(self.questionGen(arg1: arg1, arg2: arg2))
        footballAnchor.addChild(answer[0])
        footballAnchor.addChild(answer[1])
        footballAnchor.addChild(answer[2])
    }
    
    func questionGen(arg1: Int, arg2: Int) -> ModelEntity {
        
        let material = SimpleMaterial(color: .black, roughness: 0, isMetallic: false)
        let depth: Float = 0.001
        let font = UIFont.systemFont(ofSize: 0.3)
        let alignment: CTTextAlignment = .center
        let lineBreakMode : CTLineBreakMode = .byWordWrapping
        
        let textString = String(format: "%1d ·%2d", arg1, arg2)
                
        let textMeshResource : MeshResource = .generateText(
            textString,
            extrusionDepth: depth,
            font: font,
            alignment: alignment,
            lineBreakMode: lineBreakMode
        )
                
        let textEntity = ModelEntity(mesh: textMeshResource, materials: [material])
        
        textEntity.name = "question"
        textEntity.position = self.footballAnchor?.goal?.position ?? .zero
        textEntity.transform.translation.x -= 0.3
        textEntity.transform.translation.y += 0.8
        
        return textEntity
    }
    
    func answerGen(arg1: Int, arg2: Int) -> [ModelEntity]? {
        
        let material = SimpleMaterial(color: .black, roughness: 0, isMetallic: false)
        let depth: Float = 0.001
        let font = UIFont.systemFont(ofSize: 0.05)
        let alignment: CTTextAlignment = .center
        let lineBreakMode : CTLineBreakMode = .byWordWrapping
        
        guard let position1 = self.footballAnchor?.football1?.position,
              let position2 = self.footballAnchor?.football2?.position,
              let position3 = self.footballAnchor?.football3?.position
        else {
            return nil
        }
        
        var positions = [position1, position2, position3]
        positions.shuffle()
        
        let rightAnswer = arg1*arg2
        var wrong1Answer = arg1*Int.random(in: 1...10)
        var wrong2Answer = arg1*Int.random(in: 1...10)
        
        while rightAnswer == wrong1Answer ||
              rightAnswer == wrong2Answer ||
              wrong1Answer == wrong2Answer {

            wrong1Answer = arg1*Int.random(in: 1...10)
            wrong2Answer = arg1*Int.random(in: 1...10)
        }
        
        let rightMeshResource: MeshResource = .generateText(
            rightAnswer.description,
            extrusionDepth: depth,
            font: font,
            alignment: alignment,
            lineBreakMode: lineBreakMode
        )
        
        let wrong1MeshResource: MeshResource = .generateText(
            wrong1Answer.description,
            extrusionDepth: depth,
            font: font,
            alignment: alignment,
            lineBreakMode: lineBreakMode
        )
        
        let wrong2MeshResource: MeshResource = .generateText(
            wrong2Answer.description,
            extrusionDepth: depth,
            font: font,
            alignment: alignment,
            lineBreakMode: lineBreakMode
        )
                
        let rightEntity = ModelEntity(mesh: rightMeshResource, materials: [material])
        let wrong1Entity = ModelEntity(mesh: wrong1MeshResource, materials: [material])
        let wrong2Entity = ModelEntity(mesh: wrong2MeshResource, materials: [material])
        
        rightEntity.name = "rightEntity"
        wrong1Entity.name = "wrong1Entity"
        wrong2Entity.name = "wrong2Entity"
        
        rightEntity.position = positions[0]
        wrong1Entity.position = positions[1]
        wrong2Entity.position = positions[2]
        
        rightEntity.transform.translation.x -= 0.025
        wrong1Entity.transform.translation.x -= 0.025
        wrong2Entity.transform.translation.x -= 0.025
        
        rightEntity.transform.translation.y += 0.1
        wrong1Entity.transform.translation.y += 0.1
        wrong2Entity.transform.translation.y += 0.1
        
        return [rightEntity, wrong1Entity, wrong2Entity]
    }
    
    func addActions(position: SIMD3<Float>) {
        
        guard let footballAnchor else {
            return
        }
        
        footballAnchor.actions.resetAll.onAction = resetAll(_:)
        
        if position.x <= -0.1 {
            footballAnchor.actions.sequenceBall1.onAction = shootRightBall(_:)
            footballAnchor.actions.sequenceBall2.onAction = shootWrongBall(_:)
            footballAnchor.actions.sequenceBall3.onAction = shootWrongBall(_:)
        } else if position.x > -0.1 && position.x <= 0.1 {
            footballAnchor.actions.sequenceBall1.onAction = shootWrongBall(_:)
            footballAnchor.actions.sequenceBall2.onAction = shootRightBall(_:)
            footballAnchor.actions.sequenceBall3.onAction = shootWrongBall(_:)
        } else if position.x > 0.1 {
            footballAnchor.actions.sequenceBall1.onAction = shootWrongBall(_:)
            footballAnchor.actions.sequenceBall2.onAction = shootWrongBall(_:)
            footballAnchor.actions.sequenceBall3.onAction = shootRightBall(_:)
        } else {
            footballAnchor.actions.sequenceBall1.onAction = shootWrongBall(_:)
            footballAnchor.actions.sequenceBall2.onAction = shootWrongBall(_:)
            footballAnchor.actions.sequenceBall3.onAction = shootWrongBall(_:)
        }
    }
    
    func shootRightBall(_ entity: Entity?) {
        
        guard let entity = entity as? HasPhysics,
              !self.isShooting
        else {
            return
        }
        
        self.isShooting = true
        
        var forces = [
            SIMD3<Float>(x: 0, y: 0, z: -2000)
        ]
        forces.shuffle()
        entity.addForce(forces[0], relativeTo: entity.parent)
    }
    
    func shootWrongBall(_ entity: Entity?) {
        
        guard let entity = entity as? HasPhysics,
              !self.isShooting
        else {
            return
        }
        
        self.isShooting = true
        
        var forces = [
            SIMD3<Float>(x: 300, y: 0, z: -1300),
            SIMD3<Float>(x: -300, y: 0, z: -1300),
        ]
        forces.shuffle()
        entity.addForce(forces[0], relativeTo: entity.parent)
    }
    
    func resetAll(_ entity: Entity?) {
        
        guard let footballAnchor = self.footballAnchor,
              let question = footballAnchor.findEntity(named: "question"),
              let right = footballAnchor.findEntity(named: "rightEntity"),
              let wrong1 = footballAnchor.findEntity(named: "wrong1Entity"),
              let wrong2 = footballAnchor.findEntity(named: "wrong2Entity"),
              let startPosition1,
              let startPosition2,
              let startPosition3
        else {
            return
        }
        
        footballAnchor.removeChild(question)
        footballAnchor.removeChild(right)
        footballAnchor.removeChild(wrong1)
        footballAnchor.removeChild(wrong2)
        footballAnchor.football1?.position = startPosition1
        footballAnchor.football2?.position = startPosition2
        footballAnchor.football3?.position = startPosition3
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.isShooting = false
            self.setup()
        }
    }
}
