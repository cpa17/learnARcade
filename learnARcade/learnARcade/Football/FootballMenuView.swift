//
//  FootballMenuView.swift
//  learnARcade
//
//  Created by Pascal Ahlner on 27.09.23.
//

import SwiftUI

struct FootballMenuView: View {
    
    var body: some View {
        
        NavigationStack {
            
            Text("Fußball")
                .font(.custom("Ribeye-Regular", size: 40))
                .frame(width: UIScreen.main.bounds.size.width)
                .foregroundColor(.black)
                .background(Color(red: 229/255, green: 229/255, blue: 229/255))
                .padding()
            
            Image(.fooball)
                .resizable()
                .foregroundStyle(.black)
                .frame(width: 100, height: 100, alignment: .leading)
            
            Divider()
                .padding()
            
            HStack {
                CusNavLink {
                    FootballView(level: 1)
                } label: {
                    Text("1")
                }
                
                CusNavLink {
                    FootballView(level: 2)
                } label: {
                    Text("2")
                }
                
                CusNavLink {
                    FootballView(level: 3)
                } label: {
                    Text("3")
                }
                
                CusNavLink {
                    FootballView(level: 4)
                } label: {
                    Text("4")
                }
                
                CusNavLink {
                    FootballView(level: 5)
                } label: {
                    Text("5")
                }
            }
            
            HStack {
                
                CusNavLink {
                    FootballView(level: 6)
                } label: {
                    Text("6")
                }
                
                CusNavLink {
                    FootballView(level: 7)
                } label: {
                    Text("7")
                }
                
                CusNavLink {
                    FootballView(level: 8)
                } label: {
                    Text("8")
                }
                
                CusNavLink {
                    FootballView(level: 9)
                } label: {
                    Text("9")
                }
                
                CusNavLink {
                    FootballView(level: 10)
                } label: {
                    Text("10")
                }
            }
            
            Divider()
                .padding()
            
            CusNavLink {
                FootballView()
            } label: {
                Text("Übung")
            }
            
            Spacer()
        }
        .background(Color(red: 251/255, green: 245/255, blue: 242/255))
    }
}

private extension FootballMenuView {
    
    struct CusNavLink<Label: View, Destination: View>: View {

        let destination: Destination
        let label : Label

        init(
            destination: () -> Destination,
            @ViewBuilder label: () -> Label
        ) {
            self.destination = destination()
            self.label = label()
        }

        var body: some View {
            NavigationLink {
                destination
            } label: {
                label
                    .padding(5)
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
            .foregroundColor(.white)
            .font(.title2)
            .cornerRadius(50)
        }
    }
}

#Preview {
    FootballMenuView()
}
