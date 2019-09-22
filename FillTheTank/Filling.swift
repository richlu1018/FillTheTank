//
//  Filling.swift
//  FillTheTank
//
//  Created by Richard Lu on 2019/9/17.
//  Copyright © 2019 Richard Lu. All rights reserved.
//

import Foundation
import UIKit

class Filling: UIView {
    private var bottomConstraint: NSLayoutConstraint!
    private var topConstraint: NSLayoutConstraint!
    private var leftConstraint: NSLayoutConstraint!
    private var rightConstraint: NSLayoutConstraint!
    private var heightConstraint: NSLayoutConstraint!
    private var widthContraint: NSLayoutConstraint!
    
    func setUp(withManager mg: LevelManager) {
        self.backgroundColor = mg.color.value
        // Set up constraints based on fill up type
        guard let tank = self.superview as? Tank else { return }
        self.setUpConstraintsWith(tankView: tank, fDirection: mg.direction.value, initLevel: mg.level.value)
    }
    
    private func setUpConstraintsWith(tankView v: Tank, fDirection: LevelMovingDirection, initLevel lv: Double) {
        self.translatesAutoresizingMaskIntoConstraints = false
        switch fDirection {
        case .bottomUp:
            bottomConstraint = self.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: 0)
            leftConstraint = self.leftAnchor.constraint(equalTo: v.leftAnchor, constant: 0)
            rightConstraint = self.rightAnchor.constraint(equalTo: v.rightAnchor, constant: 0)
            heightConstraint = self.heightAnchor.constraint(equalToConstant: v.frame.height * CGFloat(lv))
            NSLayoutConstraint.activate([bottomConstraint,
                                         leftConstraint,
                                         rightConstraint,
                                         heightConstraint])
        case .topDown:
            leftConstraint = self.leftAnchor.constraint(equalTo: v.leftAnchor, constant: 0)
            rightConstraint = self.rightAnchor.constraint(equalTo: v.rightAnchor, constant: 0)
            topConstraint = self.topAnchor.constraint(equalTo: v.topAnchor, constant: 0)
            heightConstraint = self.heightAnchor.constraint(equalToConstant: v.frame.height * CGFloat(lv))
            
            NSLayoutConstraint.activate([topConstraint,
                                         leftConstraint,
                                         rightConstraint,
                                         heightConstraint])
        case .leftToRight:
            bottomConstraint = self.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: 0)
            leftConstraint = self.leftAnchor.constraint(equalTo: v.leftAnchor, constant: 0)
            topConstraint = self.topAnchor.constraint(equalTo: v.topAnchor, constant: 0)
            widthContraint = self.widthAnchor.constraint(equalToConstant: v.frame.width * CGFloat(lv))
           
            NSLayoutConstraint.activate([topConstraint,
                                         bottomConstraint,
                                         leftConstraint,
                                         widthContraint])
        case .rightToLeft:
            bottomConstraint = self.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: 0)
            rightConstraint = self.rightAnchor.constraint(equalTo: v.rightAnchor, constant: 0)
            topConstraint = self.topAnchor.constraint(equalTo: v.topAnchor, constant: 0)
            widthContraint = self.widthAnchor.constraint(equalToConstant: v.frame.width * CGFloat(lv))

            NSLayoutConstraint.activate([topConstraint,
                                         bottomConstraint,
                                         rightConstraint,
                                         widthContraint])
        }
        
    }

    public func updateLevelStateConstraint() {
        guard let v = self.superview as? Tank else { return }
        let level = v.lvManager.level.value
        let direction = v.lvManager.direction.value
        switch direction {
        case .bottomUp, .topDown:
            heightConstraint.isActive = false
            heightConstraint = self.heightAnchor.constraint(equalToConstant: v.frame.height * CGFloat(level))
            heightConstraint.isActive = true
        case .leftToRight, .rightToLeft:
            widthContraint.isActive = false
            widthContraint = self.widthAnchor.constraint(equalToConstant: v.frame.width * CGFloat(level))
            widthContraint.isActive = true
        }
        self.updateConstraints()
    }
    
    //
    public func updateConstraints(forDirectionChangefrom old: LevelMovingDirection ) {
        guard let v = self.superview as? Tank else { return }
        switch old {
        case .bottomUp:
            NSLayoutConstraint.deactivate([bottomConstraint,
                                    leftConstraint,
                                    rightConstraint,
                                    heightConstraint])
        case .topDown:
        NSLayoutConstraint.deactivate([topConstraint,
                                leftConstraint,
                                rightConstraint,
                                heightConstraint])
        case .leftToRight:
            NSLayoutConstraint.deactivate([topConstraint,
                                    bottomConstraint,
                                    leftConstraint,
                                    widthContraint])
        case .rightToLeft:
            NSLayoutConstraint.deactivate([topConstraint,
                                    bottomConstraint,
                                    rightConstraint,
                                    widthContraint])
        }
        self.setUpConstraintsWith(tankView: v, fDirection: v.lvManager.direction.value, initLevel: v.lvManager.level.value)
    }
}
