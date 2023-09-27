//
//  WinView.swift
//  learnARcade
//
//  Created by Pascal Ahlner on 27.09.23.
//

import UIKit

class WinView: UIView {
    
    private var winLabel = UILabel(frame: CGRect(
        x: .zero,
        y: Int(UIScreen.main.bounds.height)/2 - 100,
        width: Int(UIScreen.main.bounds.width),
        height: 50)
    )
    
    var winButton = UIButton(frame: CGRect(
        x: Int(UIScreen.main.bounds.width)/2 - 75,
        y: Int(UIScreen.main.bounds.height)/2,
        width: 150,
        height: 40)
    )
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.winLabel.text = "Level Geschafft!"
        self.winLabel.textAlignment = .center
        self.winLabel.textColor = .orange
        self.winLabel.font = .init(name: "Ribeye-Regular", size: 42)
        
        self.winButton.setTitle("Neustart", for: .normal)
        self.winButton.backgroundColor = .orange
        self.winButton.titleLabel?.font = .boldSystemFont(ofSize: 24)
        self.winButton.titleLabel?.textColor = .white
        self.winButton.layer.cornerRadius = 0.5 * self.winButton.bounds.size.height
        self.winButton.clipsToBounds = true
        
        self.addSubview(winLabel)
        self.addSubview(winButton)
    }
}
