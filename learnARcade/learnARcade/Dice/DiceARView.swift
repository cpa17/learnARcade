//
//  DiceARView.swift
//  learnARcade
//
//  Created by Pascal Ahlner on 15.08.23.
//

import ARKit
import RealityKit


// MARK: - Init

class DiceARView: ARView {
    
    private var correctButton: UIButton?
    private var wrongButton: UIButton?
    private var secondWrongButton: UIButton?
    private var scoreLabel: UILabel?
    private var diceAnchor: Dice._Dice?
    private var isRolling: Bool = false
    private var answer: Int = 0
    private var diceCount: Int = 1
    private var score: Int = 0
    private var randomNumberOne: Int?
    private var randomNumberTwo: Int?
    private var positions: [CGFloat] = [
        20,
        (UIScreen.main.bounds.width / 3) + 10,
        (2 * (UIScreen.main.bounds.width / 3))
    ]
    private var gameOverView: GameOverView?
    
    func configuration(_ diceCount: Int) {
        
        self.diceCount = diceCount
        self.setupUI()
    }
}


// MARK: - Setup

private extension DiceARView {
    
    var configuration: ARWorldTrackingConfiguration {
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        return configuration
    }
    
    var coachingOverlay: ARCoachingOverlayView {
        
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.session = session
        coachingOverlay.goal = .horizontalPlane
        
        return coachingOverlay
    }
    
    func setupUI() {
        
        self.scoreLabel = UILabel()
        
        guard let scoreLabel else {
            return
        }
        
        scoreLabel.frame = CGRect(
            x: 20,
            y: 50,
            width: 150,
            height: 30
        )
        
        scoreLabel.font = .boldSystemFont(ofSize: 20)
        scoreLabel.textAlignment = .center
        scoreLabel.text = "Score: 0"
        scoreLabel.layer.backgroundColor = UIColor.orange.cgColor
        scoreLabel.textColor = .white
        scoreLabel.layer.cornerRadius = 15
        scoreLabel.layer.masksToBounds = true
        self.addSubview(scoreLabel)
        
        let session = self.session
        session.run(self.configuration)
        
        self.addSubview(self.coachingOverlay)
        
        do {
            self.diceAnchor = try Dice.load_Dice()
        } catch {
            fatalError(error.localizedDescription)
        }
        
        guard let diceAnchor = self.diceAnchor else {
            return
        }
        
        diceAnchor.actions.rotateDice.onAction = rotateDice(_:)
        
        print(diceCount)
        
        if diceCount > 1 {
            for number in 2...diceCount {
                if let clone = self.diceAnchor?.clone(recursive: true) {
                    clone.children[0].transform.translation.x += Float.random(in: -0.03...0.03) * Float(number)
                    clone.children[0].transform.translation.z += Float.random(in: -0.03...0.03) * Float(number)
                    self.diceAnchor?.addChild(clone.children[0])
                }
            }
        }
        
        diceAnchor.dice?.transform.rotation = simd_quatf(angle: 0,axis: SIMD3<Float>(1,1,1))
        
        self.scene.addAnchor(diceAnchor)
        
        self.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(self.handleTap)
        ))
    }
}


// MARK: - Actions

private extension DiceARView {
    
    @objc
    func handleTap() {
        
        guard let diceAnchor = self.diceAnchor else {
            return
        }
        
        if !self.isRolling {
            self.isRolling = true
            diceAnchor.notifications.startRolling.post()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.addButtons()
            }
        }
    }
    
    @objc
    func handleCorrectAnswer() {
        
        self.score += 1
        guard let scoreLabel else {
            return
        }
        scoreLabel.text = "Score: \(self.score)"
        
        guard let diceAnchor = self.diceAnchor else {
            return
        }
        
        self.answer = 0
        self.removeButtons()
        diceAnchor.notifications.startRolling.post()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.addButtons()
        }
    }
    
    @objc
    func handleWrongAnswer() {
        
        self.removeButtons()
        self.diceAnchor?.dice?.transform.rotation = simd_quatf(angle: 0,axis: SIMD3<Float>(1,1,1))
        
        UIView.transition(
            with: self,
            duration: 0.25,
            options: [.transitionCrossDissolve],
            animations: {
                self.scoreLabel?.isHidden = true
                let frame = CGRect(
                    x: .zero,
                    y: .zero,
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height
                )
                self.gameOverView = GameOverView(frame: frame)
                self.gameOverView?.backgroundColor = UIColor(red: 251/255, green: 245/255, blue: 242/255, alpha: 1.0)
                
                self.gameOverView?.gameOverButton.addTarget(self, action: #selector(self.handleNewStart), for: .touchUpInside)
                
                self.addSubview(self.gameOverView!)
            },
            completion: nil
        )
    }
    
    @objc
    func handleNewStart() {
        
        self.score = 0
        self.answer = 0
        
        guard let scoreLabel else {
            return
        }
        scoreLabel.text = "Score: \(self.score)"
        
        self.isRolling = false
        
        UIView.transition(
            with: self,
            duration: 0.25,
            options: [.transitionCrossDissolve],
            animations: {
                self.scoreLabel?.isHidden = false
                self.gameOverView?.removeFromSuperview()
            },
            completion: nil
        )
    }
    
    @objc
    func handleStart() {
        
        self.score = 0
        guard let scoreLabel else {
            return
        }
        scoreLabel.text = "Score: \(self.score)"
    }
}


