//
//  BattleView.swift
//  Where And Why
//
//  Created by Khori Armstrong on 2019-07-04.
//  Copyright © 2019 Sigh. All rights reserved.
//

import Foundation
import SpriteKit


class BattleView: UIView {
    
    static var allViews: Array<BattleView> = Array()
    
    
    func register() -> BattleView {
        BattleView.allViews.append(self)
        //
        return self
    }
    
    static func UnloadAll() {
        for view in BattleView.allViews {
            view.removeFromSuperview()
        }
        //
        BattleView.allViews.removeAll()
    }
}
