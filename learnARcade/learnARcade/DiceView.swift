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
        
        ZStack {
            ARViewContainer().edgesIgnoringSafeArea(.all)
        }
    }
}

private extension DiceView {
    
    struct ARViewContainer: UIViewRepresentable {
        
        func makeUIView(context: Context) -> DiceARView {
            DiceARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
        }
        
        func updateUIView(_ uiView: DiceARView, context: Context) {
            
            if uiView.isRolling {
                
            }
        }
    }
}
