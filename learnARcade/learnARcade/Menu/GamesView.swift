//
//  GamesView.swift
//  learnARcade
//
//  Created by Pascal Ahlner on 22.08.23.
//

import SwiftUI
import Combine

struct GamesView: View {
    
    @Environment(\.dismiss)
    var dismiss
    
    let name: String
    
    init(name: String) {
        
        self.name = name
        UserDefaults.standard.setValue(name, forKey: "name")
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("Spiele")
                    .font(.custom("Ribeye-Regular", size: 40))
                    .frame(width: UIScreen.main.bounds.size.width)
                    .foregroundColor(.black)
                    .background(Color(red: 229/255, green: 229/255, blue: 229/255))
                    .padding()
                
                HStack {
                    
                    Text("Hallo \(self.name), was willst du spielen?")
                        .font(.title2)
                        .lineLimit(2, reservesSpace: true)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .foregroundColor(.black)
                        .frame(width: UIScreen.main.bounds.size.width - 70, alignment: .leading)
                    
                    Button {
                        self.dismiss()
                    } label: {
                        Image(systemName: "square.and.pencil.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.orange)
                    }
                    .padding(20)
                    .frame(width: 50, alignment: .trailing)
                }
                
                Divider()
                
                Text("Würfeln")
                    .font(.largeTitle)
                    .padding(.horizontal, 20)
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.size.width, alignment: .leading)
                
                HStack {
                    
                    NavigationLink {
                        DiceMenuView()
                    } label: {
                        Text("Spielen")
                            .padding(5)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    .foregroundColor(.white)
                    .font(.title2)
                    .cornerRadius(50)
                    
                    NavigationLink {
                        DiceHighScoreView()
                    } label: {
                        Text("Highscore")
                            .padding(5)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    .foregroundColor(.white)
                    .font(.title2)
                    .cornerRadius(50)
                }
                
            }
            
            VStack {
                
                Divider()
                    .padding(.vertical, 10)
                
                
                Text("Fußball")
                    .font(.largeTitle)
                    .padding(.horizontal, 20)
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.size.width, alignment: .leading)
                
                HStack {
                    NavigationLink {
                        FootballMenuView()
                    } label: {
                        Text("Spielen")
                            .padding(5)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    .foregroundColor(.white)
                    .font(.title2)
                    .cornerRadius(50)
                    
                    ProgressView(
                        value: 0,
                        total: 10,
                        label: {},
                        currentValueLabel: { 
                            Text("0" + "/10")
                                .font(.headline)
                                .foregroundStyle(.gray)
                        }
                    )
                    .tint(.orange)
                    .padding()
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .background(Color(red: 251/255, green: 245/255, blue: 242/255))
    }
}

#Preview {
    GamesView(name: "Test")
}
