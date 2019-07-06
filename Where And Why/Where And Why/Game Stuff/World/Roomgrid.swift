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
    
    static let GRIDSNAP: Int = 128
    private var roomdata: Grid<GridSpots> = Grid(1, 1, .Empty)
    
    
    func Initialize() {
        
    }
    
    
    
    var tilemap: SKTileMapNode!
    var solidmap: SKTileMapNode!
    
    func Reconstruct(_ rows: Int, _ cols: Int, _ def: GridSpots = .Empty) {
        roomdata = Grid(rows, cols, def)
        //
        if solidmap != nil {
            ReadMap(solidmap)
        }
    }
    
    // *** Sets up the grid with a tile map
    func ReadMap(_ map: SKTileMapNode) {
        for xx in 0...roomdata.rows-1 {
            for yy in 0...roomdata.columns-1 {
                roomdata[xx,yy] = (map.tileDefinition(atColumn: xx, row: yy) == nil) ? .Empty : .Full
            }
        }
    }
    
    
    func Check(_ xx: Int, _ yy: Int) -> GridSpots {
        /*
        if solidmap.tileDefinition(atColumn: xx, row: yy) == nil {
            return .Empty
        }
        else {
            return .Full
        }
 */
        
        return roomdata[xx,yy]
    }
    
    func CanTravel(fxx: Int, fyy: Int, txx: Int, tyy: Int) -> Bool {
        if Check(txx, tyy) == .Full {
            return false
        }
        
        
        return true
    }
}
