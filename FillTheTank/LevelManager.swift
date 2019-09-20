//
//  LevelManager.swift
//  FillTheTank
//
//  Created by Richard Lu on 2019/9/17.
//  Copyright © 2019 Richard Lu. All rights reserved.
//

import Foundation
import UIKit

public enum LevelMovingDirection {
    case bottomUp
    case topDown
    case leftToRight
    case rightToLeft
}

public struct LevelManager {
    private(set) var direction: LevelMovingDirection
    private(set) var duration: Double  // Count down seconds
    private(set) var level: Double  // 0 to 1
    private(set) var color: UIColor // color of fillings

    public init(moveWithDirection d: LevelMovingDirection, duration dur: Double, initLevel lv: Double, fillingsColor c: UIColor) {
        direction = d
        color = c
        duration =  dur
        level = lv
        update(level: lv)
        
    }

    public mutating func update(level lv: Double) {
        level = validLevel(lv)
    }
    
    func validLevel(_ lv: Double) -> Double {
        // Make sure progress is within 0 to 1
        if lv < 0.0 { return 0.0 }
        if lv > 1.0 { return 1.0 }
        return lv
    }
}
