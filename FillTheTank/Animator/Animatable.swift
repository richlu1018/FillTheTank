//
//  Animatable.swift
//  FillTheTank
//
//  Created by Richard Lu on 2019/9/24.
//  Copyright © 2019 Richard Lu. All rights reserved.
//

import Foundation

public protocol Animatable {
    var animateDuration: Double { get set }
    var animationCompletionBlock: ((Bool)->Void)? { get set}
    func animateForChanges()
}

extension Animatable where Self: UIView {
    public func animateForChanges() {
        UIView.animate(withDuration: animateDuration, animations: {
            self.superview?.layoutIfNeeded()
        }, completion: animationCompletionBlock)
    }
}
