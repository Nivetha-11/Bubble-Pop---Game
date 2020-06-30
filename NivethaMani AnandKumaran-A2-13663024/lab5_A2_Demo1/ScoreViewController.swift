//
//  ScoreViewController.swift
//  lab5_A2_Demo1
//
//  Created by Nivetha Anand on 10/5/20.
//  Copyright © 2020 uts. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    var rankingDictionary = [String : Double]()
    var sortedHighScoreArray = [(key: String, value: Double)]()
    
    @IBOutlet weak var player1: UILabel!
    @IBOutlet weak var player2: UILabel!
    @IBOutlet weak var player3: UILabel!
    @IBOutlet weak var highScore1: UILabel!
    @IBOutlet weak var highScore2: UILabel!
    @IBOutlet weak var highScore3: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let rankingDictionary = UserDefaults.standard.dictionary(forKey: "ranking") as! [String : Double]? {
            sortedHighScoreArray = rankingDictionary.sorted(by: {$0.value > $1.value})
            
            if sortedHighScoreArray.count == 1 {
                player1.text = sortedHighScoreArray[0].key
                highScore1.text = "\(sortedHighScoreArray[0].value)"
            } else if sortedHighScoreArray.count == 2 {
                player1.text = sortedHighScoreArray[0].key
                player2.text = sortedHighScoreArray[1].key
                highScore1.text = "\(sortedHighScoreArray[0].value)"
                highScore2.text = "\(sortedHighScoreArray[1].value)"
            } else {
                player1.text = sortedHighScoreArray[0].key
                player2.text = sortedHighScoreArray[1].key
                player3.text = sortedHighScoreArray[2].key
                highScore1.text = "\(sortedHighScoreArray[0].value)"
                highScore2.text = "\(sortedHighScoreArray[1].value)"
                highScore3.text = "\(sortedHighScoreArray[2].value)"
            }
        }
        
    }
    
    
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        
        let destinationView = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        present(destinationView, animated: true, completion: nil)
    }
    
}
