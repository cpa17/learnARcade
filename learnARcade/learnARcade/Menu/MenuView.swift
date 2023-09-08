//
//  MenuView.swift
//  learnARcade
//
//  Created by Pascal Ahlner on 22.08.23.
//

import SwiftUI

struct MenuView: View {
    
    @State public var name: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    
                    Text("Learn[AR]cade")
                        .font(.custom("Ribeye-Regular", size: 36))
                        .foregroundColor(.orange)
                }
                .padding(.vertical, 50)
                .padding(.horizontal, 25)
                .lineLimit(1)
                
                Text("Wie heißt du?")
                    .font(.title)
                    .foregroundColor(.black)
                
                TextField(
                    "",
                    text: $name,
                    prompt: Text("Gib deinen Namen hier ein...").foregroundColor(.gray)
                )
                .foregroundColor(.black)
                .padding(10)
                .background(.white)
                .cornerRadius(10)
                .font(.title3)
                .padding(.horizontal, 25)
                .padding(.bottom, 50)
                
                NavigationLink {
                    GamesView(name: self.name)
                } label: {
                    Text("Los geht's \(name)!")
                        .padding(5)
                }
                .buttonStyle(.borderedProminent)
                .tint(.orange)
                .foregroundColor(.white)
                .font(.title3)
                .cornerRadius(50)
                
                Spacer()
            }
            .background(Color(red: 251/255, green: 245/255, blue: 242/255))
        }
    }
}

extension Text {
    
    public func foregroundLinearGradient(
        colors: [Color],
        startPoint: UnitPoint,
        endPoint: UnitPoint
    ) -> some View {
        self.overlay {
            LinearGradient(
                colors: colors,
                startPoint: startPoint,
                endPoint: endPoint
            )
            .mask(
                self
                
            )
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
