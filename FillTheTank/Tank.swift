//
//  Tank.swift
//  FillTheTank
//
//  Created by Richard Lu on 2019/9/17.
//  Copyright © 2019 Richard Lu. All rights reserved.
//

import Foundation
import UIKit

open class Tank: UIView {
    
    public var titleLabel: UILabel?
    private(set) var lvManager: LevelManager
    private var fillView: Filling!
    private var dismissWhenTankIsFull: Bool = false

    public init(lvManager: LevelManager) {
        // Set up lvManager to provide animation info
        self.lvManager = lvManager
        super.init(frame: .zero)
        // Avoid automatically generated constraints
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layoutIfNeeded()
    }
    
    public func updateLvManager(_ lm: LevelManager) -> Tank {
        lvManager = lm
        return self
    }

    override open func layoutIfNeeded() {
        super.layoutIfNeeded()
        //Init fills view for filling up animation
        if fillView == nil {
            self.initFillView()
            self.clipsToBounds = true
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    public func backgroundColor(_ bgc: UIColor) -> Tank {
        self.backgroundColor = bgc
        return self
    }

    public func cornerRadius(_ r: CGFloat) -> Tank {
        self.layer.cornerRadius = r
        return self
    }
    
    public func borderWidth(_ w: CGFloat) -> Tank {
        self.layer.borderWidth = w
        return self
    }

    public func borderColor(_ c: UIColor) -> Tank {
        self.layer.borderColor = c.cgColor
        return self
    }

    public func titleLabel(attributedString t: String, withAttributes attr: [NSAttributedString.Key: Any]) -> Tank {
        if titleLabel == nil {
            self.initTitleLabel()
        }
        let attrText = NSAttributedString(string: t, attributes: attr)
        self.titleLabel?.attributedText = attrText
        self.titleLabel?.sizeToFit()
        return self
    }

    public func dismissWhenTankIsFull(_ dismiss: Bool) -> Tank {
        self.dismissWhenTankIsFull = dismiss
        return self
    }

    public func dismiss() {
        self.removeFromSuperview()
    }

    public func fillUptheTank(completion: ((Bool)->Void)? = nil) {
        // Drain the tank to empty state
        lvManager.update(level: 1.0)
        // Animate tank to fill up to new state
        updateLevelProgress(withDuration: lvManager.duration, completion: completion)
    }

    public func drainTheTank(completion: ((Bool)->Void)? = nil) {
        // Drain the tank to empty state
        lvManager.update(level: 0.0)
        // Animate tank to fill up to new state
        updateLevelProgress(withDuration: lvManager.duration, completion: completion)
    }
    

    public func update(fillingProgress p: Double, completion: ((Bool)->Void)? = nil) {
        lvManager.update(level: p)
        // Animate tank to fill up to new state
        updateLevelProgress(withDuration: lvManager.duration, completion: completion)
    }
    
    private func initFillView() {
        self.fillView = Filling(frame: .zero)
        if let v = self.fillView {
            self.addSubview(v)
            v.setUp(withManager: lvManager)
            self.layoutIfNeeded()
        }
    }

    private func initTitleLabel() {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lbl)
        NSLayoutConstraint.activate([
            lbl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            lbl.centerYAnchor.constraint(equalTo: self.centerYAnchor)])
        self.titleLabel = lbl
        
    }
    
    private func updateLevelProgress(withDuration d: Double, completion: ((Bool)->Void)? = nil) {
        fillView.updateConstraints(withManager: lvManager)
        
        // Optional completion block with default nil value
        // If completion is nil, set animation completion block
        // equals to autoDismissBlock
        UIView.animate(withDuration: d, delay: 0, options: [.curveLinear], animations: { [unowned self] in
            self.layoutIfNeeded()
            }, completion: completion == nil ?
                autoDismissBlock : completion)
    }

    private lazy var autoDismissBlock: ((Bool)->Void)? = {
        if self.dismissWhenTankIsFull == false {
            // Noting to do when fill up animation completed
            return nil
        } else {
            // Check if tank is full
            // if YES, dismiss tank view
            return { success in
                if self.lvManager.level >= 1 || self.lvManager.duration != -1 {
                    self.dismiss()
                }
            }
        }
    }()
}
