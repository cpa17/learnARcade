//
//  FootballView.swift
//  learnARcade
//
//  Created by Pascal Ahlner on 08.09.23.
//

import SwiftUI

struct FootballView: View {
    var body: some View {
        ARViewContainer()
            .ignoresSafeArea()
    }
}

private extension FootballView {
    
    struct ARViewContainer: UIViewRepresentable {
        
        func makeUIView(context: Context) -> FootballballARView {
            
            let arView = FootballballARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
            arView.configuration()
            
            return arView
        }
        
        func updateUIView(_ uiView: FootballballARView, context: Context) {}
    }
}
