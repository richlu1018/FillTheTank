//
//  Containable.swift
//  FillTheTank
//
//  Created by Richard Lu on 2019/9/26.
//  Copyright © 2019 Richard Lu. All rights reserved.
//

import Foundation
import RxSwift

public protocol Containable {
    var fillViewSubject: BehaviorSubject<FillView> { get set }
    func setUpConstraints(toView v: UIView)
}

extension Containable {
    public func setUpConstraints(toView v: UIView) {
        let fillView = try! fillViewSubject.value()
        fillView.viewModel.setUpConstraints(forFillView: fillView, toView: v)
    }
}
