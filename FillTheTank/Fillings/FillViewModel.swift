//
//  FillViewModel.swift
//  FillTheTank
//
//  Created by Richard Lu on 2019/9/25.
//  Copyright © 2019 Richard Lu. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift

public final class RightToLeftFillViewModel: HorizontalFillable {
    public var widthConstraint: NSLayoutConstraint!
    public var fillColor: UIColor
    public var currLevel: Double!
    public var fillUpDirection: LevelMovingDirection = .rightToLeft
    public var onUpdateView = PublishSubject<Bool>()
    public init(initLevel: Double, fillColor: UIColor) {
        self.currLevel = initLevel
        self.fillColor = fillColor
    }
}

public final class LeftToRightFillViewModel: HorizontalFillable {
    public var widthConstraint: NSLayoutConstraint!
    public var fillColor: UIColor
    public var currLevel: Double!
    public var fillUpDirection: LevelMovingDirection = .leftToRight
    public var onUpdateView = PublishSubject<Bool>()
    public init(initLevel: Double, fillColor: UIColor) {
        self.currLevel = initLevel
        self.fillColor = fillColor
    }
}

public final class TopDownFillViewModel: VerticalFillable {
    public var heightConstraint: NSLayoutConstraint!
    public var fillColor: UIColor
    public var currLevel: Double!
    public var fillUpDirection: LevelMovingDirection = .topDown
    public var onUpdateView = PublishSubject<Bool>()
    public init(initLevel: Double, fillColor: UIColor) {
        self.currLevel = initLevel
        self.fillColor = fillColor
    }
}

public final class BottomUpFillViewModel: VerticalFillable {
    public var heightConstraint: NSLayoutConstraint!
    public var fillColor: UIColor
    public var currLevel: Double!
    public var fillUpDirection: LevelMovingDirection = .bottomUp
    public var onUpdateView = PublishSubject<Bool>()
    public init(initLevel: Double, fillColor: UIColor) {
        self.currLevel = initLevel
        self.fillColor = fillColor
    }
}
