//
//  FootballView.swift
//  learnARcade
//
//  Created by Pascal Ahlner on 08.09.23.
//

import SwiftUI

struct FootballView: View {
    
    var level: Int = 0
    
    @Environment(\.dismiss)
    var dismiss
    @State
    private var showingAlert = false
    
    var body: some View {
        ARViewContainer(level: level)
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea()
        
//        Button {
//            showingAlert = true
//        } label: {
//            Image(systemName: "xmark")
//        }
//        .padding(20)
//        .frame(
//            width: UIScreen.main.bounds.width,
//            height: UIScreen.main.bounds.height - 50,
//            alignment: .topTrailing
//        )
//        .buttonStyle(.borderedProminent)
//        .tint(.orange)
//        .foregroundColor(.white)
//        .font(.largeTitle)
//        .alert("Zurück zum Menü?", isPresented: $showingAlert) {
//            Button("NEIN", role: .cancel) {
//                showingAlert = true
//            }
//            Button("JA") {
//                self.dismiss()
//            }
//        }
    }
}

private extension FootballView {
    
    struct ARViewContainer: UIViewRepresentable {
        
        var level: Int = 0
        
        func makeUIView(context: Context) -> FootballballARView {
            
            let arView = FootballballARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
            arView.configuration(level: self.level)
            
            return arView
        }
        
        func updateUIView(_ uiView: FootballballARView, context: Context) {}
    }
}
