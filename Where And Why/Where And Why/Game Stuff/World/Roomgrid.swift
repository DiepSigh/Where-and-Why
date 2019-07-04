//
//  Roomgrid.swift
//  Where And Why
//
//  Created by Khori Armstrong on 2019-07-03.
//  Copyright © 2019 Sigh. All rights reserved.
//

import Foundation
import SpriteKit







enum GridSpots {
    case Empty
    case Full
}


class Roomgrid {
    
    static let GRIDSNAP: Int = 64
    private var roomdata: Grid<GridSpots> = Grid(1, 1, .Empty)
    
    
    func Initialize() {
        
    }
    
    
    func Reconstruct(_ rows: Int, _ cols: Int, _ def: GridSpots = .Empty) {
        roomdata = Grid(rows, cols, def)
    }
    
    // *** Copy the data from an existing grid.
    func ReadMap(what: Grid<GridSpots>) {
        Reconstruct(what.rows, what.columns, .Empty)
        //
        for xx in 0...what.rows {
            for yy in 0...what.columns {
                SetSpot(xx, yy, what[xx,yy])
            }
        }
    }
    func SetSpot(_ xx: Int, _ yy: Int, _ what: GridSpots) {
        roomdata[xx,yy] = what
    }
    
    
    func Check(_ xx: Int, _ yy: Int) -> GridSpots {
        return roomdata[xx,yy]
    }
    
    func CanTravel(fxx: Int, fyy: Int, txx: Int, tyy: Int) -> Bool {
        if Check(txx, tyy) == .Full {
            return false
        }
        
        
        return true
    }
}
