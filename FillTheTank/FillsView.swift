//
//  FillsView.swift
//  FillTheTank
//
//  Created by Richard Lu on 2019/9/17.
//  Copyright © 2019 Richard Lu. All rights reserved.
//

import Foundation
import UIKit

class FillsView: UIView {
    var bottomConstraint: NSLayoutConstraint!
    var topConstraint: NSLayoutConstraint!
    var leftConstraint: NSLayoutConstraint!
    var rightConstraint: NSLayoutConstraint!
    var heightConstraint: NSLayoutConstraint!
    var widthContraint: NSLayoutConstraint!
    
    func setUp(withManager mg: FillUpManager) {
        self.backgroundColor = mg.fColor
        self.setUpConstraints(withManager: mg)
    }
    
    func setUpConstraints(withManager mg: FillUpManager) {
        // Set up constraints based on fill up type
        
        guard let tank = self.superview as? Tank else { return }
        switch mg.fType {
        case .constantly:
            self.setUpConstantFillUpConstraintsWith(tankView: tank, fDirection: mg.fDirection)
        case .progressively:
            self.setUpProgressFillUpConstraintsWith(tankView: tank, fDirection: mg.fDirection, initProgress: mg.fProgress)
        }
    }

    func updateConstraints(withManager mg: FillUpManager) {
        switch mg.fType {
        case .constantly:
            self.updateConstantFillUpStateConstraint(forDirection: mg.fDirection)
        case .progressively:
            self.updateProgressFillUpStateConstraint(forDirection: mg.fDirection, progress: mg.fProgress)
            self.updateConstraints()
        }
    }
    
    // private func
    private func setUpConstantFillUpConstraintsWith(tankView v: Tank, fDirection: FillingDirection) {
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
    
    
    private func updateConstantFillUpStateConstraint(forDirection d: FillingDirection) {
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
    
    private func setUpProgressFillUpConstraintsWith(tankView v: Tank, fDirection: FillingDirection, initProgress progress: Double) {
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

    private func updateProgressFillUpStateConstraint(forDirection d: FillingDirection, progress: Double) {
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
