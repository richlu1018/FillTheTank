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

public enum LevelMovement {
    case progressively
    case constantly
}

public struct LevelManager {
    private(set) var direction: LevelMovingDirection
    private(set) var movement: LevelMovement
    private(set) var duration: Double  // Count down seconds
    private(set) var progress: Double  // 0 to 1
    private(set) var color: UIColor // color of fillings
    
    public init(progressivelyMoveWithDirection d: LevelMovingDirection, initialProgress p: Double, fillingsColor c: UIColor) {
        direction = d
        movement = .progressively
        color = c
        duration = -1 // Invalidate level movement duration
        progress = p
        update(levelProgress: p)
        
    }
    
    public init(constantlyMoveWithDirection d: LevelMovingDirection, countDownDuration dur: Double, fillingsColor c: UIColor) {
        direction = d
        movement = .constantly
        duration = dur
        color = c
        progress = -1  // Invalidate fill up progress
    }

    public mutating func update(levelProgress curProgress: Double) {
        progress = validProgress(curProgress)
    }
    
    func validProgress(_ progress: Double) -> Double {
        // Make sure progress is within 0 to 1
        if progress < 0.0 { return 0.0 }
        if progress > 1.0 { return 1.0 }
        return progress
    }
}
