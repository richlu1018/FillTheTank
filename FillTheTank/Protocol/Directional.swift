//
//  Directional.swift
//  FillTheTank
//
//  Created by Richard Lu on 2019/9/24.
//  Copyright © 2019 Richard Lu. All rights reserved.
//

import Foundation

public enum LevelMovingDirection {
    case bottomUp
    case topDown
    case leftToRight
    case rightToLeft
}
public protocol Directional {
    var fillUpDirection: LevelMovingDirection { get }
}
