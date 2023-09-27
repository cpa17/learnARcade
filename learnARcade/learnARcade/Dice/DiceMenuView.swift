//
//  DiceMenuView.swift
//  learnARcade
//
//  Created by Pascal Ahlner on 27.09.23.
//

import SwiftUI

struct DiceMenuView: View {
    
    
    var body: some View {
        
        NavigationStack {
            
            Text("Würfeln")
                .font(.custom("Ribeye-Regular", size: 40))
                .frame(width: UIScreen.main.bounds.size.width)
                .foregroundColor(.black)
                .background(Color(red: 229/255, green: 229/255, blue: 229/255))
                .padding()
            
            Image(.dice)
                .resizable()
                .foregroundStyle(.black)
                .frame(width: 100, height: 100, alignment: .leading)
            
            Divider()
                .padding()
            
            NavigationLink {
                DiceView(diceCount: 2)
            } label: {
                Text("Einfach")
                    .padding(5)
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
            .foregroundColor(.white)
            .font(.title2)
            .cornerRadius(50)
            
            NavigationLink {
                DiceView(diceCount: 4)
            } label: {
                Text("Mittel")
                    .padding(5)
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
            .foregroundColor(.white)
            .font(.title2)
            .cornerRadius(50)
            
            NavigationLink {
                DiceView(diceCount: 6)
            } label: {
                Text("Schwer")
                    .padding(5)
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
            .foregroundColor(.white)
            .font(.title2)
            .cornerRadius(50)
            
            Divider()
                .padding()

            
            NavigationLink {
                CustomView()
                    .background(Color(red: 251/255, green: 245/255, blue: 242/255))
            } label: {
                Text("Benutzerdefiniert")
                    .padding(5)
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
            .foregroundColor(.white)
            .font(.title2)
            .cornerRadius(50)
            .padding()
            
            Spacer()
        }
        .background(Color(red: 251/255, green: 245/255, blue: 242/255))
    }
}

#Preview {
    DiceMenuView()
}
