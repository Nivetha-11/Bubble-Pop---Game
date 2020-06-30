//
//  File.swift
//  lab5_A2_Demo1
//
//  Created by Nivetha Anand on 15/5/20.
//  Copyright © 2020 uts. All rights reserved.
//

import UIKit

class Bubble:UIButton {
    
    var value: Double = 0
    var radius: UInt32 {
        return UInt32(UIScreen.main.bounds.width / 12)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = CGFloat(radius)
        
        let possibility = Int(arc4random_uniform(100))
        switch possibility {
        case 0...39:
            self.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            self.value = 1
        case 40...69:
            self.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            self.value = 2
        case 70...84:
            self.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            self.value = 5
        case 85...94:
            self.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            self.value = 8
        case 95...99:
            self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.value = 10
        default: print("error")
        }
        
    }
    
    func animation() {
        let springAnimation = CASpringAnimation(keyPath: "transform.scale")
        springAnimation.duration = 0.6
        springAnimation.fromValue = 1
        springAnimation.toValue = 0.8
        springAnimation.repeatCount = 1
        springAnimation.initialVelocity = 0.5
        springAnimation.damping = 1
        
        layer.add(springAnimation, forKey: nil)
    }
    
    func fadeIn(){
        
        // effect of fade in
        // we want to animate the opacity property
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0
        animation.toValue = 1
        // how many seconds you want animation to last
        animation.duration = 2.0
        animation.repeatCount = 2.0
        animation.autoreverses = true
        
        self.layer.add(animation, forKey:nil)
        
    }
    
    func shake(){
        
        //shake effect
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 3
        shake.autoreverses = true
        
        
        let fromPoint = CGPoint(x: self.center.x - 8, y: self.center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: self.center.x + 8, y: self.center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        self.layer.add(shake, forKey: nil)
    }
}
