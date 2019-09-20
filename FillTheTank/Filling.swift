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
        switch mg.movement {
        case .constantly:
            self.setUpConstantFillUpConstraintsWith(tankView: tank, fDirection: mg.direction)
        case .progressively:
            self.setUpProgressFillUpConstraintsWith(tankView: tank, fDirection: mg.direction, initProgress: mg.progress)
        }
    }

    func updateConstraints(withManager mg: LevelManager) {
        switch mg.movement {
        case .constantly:
            self.updateConstantFillUpStateConstraint(forDirection: mg.direction)
        case .progressively:
            self.updateProgressFillUpStateConstraint(forDirection: mg.direction, progress: mg.progress)
            self.updateConstraints()
        }
    }
    
    // private func
    private func setUpConstantFillUpConstraintsWith(tankView v: Tank, fDirection: LevelMovingDirection) {
        self.translatesAutoresizingMaskIntoConstraints = false
        switch fDirection {
        case .bottomUp:
            bottomConstraint = self.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: 0)
            leftConstraint = self.leftAnchor.constraint(equalTo: v.leftAnchor, constant: 0)
            rightConstraint = self.rightAnchor.constraint(equalTo: v.rightAnchor, constant: 0)
            topConstraint = self.topAnchor.constraint(equalTo: v.topAnchor, constant: 0)
            heightConstraint = self.heightAnchor.constraint(equalToConstant: 0)
            
            // topConstraint is for end state of bottomUp filling up
            // so it won't be activate in init set up
            NSLayoutConstraint.activate([bottomConstraint,
                                         leftConstraint,
                                         rightConstraint,
                                         heightConstraint])
        case .topDown:
            bottomConstraint = self.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: 0)
            leftConstraint = self.leftAnchor.constraint(equalTo: v.leftAnchor, constant: 0)
            rightConstraint = self.rightAnchor.constraint(equalTo: v.rightAnchor, constant: 0)
            topConstraint = self.topAnchor.constraint(equalTo: v.topAnchor, constant: 0)
            heightConstraint = self.heightAnchor.constraint(equalToConstant: 0)
            // bottomConstraint is for end state of topDown filling up
            // so it won't be activate in init set up
            NSLayoutConstraint.activate([topConstraint,
                                         leftConstraint,
                                         rightConstraint,
                                         heightConstraint])
        case .leftToRight:
            bottomConstraint = self.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: 0)
            leftConstraint = self.leftAnchor.constraint(equalTo: v.leftAnchor, constant: 0)
            rightConstraint = self.rightAnchor.constraint(equalTo: v.rightAnchor, constant: 0)
            topConstraint = self.topAnchor.constraint(equalTo: v.topAnchor, constant: 0)
            widthContraint = self.widthAnchor.constraint(equalToConstant: 0)
            // rightConstraint is for end state of leftToRight filling up
            // so it won't be activate in init set up
            NSLayoutConstraint.activate([topConstraint,
                                         bottomConstraint,
                                         leftConstraint,
                                         widthContraint])
        case .rightToLeft:
            bottomConstraint = self.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: 0)
            leftConstraint = self.leftAnchor.constraint(equalTo: v.leftAnchor, constant: 0)
            rightConstraint = self.rightAnchor.constraint(equalTo: v.rightAnchor, constant: 0)
            topConstraint = self.topAnchor.constraint(equalTo: v.topAnchor, constant: 0)
            widthContraint = self.widthAnchor.constraint(equalToConstant: 0)
            // rightConstraint is for end state of rightToLeft filling up
            // so it won't be activate in init set up
            NSLayoutConstraint.activate([topConstraint,
                                         bottomConstraint,
                                         leftConstraint,
                                         widthContraint])
        }
        
    }
    
    
    private func updateConstantFillUpStateConstraint(forDirection d: LevelMovingDirection) {
        switch d {
        case .bottomUp:
            heightConstraint.isActive = false
            topConstraint.isActive = true
        case .topDown:
            heightConstraint.isActive = false
            bottomConstraint.isActive = true
        case .leftToRight:
            widthContraint.isActive = false
            rightConstraint.isActive = true
        case .rightToLeft:
            widthContraint.isActive = false
            rightConstraint.isActive = true
        }
    }
    
    private func setUpProgressFillUpConstraintsWith(tankView v: Tank, fDirection: LevelMovingDirection, initProgress progress: Double) {
        self.translatesAutoresizingMaskIntoConstraints = false
        switch fDirection {
        case .bottomUp:
            bottomConstraint = self.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: 0)
            leftConstraint = self.leftAnchor.constraint(equalTo: v.leftAnchor, constant: 0)
            rightConstraint = self.rightAnchor.constraint(equalTo: v.rightAnchor, constant: 0)
            heightConstraint = self.heightAnchor.constraint(equalToConstant: v.frame.height * CGFloat(progress))

            NSLayoutConstraint.activate([bottomConstraint,
                                         leftConstraint,
                                         rightConstraint,
                                         heightConstraint])
        case .topDown:
            leftConstraint = self.leftAnchor.constraint(equalTo: v.leftAnchor, constant: 0)
            rightConstraint = self.rightAnchor.constraint(equalTo: v.rightAnchor, constant: 0)
            topConstraint = self.topAnchor.constraint(equalTo: v.topAnchor, constant: 0)
            heightConstraint = self.heightAnchor.constraint(equalToConstant: v.frame.height * CGFloat(progress))
            
            NSLayoutConstraint.activate([topConstraint,
                                         leftConstraint,
                                         rightConstraint,
                                         heightConstraint])
        case .leftToRight:
            bottomConstraint = self.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: 0)
            leftConstraint = self.leftAnchor.constraint(equalTo: v.leftAnchor, constant: 0)
            topConstraint = self.topAnchor.constraint(equalTo: v.topAnchor, constant: 0)
            widthContraint = self.widthAnchor.constraint(equalToConstant: v.frame.width * CGFloat(progress))
           
            NSLayoutConstraint.activate([topConstraint,
                                         bottomConstraint,
                                         leftConstraint,
                                         widthContraint])
        case .rightToLeft:
            bottomConstraint = self.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: 0)
            rightConstraint = self.rightAnchor.constraint(equalTo: v.rightAnchor, constant: 0)
            topConstraint = self.topAnchor.constraint(equalTo: v.topAnchor, constant: 0)
            widthContraint = self.widthAnchor.constraint(equalToConstant: v.frame.width * CGFloat(progress))

            NSLayoutConstraint.activate([topConstraint,
                                         bottomConstraint,
                                         rightConstraint,
                                         widthContraint])
        }
        
    }

    private func updateProgressFillUpStateConstraint(forDirection d: LevelMovingDirection, progress: Double) {
        guard let v = self.superview else { return }
        switch d {
        case .bottomUp, .topDown:
            heightConstraint.isActive = false
            heightConstraint = self.heightAnchor.constraint(equalToConstant: v.frame.height * CGFloat(progress))
            heightConstraint.isActive = true
        case .leftToRight, .rightToLeft:
            widthContraint.isActive = false
            widthContraint = self.widthAnchor.constraint(equalToConstant: v.frame.width * CGFloat(progress))
            widthContraint.isActive = true
        }
    }
}
