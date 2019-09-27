//
//  Fillable.swift
//  FillTheTank
//
//  Created by Richard Lu on 2019/9/24.
//  Copyright © 2019 Richard Lu. All rights reserved.
//

import Foundation
import RxSwift

public enum FillColor {
    case customColor(UIColor)
}

extension FillColor {
    var color: UIColor {
        get {
            switch self {
            case .customColor(let color):
                return color
            }
        }
    }
}

public protocol Fillable {
    var fillColor: FillColor { get set }
    var currLevel: CGFloat! { get set }
    mutating func update(level: CGFloat, inContainerView cView: UIView)
    var onUpdateView: PublishSubject<Bool> { get set }
}

