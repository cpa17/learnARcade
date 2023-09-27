//
//  DiceCustomView.swift
//  learnARcade
//
//  Created by Pascal Ahlner on 27.09.23.
//

import SwiftUI

struct CustomView: View {
    
    @State
    private var number: Int = 1
    @Environment(\.dismiss)
    var dismiss
    
    var body: some View {
        
        NavigationStack {
            VStack(alignment: .center, spacing: 10) {
                
                Button {
                    self.dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                }
                .padding(20)
                .frame(width: UIScreen.main.bounds.width, alignment: .trailing)
                
                Spacer()
                
                Text("Anzahl der Würfel")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                
                HStack {
                    
                    Spacer()
                    
                    Button {
                        if self.number > 1 {
                            self.number = self.number - 1
                        }
                    } label: {
                        Image(systemName: "minus.circle.fill")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    .foregroundColor(.white)
                    .font(.title)
                    
                    Spacer()
                    
                    Text(number.description)
                        .font(.title)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button {
                        if self.number < 9 {
                            self.number = self.number + 1
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    .foregroundColor(.white)
                    .font(.title)
                    
                    Spacer()
                }
                .padding()
                
                NavigationLink {
                    DiceView(diceCount: number)
                } label: {
                    Text("Weiter")
                        .padding(5)
                }
                .buttonStyle(.borderedProminent)
                .tint(.orange)
                .foregroundColor(.white)
                .font(.title)
                .cornerRadius(50)
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    CustomView()
}