// MARK: - Helper

private extension DiceARView {
    
    func rotateDice(_ entity: Entity?) {
        
        guard let entity = entity else {
            return
        }
        
        let randomInt = Int.random(in: 1...6)
        
        switch randomInt {
        case 1:
            self.rotation(entity: entity, angleX: 0, angleZ: 0)
        case 2:
            self.rotation(entity: entity, angleX: 0, angleZ: 90)
        case 3:
            self.rotation(entity: entity, angleX: 90, angleZ: 0)
        case 4:
            self.rotation(entity: entity, angleX: -90, angleZ: 0)
        case 5:
            self.rotation(entity: entity, angleX: 0, angleZ: -90)
        case 6:
            self.rotation(entity: entity, angleX: 0, angleZ: 180)
        default:
            fatalError("not possible number")
        }
        
        self.answer += randomInt
    }
    
    func rotation(entity: Entity, angleX: Float, angleZ: Float) {
        
        let radiansX = angleX * Float.pi / 180.0
        let radiansZ = angleZ * Float.pi / 180.0
        
        if angleX != 0 {
            entity.children[0].transform.rotation = simd_quatf(angle: radiansX,axis: SIMD3<Float>(1,0,0))
        } else {
            entity.children[0].transform.rotation = simd_quatf(angle: radiansZ,axis: SIMD3<Float>(0,0,1))
        }
    }
    
    func addButtons() {
        
        self.updateButtons()
        
        guard let correctButton, let wrongButton, let secondWrongButton else {
            return
        }
        
        UIView.transition(
            with: self,
            duration: 0.25,
            options: [.transitionCrossDissolve],
            animations: {
                self.addSubview(correctButton)
                self.addSubview(wrongButton)
                self.addSubview(secondWrongButton)
            },
            completion: nil
        )
    }
    
    func updateButtons() {
        
        self.positions.shuffle()
        self.randomNumberOne = diceCount * Int.random(in: 1...6)
        self.randomNumberTwo = diceCount * Int.random(in: 1...6)
        
        while self.randomNumberOne == self.answer ||
                self.randomNumberTwo == self.answer ||
                self.randomNumberOne == self.randomNumberTwo {
            self.randomNumberOne = diceCount * Int.random(in: 1...6)
            self.randomNumberTwo = diceCount * Int.random(in: 1...6)
        }
        
        guard let randomNumberOne, let randomNumberTwo else {
            return
        }
        
        self.correctButton = self.newButton(title: self.answer.description, isCorrect: true, position: self.positions[0])
        self.wrongButton = self.newButton(title: randomNumberOne.description, isCorrect: false, position: self.positions[1])
        self.secondWrongButton = self.newButton(title: randomNumberTwo.description, isCorrect: false, position: self.positions[2])
    }
    
    func removeButtons() {
        
        UIView.transition(
            with: self,
            duration: 0.25,
            options: [.transitionCrossDissolve],
            animations: {
                self.correctButton?.removeFromSuperview()
                self.wrongButton?.removeFromSuperview()
                self.secondWrongButton?.removeFromSuperview()
            },
            completion: nil
        )
    }
}


// MARK: - Button

private extension DiceARView {
    
    func newButton(title: String, isCorrect: Bool, position: CGFloat) -> UIButton {
        
        let button = UIButton(type: .custom)
        
        button.frame = CGRect(
            x: position,
            y: self.frame.maxY - self.safeAreaInsets.bottom - 75,
            width: (UIScreen.main.bounds.width / 3) - 20,
            height: 60
        )
        
        button.setTitle(title, for: .normal)
        button.backgroundColor = .orange
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 0.5 * button.bounds.size.height
        button.clipsToBounds = true
        
        if isCorrect {
            button.addTarget(
                self,
                action:  #selector(handleCorrectAnswer),
                for: .touchUpInside
            )
        } else {
            button.addTarget(
                self,
                action:  #selector(handleWrongAnswer),
                for: .touchUpInside
            )
        }
        
        return button
    }
}

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
