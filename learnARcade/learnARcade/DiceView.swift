//
//  ContentView.swift
//  learnARcade
//
//  Created by Pascal Ahlner on 01.08.23.
//

import ARKit
import SwiftUI
import RealityKit

struct DiceView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

private extension DiceView {
    
    struct ARViewContainer: UIViewRepresentable {
        
        func makeUIView(context: Context) -> ARView {
            
            let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
            let session = arView.session
            let configuration = ARWorldTrackingConfiguration()
            
            configuration.planeDetection = .horizontal
            session.run(configuration)
            
            let coachingOverlay = ARCoachingOverlayView()
            coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            coachingOverlay.session = session
            coachingOverlay.goal = .horizontalPlane
            arView.addSubview(coachingOverlay)
            
            let mesh = MeshResource.generateBox(size: 0.5, cornerRadius: 0.05)
            let material = SimpleMaterial(color: .blue, isMetallic: false)
            let modelEntity = ModelEntity(mesh: mesh, materials: [material])
            let anchorEntity = AnchorEntity(plane: .horizontal)
            anchorEntity.addChild(modelEntity)
            arView.scene.addAnchor(anchorEntity)
            
            modelEntity.generateCollisionShapes(recursive: true)
            
            arView.installGestures([.translation, .rotation, .scale], for: modelEntity)
            
            return arView
            
        }
        
        func updateUIView(_ uiView: ARView, context: Context) {}
        
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        DiceView()
    }
}
#endif
