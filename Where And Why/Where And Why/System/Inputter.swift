//
//  Inputter.swift
//  Where And Why
//
//  Created by Khori Armstrong on 2019-07-02.
//  Copyright © 2019 Sigh. All rights reserved.
//

import Foundation
import SpriteKit

class Inputter {
    
    
    
    // static var TapList: Array<Tap> = Array()
    
    static var isTapping: Bool = false
    //
    static var wasTapped: Bool = false
    static var wasMoved: Bool = false
    static var wasReleased: Bool = false
    static var tapLocation: CGPoint!
    
    
    static func TapStart(_ touch: UITouch) {
        // TapList.append(Tap(touch))
        //
        wasTapped = true
        isTapping = true
        //
        tapLocation = touch.location(in: GameManager.Instance().scene!)
    }
    static func TapMove(_ touch: UITouch) {
        wasMoved = true
        //
        tapLocation = touch.location(in: GameManager.Instance().scene!)
    }
    static func TapEnd(_ touch: UITouch) {
        
        isTapping = true
        wasReleased = true
        //
        tapLocation = nil
        
        //
        /*
        for n in 0...TapList.count-1 {
            let tap: Tap = TapList[n]
            
            if (tap.touch == touch) {
                TapList.remove(at: n)
                break
            }
        }
        */

    }
    
    static func Update() {
        wasTapped = false
        wasMoved = false
        wasReleased = false
    }
    /*
    static func Clear() {
        
    }
 */
    
 
    
    /*
    class Tap {
        var touch: UITouch
        
        
        init(_ tap: UITouch) {
            self.touch = tap
        }
    }
    */
}
