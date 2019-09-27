//
//  DirectionalFillable.swift
//  FillTheTank
//
//  Created by Richard Lu on 2019/9/24.
//  Copyright © 2019 Richard Lu. All rights reserved.
//

import Foundation

public protocol DirectionalFillable: Fillable, Directional {
    var fixedEndConstraints: [NSLayoutConstraint]! { get set }
    var spanConstraint: NSLayoutConstraint! { get set }
    mutating func setUpConstraints(forFillView fillView: UIView, toView: UIView)
}

extension DirectionalFillable {
    mutating public func update(level: Double, inContainerView cView: UIView) {
        cView.layoutIfNeeded()
        spanConstraint.isActive = false
        let currConstant = spanConstraint.constant == 0 ?
            CGFloat.leastNormalMagnitude : spanConstraint.constant
        spanConstraint.constant = currConstant * CGFloat(level)/CGFloat(currLevel == 0 ? Double.leastNormalMagnitude : currLevel)
        spanConstraint.isActive = true
        onUpdateView.onNext(true)
        currLevel = level
    }
}

public protocol HorizontalFillable: DirectionalFillable {}

public protocol VerticalFillable: DirectionalFillable {}

extension HorizontalFillable {
    mutating public func setUpConstraints(forFillView fillView: UIView, toView v: UIView) {
        
        let sideConstraint = fillUpDirection == .rightToLeft ?
            fillView.rightAnchor.constraint(equalTo: v.rightAnchor, constant: 0) :
            fillView.leftAnchor.constraint(equalTo: v.leftAnchor, constant: 0)
        
        fixedEndConstraints = [
            fillView.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: 0),
            fillView.topAnchor.constraint(equalTo: v.topAnchor, constant: 0),
            sideConstraint
        ]
        
        spanConstraint = fillView.widthAnchor.constraint(equalToConstant: v.frame.width * CGFloat(currLevel))
        
        NSLayoutConstraint.activate(fixedEndConstraints)
        spanConstraint.isActive = true
        
        v.layoutIfNeeded()
    }
}

extension VerticalFillable {
    mutating public func setUpConstraints(forFillView fillView: UIView, toView v: UIView) {
        
        let topBottomConstraint = fillUpDirection == .bottomUp ? fillView.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: 0) : fillView.topAnchor.constraint(equalTo: v.topAnchor, constant: 0)
        
        fixedEndConstraints = [
            fillView.rightAnchor.constraint(equalTo: v.rightAnchor, constant: 0),
            fillView.leftAnchor.constraint(equalTo: v.leftAnchor, constant: 0),
            topBottomConstraint
        ]
        
        spanConstraint = fillView.heightAnchor.constraint(equalToConstant: v.frame.height * CGFloat(currLevel))
        
        NSLayoutConstraint.activate(fixedEndConstraints)
        spanConstraint.isActive = true
        v.layoutIfNeeded()
    }
}
