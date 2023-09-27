//
//  DiceHighScoreView.swift
//  learnARcade
//
//  Created by Pascal Ahlner on 27.09.23.
//

import SwiftUI

struct DiceHighScoreView: View {
    
    let highscore1: String = UserDefaults.standard.integer(forKey: "highScore1").description
    let highscore2: String = UserDefaults.standard.integer(forKey: "highScore2").description
    let highscore3: String = UserDefaults.standard.integer(forKey: "highScore3").description
    let highscore4: String = UserDefaults.standard.integer(forKey: "highScore4").description
    let highscore5: String = UserDefaults.standard.integer(forKey: "highScore5").description
    let highscore6: String = UserDefaults.standard.integer(forKey: "highScore6").description
    let highscore7: String = UserDefaults.standard.integer(forKey: "highScore7").description
    let highscore8: String = UserDefaults.standard.integer(forKey: "highScore8").description
    let highscore9: String = UserDefaults.standard.integer(forKey: "highScore9").description
    let name1: String = UserDefaults.standard.string(forKey: "name1") ?? ""
    let name2: String = UserDefaults.standard.string(forKey: "name2") ?? ""
    let name3: String = UserDefaults.standard.string(forKey: "name3") ?? ""
    let name4: String = UserDefaults.standard.string(forKey: "name4") ?? ""
    let name5: String = UserDefaults.standard.string(forKey: "name5") ?? ""
    let name6: String = UserDefaults.standard.string(forKey: "name6") ?? ""
    let name7: String = UserDefaults.standard.string(forKey: "name7") ?? ""
    let name8: String = UserDefaults.standard.string(forKey: "name8") ?? ""
    let name9: String = UserDefaults.standard.string(forKey: "name9") ?? ""
    
    
    var body: some View {
        
        VStack {
            Text("Highscore")
                .font(.custom("Ribeye-Regular", size: 40))
                .frame(width: UIScreen.main.bounds.size.width)
                .foregroundColor(.black)
                .background(Color(red: 229/255, green: 229/255, blue: 229/255))
                .padding()
            
            List {
                Section {
                    Row("Platz 1: " + highscore1 + " " + name1)
                    Row("Platz 2: " + highscore2 + " " + name2)
                    Row("Platz 3: " + highscore3 + " " + name3)
                }
                
                Row("Platz 4: " + highscore4 + " " + name4)
                Row("Platz 5: " + highscore5 + " " + name5)
                Row("Platz 6: " + highscore6 + " " + name6)
                Row("Platz 7: " + highscore7 + " " + name7)
                Row("Platz 8: " + highscore8 + " " + name8)
                Row("Platz 9: " + highscore9 + " " + name9)
            }
            .scrollContentBackground(.hidden)
        }
        .background(Color(red: 251/255, green: 245/255, blue: 242/255))
    }
}

private extension DiceHighScoreView {
    
    struct Row: View {
        
        private let text: String
        
        init(_ text: String) {
            self.text = text
        }

        var body: some View {
            Text(self.text)
                .font(.headline)
                .listRowBackground(Color.white)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    DiceHighScoreView()
}
