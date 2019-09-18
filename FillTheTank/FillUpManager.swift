//
//  FillUpManager.swift
//  FillTheTank
//
//  Created by Richard Lu on 2019/9/17.
//  Copyright © 2019 Richard Lu. All rights reserved.
//

import Foundation
import UIKit

public enum FillingDirection {
    case bottmUp
    case topDown
    case leftToRight
    case rightToLeft
}

public enum FillingType {
    case progressively
    case constantly
}

public struct FillUpManager {
    private(set) var fDirection: FillingDirection
    private(set) var fType:FillingType
    private(set) var fDuration: Double  // Count down seconds
    private(set) var fProgress: Double  // 0 to 1
    private(set) var fColor: UIColor
    
    public init(progressivelyFillUpWithDirection direction: FillingDirection, initialProgress: Double, fillUpColor: UIColor) {
        fDirection = direction
        fType = .progressively
        fColor = fillUpColor
        fDuration = -1 // Invalidate fill up duration
        fProgress = initialProgress
        update(fillUpProgress: initialProgress)
        
    }
    
    public init(constantlyFillUpWithDirection direction: FillingDirection, countDownDuration: Double, fillUpColor: UIColor) {
        fDirection = direction
        fType = .constantly
        fDuration = countDownDuration
        fColor = fillUpColor
        fProgress = -1  // Invalidate fill up progress
    }

    public mutating func update(fillUpProgress curProgress: Double) {
        fProgress = validProgress(curProgress)
    }
    
    func validProgress(_ progress: Double) -> Double {
        // Make sure progress is within 0 to 1
        if progress < 0.0 { return 0.0 }
        if progress > 1.0 { return 1.0 }
        return progress
    }
}
