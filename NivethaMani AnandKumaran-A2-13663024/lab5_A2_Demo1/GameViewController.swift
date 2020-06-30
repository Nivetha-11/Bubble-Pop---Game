//
//  GameViewController.swift
//  lab5_A2_Demo1
//
//  Created by Nivetha Anand on 10/5/20.
//  Copyright © 2020 uts. All rights reserved.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {
    
    var myTimer: Timer? // Game Timer
    var bubble = Bubble()
    var bubbleArray = [Bubble]()
    var remainingSeconds = 60 // Adjustable in slider
    var maxBubbleNumber = 15 // Adjustable in slider
    var score: Double = 0
    var lastBubbleValue: Double = 0
    var playerName: String = ""
    var rankingDictionary = [String : Double]()
    var previousRankingDictionary: Dictionary? = [String : Double]()
    var sortedHighScoreArray = [(key: String, value: Double)]()
    
    var screenWidth: UInt32 {
        return UInt32(UIScreen.main.bounds.width)
    }
    var screenHeight: UInt32 {
        return UInt32(UIScreen.main.bounds.height)
    }
    
    @IBOutlet weak var timeRemaining: UILabel!
    @IBOutlet weak var currentScore: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        previousRankingDictionary = UserDefaults.standard.dictionary(forKey: "ranking") as? Dictionary<String, Double>
        if previousRankingDictionary != nil {
            rankingDictionary = previousRankingDictionary!
            sortedHighScoreArray = rankingDictionary.sorted(by: {$0.value > $1.value})
            
            
            myTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
                timer in
                self.setRemainingTime()
                self.removeBubble()
                self.createBubble()
            }
            
        }
        
    }
    
    @IBAction func bubbleTapped(_ sender: Bubble) {
        //Removing bubble from the view
        sender.removeFromSuperview()
        if lastBubbleValue == sender.value {
            score += sender.value * 1.5
        }
        else {
            score += sender.value
        }
        lastBubbleValue = sender.value
        currentScore.text = "\(score)"
        
        if  previousRankingDictionary == nil {
            highScoreLabel.text = "\(score)"
        } else if sortedHighScoreArray[0].value < score {
            highScoreLabel.text = "\(score)"
        } else if sortedHighScoreArray[0].value >= score {
            highScoreLabel.text = "\(sortedHighScoreArray[0].value)"
        }
    }
    
    func isOverlapped(newBubble: Bubble) -> Bool {
        //To preven bubble overlapping
        for currentBubbles in bubbleArray {
            if newBubble.frame.intersects(currentBubbles.frame) {
                return true
            }
        }
        return false
    }
    
    
    @objc func createBubble() {
        let numberToCreate = arc4random_uniform(UInt32(maxBubbleNumber - bubbleArray.count)) + 1
        var i = 0
        
        while i < numberToCreate {
            bubble = Bubble()
            bubble.frame = CGRect(x: CGFloat(10 + arc4random_uniform(screenWidth - 2 * bubble.radius - 20)), y: CGFloat(160 + arc4random_uniform(screenHeight - 2 * bubble.radius - 180)), width: CGFloat(2 * bubble.radius), height: CGFloat(2 * bubble.radius))
            if !isOverlapped(newBubble: bubble) {
                bubble.addTarget(self, action: #selector(bubbleTapped), for: UIControl.Event.touchUpInside)
                self.view.addSubview(bubble)
                bubble.fadeIn()
                bubble.shake()
                bubble.animation()
                i += 1
                bubbleArray += [bubble]
            }
        }
    }
    
    @objc func removeBubble() {
        var i = 0
        while i < bubbleArray.count {
            if arc4random_uniform(100) < 33 {
                bubbleArray[i].removeFromSuperview()
                bubbleArray.remove(at: i)
                i += 1
            }
        }
    }
    
    @objc func setRemainingTime() {
        timeRemaining.text = "\(remainingSeconds)"
        
        // Check if the game has ended
        if (remainingSeconds == 0) {
            myTimer!.invalidate()
            checkExistingHighScore()
            
            let destinationView = self.storyboard?.instantiateViewController(withIdentifier: "ScoreViewController") as! ScoreViewController
            //self.navigationController?.pushViewController(destinationView, animated: true)
            present(destinationView, animated: true, completion: nil)
        }
        remainingSeconds -= 1
    }
    
    func saveHighScore() {
        rankingDictionary.updateValue(score, forKey: "\(playerName)")
        UserDefaults.standard.set(rankingDictionary, forKey: "ranking")
    }
    
    func checkExistingHighScore() {
        if previousRankingDictionary == nil {
            saveHighScore()
        } else {
            rankingDictionary = previousRankingDictionary!
            if rankingDictionary.keys.contains("\(playerName)") {
                let currentScore = rankingDictionary["\(playerName)"]!
                if currentScore < score {
                    saveHighScore()
                }
            } else {
                saveHighScore()
            }
        }
    }
}


