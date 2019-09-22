//
//  LevelManager.swift
//  FillTheTank
//
//  Created by Richard Lu on 2019/9/17.
//  Copyright © 2019 Richard Lu. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

public enum LevelMovingDirection {
    case bottomUp
    case topDown
    case leftToRight
    case rightToLeft
}

public class LevelManager {
    private(set) var direction: BehaviorRelay<LevelMovingDirection> // fill up direction
    private(set) var level: BehaviorRelay<Double> = BehaviorRelay(value: 0.0)  // 0 to 1
    private(set) var color: BehaviorRelay<UIColor> // color of fillings
    private(set) var duration: Double  // Count down secondsv

    public init(moveWithDirection d: LevelMovingDirection, duration dur: Double, initLevel lv: Double, fillingsColor c: UIColor) {
        direction = BehaviorRelay(value: d)
        color = BehaviorRelay(value: c)
        duration =  dur
        level.accept(validLevel(lv))
    }

    public func update(level lv: Double) {
        level.accept(validLevel(lv))
    }

    public func update(duration d: Double) {
        duration = d
    }

    public func update(color c: UIColor) {
        color.accept(c)
    }

    public func update(direction d: LevelMovingDirection) {
        direction.accept(d)
    }

    public func reverseDirection() {
        switch direction.value {
        case .bottomUp:
            direction.accept(.topDown)
        case .topDown:
            direction.accept(.bottomUp)
        case .rightToLeft:
            direction.accept(.leftToRight)
        case .leftToRight:
            direction.accept(.rightToLeft)
        }
    }

    func validLevel(_ lv: Double) -> Double {
        // Make sure progress is within 0 to 1
        if lv < 0.0 { return 0.0 }
        if lv > 1.0 { return 1.0 }
        return lv
    }
}
