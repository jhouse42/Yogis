//
//  CircleButton.swift
//  GameOnMockUp
//
//  Created by Jeanie House on 3/16/15.
//  Copyright (c) 2015 Richard Tyran. All rights reserved.
//

import UIKit

class CircleButton: UIButton {
   
    
    
    override func drawRect(rect: CGRect) {
        
        
        self.layer.cornerRadius = 80 / 2
        self.layer.masksToBounds = true
        
        self.backgroundColor = UIColor.clearColor()
       // self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.whiteColor().CGColor
        
        
        
    }

    
}
