//
//  DirectionalFillable.swift
//  FillTheTank
//
//  Created by Richard Lu on 2019/9/24.
//  Copyright © 2019 Richard Lu. All rights reserved.
//

import Foundation

public protocol DirectionalFillable: Fillable, Directional {
    mutating func setUpConstraints(forFillView fillView: UIView, toView: UIView)
}

public protocol HorizontalFillable: DirectionalFillable {
    var widthConstraint: NSLayoutConstraint! { get set }
}

public protocol VerticalFillable: DirectionalFillable {
    var heightConstraint: NSLayoutConstraint! { get set }
}

extension HorizontalFillable {
    mutating public func setUpConstraints(forFillView fillView: UIView, toView v: UIView) {
        
        let bottomConstraint = fillView.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: 0)
        let sideConstraint = fillUpDirection == .rightToLeft ?
            fillView.rightAnchor.constraint(equalTo: v.rightAnchor, constant: 0) :
            fillView.leftAnchor.constraint(equalTo: v.leftAnchor, constant: 0)
        let topConstraint = fillView.topAnchor.constraint(equalTo: v.topAnchor, constant: 0)
        widthConstraint = fillView.widthAnchor.constraint(equalToConstant: v.frame.width * CGFloat(currLevel))
        NSLayoutConstraint.activate([sideConstraint,
                                     bottomConstraint,
                                     topConstraint,
                                     widthConstraint])
        v.layoutIfNeeded()
    }
    
    mutating public func update(level: Double, inContainerView cView: UIView) {
        cView.layoutIfNeeded()
        currLevel = level
        widthConstraint.isActive = false
        widthConstraint.constant = cView.frame.width * CGFloat(currLevel)
        widthConstraint.isActive = true
        onUpdateView.onNext(true)
    }
}

extension VerticalFillable {
    mutating public func setUpConstraints(forFillView fillView: UIView, toView v: UIView) {
        
        let topBottomConstraint = fillUpDirection == .bottomUp ? fillView.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: 0) : fillView.topAnchor.constraint(equalTo: v.topAnchor, constant: 0)
        let rightConstraint = fillView.rightAnchor.constraint(equalTo: v.rightAnchor, constant: 0)
        let leftConstraint = fillView.leftAnchor.constraint(equalTo: v.leftAnchor, constant: 0)
        heightConstraint = fillView.heightAnchor.constraint(equalToConstant: v.frame.height * CGFloat(currLevel))
        NSLayoutConstraint.activate([topBottomConstraint,
                                     rightConstraint,
                                     leftConstraint,
                                     heightConstraint])
        v.layoutIfNeeded()
    }
    
    mutating public func update(level: Double, inContainerView cView: UIView) {
        cView.layoutIfNeeded()
        currLevel = level
        heightConstraint.isActive = false
        heightConstraint.constant = cView.frame.height * CGFloat(currLevel)
        heightConstraint.isActive = true
        onUpdateView.onNext(true)
    }
}
