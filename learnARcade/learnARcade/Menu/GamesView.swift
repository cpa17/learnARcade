//
//  GamesView.swift
//  learnARcade
//
//  Created by Pascal Ahlner on 22.08.23.
//

import SwiftUI

struct GamesView: View {
    
    let name: String
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("Spiele")
                    .font(.custom("Ribeye-Regular", size: 40))
                    .frame(width: UIScreen.main.bounds.size.width)
                    .foregroundColor(.black)
                    .background(Color(red: 229/255, green: 229/255, blue: 229/255))
                    .padding()
                
                Text("Hallo \(self.name), was willst du spielen?")
                    .font(.title2)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.size.width, alignment: .leading)
                
                Divider()
                
                Text("Würfeln")
                    .font(.largeTitle)
                    .padding(.horizontal, 20)
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.size.width, alignment: .leading)
                
                HStack {
                    NavigationLink {
                        DiceView(diceCount: 1)
                    } label: {
                        Text("Tutorial")
                            .padding(5)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    .foregroundColor(.white)
                    .font(.title2)
                    .cornerRadius(50)
                    
                    NavigationLink {
                        CustomView()
                            .background(Color(red: 251/255, green: 245/255, blue: 242/255))
                    } label: {
                        Text("Custom")
                            .padding(5)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    .foregroundColor(.white)
                    .font(.title2)
                    .cornerRadius(50)
                }
                
                HStack {
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
                }
            }
            
            VStack {
                
                Divider()
                    .padding(.vertical, 10)
                
                
                Text("Teilen")
                    .font(.largeTitle)
                    .padding(.horizontal, 20)
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.size.width, alignment: .leading)
                
                HStack {
                    NavigationLink {
                        FootballView(level: 1)
                    } label: {
                        Text("1")
                            .padding(5)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    .foregroundColor(.white)
                    .font(.title2)
                    .cornerRadius(50)
                    
                    NavigationLink {
                        FootballView(level: 2)
                    } label: {
                        Text("2")
                            .padding(5)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    .foregroundColor(.white)
                    .font(.title2)
                    .cornerRadius(50)
                    
                    NavigationLink {
                        FootballView(level: 3)
                    } label: {
                        Text("3")
                            .padding(5)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    .foregroundColor(.white)
                    .font(.title2)
                    .cornerRadius(50)
                    
                    NavigationLink {
                        FootballView(level: 4)
                    } label: {
                        Text("4")
                            .padding(5)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    .foregroundColor(.white)
                    .font(.title2)
                    .cornerRadius(50)
                    
                    NavigationLink {
                        FootballView(level: 5)
                    } label: {
                        Text("5")
                            .padding(5)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    .foregroundColor(.white)
                    .font(.title2)
                    .cornerRadius(50)
                }
                
                HStack {
                    NavigationLink {
                        FootballView(level: 6)
                    } label: {
                        Text("6")
                            .padding(5)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    .foregroundColor(.white)
                    .font(.title2)
                    .cornerRadius(50)
                    
                    NavigationLink {
                        FootballView(level: 7)
                    } label: {
                        Text("7")
                            .padding(5)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    .foregroundColor(.white)
                    .font(.title2)
                    .cornerRadius(50)
                    
                    NavigationLink {
                        FootballView(level: 8)
                    } label: {
                        Text("8")
                            .padding(5)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    .foregroundColor(.white)
                    .font(.title2)
                    .cornerRadius(50)
                    
                    NavigationLink {
                        FootballView(level: 9)
                    } label: {
                        Text("9")
                            .padding(5)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    .foregroundColor(.white)
                    .font(.title2)
                    .cornerRadius(50)
                    
                    NavigationLink {
                        FootballView(level: 10)
                    } label: {
                        Text("10")
                            .padding(5)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    .foregroundColor(.white)
                    .font(.title2)
                    .cornerRadius(50)
                }
                
                NavigationLink {
                    FootballView()
                } label: {
                    Text("Zufall")
                        .padding(5)
                }
                .buttonStyle(.borderedProminent)
                .tint(.orange)
                .foregroundColor(.white)
                .font(.title2)
                .cornerRadius(50)
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .background(Color(red: 251/255, green: 245/255, blue: 242/255))
    }
}

private extension GamesView {
    
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
}
