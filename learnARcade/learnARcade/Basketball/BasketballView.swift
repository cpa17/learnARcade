//
//  BasketballView.swift
//  learnARcade
//
//  Created by Pascal Ahlner on 08.09.23.
//

import SwiftUI

struct BasketballView: View {
    var body: some View {
        ARViewContainer()
            .ignoresSafeArea()
    }
}

private extension BasketballView {
    
    struct ARViewContainer: UIViewRepresentable {
        
        func makeUIView(context: Context) -> BasketballARView {
            
            let arView = BasketballARView()
            
            return arView
        }
        
        func updateUIView(_ uiView: BasketballARView, context: Context) {}
    }
}
