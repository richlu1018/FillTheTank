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
    var bottomConstraint: NSLayoutConstraint!
    var topConstraint: NSLayoutConstraint!
    var leftConstraint: NSLayoutConstraint!
    var rightConstraint: NSLayoutConstraint!
    var heightConstraint: NSLayoutConstraint!
    var widthContraint: NSLayoutConstraint!
    
    func setUp(withManager mg: LevelManager) {
        self.backgroundColor = mg.color
        self.setUpConstraints(withManager: mg)
    }
    
    func setUpConstraints(withManager mg: LevelManager) {
        // Set up constraints based on fill up type
        
        guard let tank = self.superview as? Tank else { return }
        self.setUpConstraintsWith(tankView: tank, fDirection: mg.direction, initLevel: mg.level)
    }

    func updateConstraints(withManager mg: LevelManager) {
        self.updateLevelStateConstraint(forDirection: mg.direction, level: mg.level)
        self.updateConstraints()
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

    private func updateLevelStateConstraint(forDirection d: LevelMovingDirection, level: Double) {
        guard let v = self.superview else { return }
        switch d {
        case .bottomUp, .topDown:
            heightConstraint.isActive = false
            heightConstraint = self.heightAnchor.constraint(equalToConstant: v.frame.height * CGFloat(level))
            heightConstraint.isActive = true
        case .leftToRight, .rightToLeft:
            widthContraint.isActive = false
            widthContraint = self.widthAnchor.constraint(equalToConstant: v.frame.width * CGFloat(level))
            widthContraint.isActive = true
        }
    }
}
