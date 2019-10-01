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
    mutating func setUpConstraints(forFillView fillView: UIView)
    mutating func updateConstraints(forFillView fillView: UIView)
}

extension DirectionalFillable {
    mutating public func update(level: CGFloat, ofFillView fillView: FillView) {
        currLevel = level
        updateConstraints(forFillView: fillView)
        onUpdateView.onNext(true)
        
    }
}

public protocol HorizontalFillable: DirectionalFillable {}

public protocol VerticalFillable: DirectionalFillable {}

extension HorizontalFillable {
    mutating public func setUpConstraints(forFillView fillView: UIView) {
        guard let v = fillView.superview else { return }
        v.layoutIfNeeded()
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
    }

    mutating public func updateConstraints(forFillView fillView: UIView) {
        guard let v = fillView.superview else { return }
        spanConstraint.isActive = false
        spanConstraint = fillView.widthAnchor.constraint(equalToConstant: v.frame.width * CGFloat(currLevel))
        spanConstraint.isActive = true
    }
}

extension VerticalFillable {
    mutating public func setUpConstraints(forFillView fillView: UIView) {
        guard let v = fillView.superview else { return }
        v.layoutIfNeeded()
        let topBottomConstraint = fillUpDirection == .bottomUp ? fillView.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: 0) : fillView.topAnchor.constraint(equalTo: v.topAnchor, constant: 0)
        
        fixedEndConstraints = [
            fillView.rightAnchor.constraint(equalTo: v.rightAnchor, constant: 0),
            fillView.leftAnchor.constraint(equalTo: v.leftAnchor, constant: 0),
            topBottomConstraint
        ]
        
        spanConstraint = fillView.heightAnchor.constraint(equalToConstant: v.frame.height * CGFloat(currLevel))
        NSLayoutConstraint.activate(fixedEndConstraints)
        spanConstraint.isActive = true
    }
    
    mutating public func updateConstraints(forFillView fillView: UIView) {
        guard let v = fillView.superview else { return }
        spanConstraint.isActive = false
        spanConstraint = fillView.heightAnchor.constraint(equalToConstant: v.frame.height * CGFloat(currLevel))
        spanConstraint.isActive = true
    }
}
