//
//  ContentView.swift
//  learnARcade
//
//  Created by Pascal Ahlner on 01.08.23.
//

import SwiftUI

struct DiceView : View {
    
    var diceCount: Int
    
    @Environment(\.dismiss)
    var dismiss
    @State
    private var showingAlert = false
    
    var body: some View {
        
        ZStack {
            ARViewContainer(diceCount: diceCount)
                .navigationBarBackButtonHidden(true)
                .ignoresSafeArea()
            
            Button {
                showingAlert = true
            } label: {
                Image(systemName: "xmark")
            }
            .padding(20)
            .frame(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height - 50,
                alignment: .topTrailing
            )
            .buttonStyle(.borderedProminent)
            .tint(.orange)
            .foregroundColor(.white)
            .font(.largeTitle)
            .alert("Zurück zum Menü?", isPresented: $showingAlert) {
                Button("NEIN", role: .cancel) {
                    showingAlert = true
                }
                Button("JA") {
                    self.dismiss()
                }
            }
        }
    }
}

private extension DiceView {
    
    struct ARViewContainer: UIViewRepresentable {
        
        var diceCount: Int
        
        func makeUIView(context: Context) -> DiceARView {
            
            let arView = DiceARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
            arView.configuration(diceCount)
            
            return arView
        }
        
        func updateUIView(_ uiView: DiceARView, context: Context) {}
    }
}
