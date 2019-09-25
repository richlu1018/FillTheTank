//
//  Fillable.swift
//  FillTheTank
//
//  Created by Richard Lu on 2019/9/24.
//  Copyright © 2019 Richard Lu. All rights reserved.
//

import Foundation
import RxSwift

public protocol Fillable {
    var fillColor: UIColor { get set }
    var currLevel: Double! { get set }
    mutating func update(level: Double, inContainerView cView: UIView)
    var onUpdateView: PublishSubject<Bool> { get set }
}


