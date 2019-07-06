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
            
            var tapx = floor(Inputter.tapLocation.x / CGFloat(Roomgrid.GRIDSNAP)) - CGFloat(self.gx)
            var tapy = floor(Inputter.tapLocation.y / CGFloat(Roomgrid.GRIDSNAP)) - CGFloat(self.gy)
            //
            let largest = Helper.Abs(Helper.Max(tapx,tapy))
            tapx = round(tapx / largest)
            tapy = round(tapy / largest)
            //
            ClickTowards(Helper.Sign(tapx), Helper.Sign(tapy))
        }
        
        
        super.doUpdate(currentTime)
    }
    
    
}
