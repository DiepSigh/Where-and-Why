//
//  WorldActor.swift
//  Where And Why
//
//  Created by Khori Armstrong on 2019-07-03.
//  Copyright © 2019 Sigh. All rights reserved.
//

import Foundation
import SpriteKit



class WorldActor: SKSpriteNode {
    
    
    var gx: Int = 0
    var gy: Int = 0
    
    var isClicking: Bool = false
    var clickVal: CGFloat = 0.0
    var clickRate: CGFloat = 0.0
    var clickx: Int = 0
    var clicky: Int = 0
    
 
    func ClickTowards(_ xx: Int, _ yy: Int, rate: CGFloat = 3/Helper.SECOND) {
        if (!isClicking) {
            isClicking = true
            
            
            
            clickx = Helper.Sign(CGFloat(xx))
            clicky = Helper.Sign(CGFloat(yy))
            clickRate = rate
        }
    }
    
    func Move(gridx: Int, gridy: Int) {
        
    }
    func MoveTowards(_ xx: Int, _ yy: Int) {
        self.gx += xx;
        self.gy += yy;
        //
        self.position.x = CGFloat(self.gx * Roomgrid.GRIDSNAP)
        self.position.y = CGFloat(self.gy * Roomgrid.GRIDSNAP)
    }
    func ProcessMovement() {
        if (isClicking) {
            clickVal += clickRate
            //
            self.position.x = (CGFloat(self.gx) + CGFloat(self.clickx) * self.clickVal) * CGFloat(Roomgrid.GRIDSNAP)
            self.position.y = (CGFloat(self.gy) + CGFloat(self.clicky) * self.clickVal) * CGFloat(Roomgrid.GRIDSNAP)
            //
            if (clickVal >= 1) {
                clickVal -= 1
                //
                MoveTowards(clickx, clicky)
                //
                isClicking = false
            }
        }
        else {
            clickVal = 0.0
        }
    }
    
    
    func doUpdate(_ currentTime: TimeInterval) {
        
        
        ProcessMovement()
    }
    
    
    func PlaceOntoGrid() {
        self.gx = Int(self.position.x / CGFloat(Roomgrid.GRIDSNAP))
        self.gy = Int(self.position.y / CGFloat(Roomgrid.GRIDSNAP))
    }
    
    
}
