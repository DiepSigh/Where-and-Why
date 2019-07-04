//
//  WorldPlayer.swift
//  Where And Why
//
//  Created by Khori Armstrong on 2019-07-03.
//  Copyright © 2019 Sigh. All rights reserved.
//

import Foundation
import SpriteKit

class WorldPlayer: WorldActor {
    
    
    
    
    
    override func doUpdate(_ currentTime: TimeInterval) {
        if (Inputter.isTapping) {
            /*
            Move(gridx: Int(Inputter.tapLocation.x / CGFloat(Roomgrid.GRIDSNAP)), gridy: Int(Inputter.tapLocation.y / CGFloat(Roomgrid.GRIDSNAP)))
 */
            ClickTowards(Helper.Sign(Inputter.tapLocation.x - self.position.x), Helper.Sign(Inputter.tapLocation.y - self.position.y))
        }
        
        
        super.doUpdate(currentTime)
        
        
        print("Player: \(self.gx)/\(self.gy)")
        print("Player: \(self.position.x)/\(self.position.y)")
    }
    
    
}
