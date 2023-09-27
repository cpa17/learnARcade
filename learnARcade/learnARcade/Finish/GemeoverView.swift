//
//  GemeoverView.swift
//  learnARcade
//
//  Created by Pascal Ahlner on 27.09.23.
//

import UIKit

class GameOverView: UIView {
    
    private var gameOverLabel = UILabel(frame: CGRect(
        x: .zero,
        y: Int(UIScreen.main.bounds.height)/2 - 100,
        width: Int(UIScreen.main.bounds.width),
        height: 50)
    )
    
    var gameOverButton = UIButton(frame: CGRect(
        x: Int(UIScreen.main.bounds.width)/2 - 75,
        y: Int(UIScreen.main.bounds.height)/2,
        width: 150,
        height: 40)
    )
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.gameOverLabel.text = "Game over"
        self.gameOverLabel.textAlignment = .center
        self.gameOverLabel.textColor = .orange
        self.gameOverLabel.font = .init(name: "Ribeye-Regular", size: 42)
        
        self.gameOverButton.setTitle("Neustart", for: .normal)
        self.gameOverButton.backgroundColor = .orange
        self.gameOverButton.titleLabel?.font = .boldSystemFont(ofSize: 24)
        self.gameOverButton.titleLabel?.textColor = .white
        self.gameOverButton.layer.cornerRadius = 0.5 * self.gameOverButton.bounds.size.height
        self.gameOverButton.clipsToBounds = true
        
        self.addSubview(gameOverLabel)
        self.addSubview(gameOverButton)
    }
}
