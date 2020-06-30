//
//  LoginViewController.swift
//  lab5_A2_Demo1
//
//  Created by Nivetha Anand on 10/5/20.
//  Copyright © 2020 uts. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate{
    
    var bubbleSliderValue = 15
    var gameTimeSliderValue = 60
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var playerName: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerName.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        safe wrapping
        let dest = segue.destination as! GameViewController
        dest.maxBubbleNumber = bubbleSliderValue
        dest.remainingSeconds = gameTimeSliderValue
        dest.playerName = playerName.text!
        
    }
    
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        
        if sender.tag == 1{
            bubbleSliderValue = Int(sender.value)
            numberLabel.text = "\(bubbleSliderValue)"
        }
        
        if sender.tag == 2{
            gameTimeSliderValue = Int(sender.value)
            timeLabel.text = "\(gameTimeSliderValue)"
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let currentText = textField.text {
            if currentText.count > 10 {
                textField.deleteBackward()
            } else {
                textField.resignFirstResponder()
            }
        }
        
        return true
    }
}





