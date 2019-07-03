//
//  Helper.swift
//  Where And Why
//
//  Created by Khori Armstrong on 2019-06-27.
//  Copyright © 2019 Sigh. All rights reserved.
//

import Foundation
import SpriteKit


class Helper {
    
    static let SECOND: CGFloat = 60.0
    
    
    static func Min(_ val1: Int, _ val2: Int) -> Int {
        if (val1 < val2) {
            return val1
        }
        else {
            return val2
        }
    }
    static func Min(_ val1: CGFloat, _ val2: CGFloat) -> CGFloat {
        if (val1 < val2) {
            return val1
        }
        else {
            return val2
        }
    }
    static func Max(_ val1: Int, _ val2: Int) -> Int {
        if (val1 > val2) {
            return val1
        }
        else {
            return val2
        }
    }
    static func Max(_ val1: CGFloat, _ val2: CGFloat) -> CGFloat {
        if (val1 > val2) {
            return val1
        }
        else {
            return val2
        }
    }
    
    
    
    static func ModWrap(_ value: Int, _ max: Int) -> Int {
        return (value % max + max) % max
    }
    
    // *** Provides a 0-1 value as "time" progresses towards "period". Specify "delay" to offset when "time" starts progressing.
    // *** Example: The alpha value of a black screen that is fading in.
    static func BlendTowards(_ time: CGFloat, _ delay: CGFloat = 0, _ period: CGFloat) -> CGFloat {
        if (period <= 0) { return 1; }
        
        return Min(Max(0, time - delay) / period, 1)
    }
    
    
    static func Lapped(_ time: CGFloat, _ period: CGFloat, _ interval: CGFloat = 1) -> Bool {
        return (time-interval < period && time >= period)
    }
    
    
}
