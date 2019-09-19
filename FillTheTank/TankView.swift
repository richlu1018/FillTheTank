//
//  TankView.swift
//  FillTheTank
//
//  Created by Richard Lu on 2019/9/17.
//  Copyright © 2019 Richard Lu. All rights reserved.
//

import Foundation
import UIKit

open class Tank: UIView {
    
    private var label: UILabel?
    private var fillUpManager: FillUpManager
    private var fillView: FillsView!
    private var dismissWhenTankIsFull: Bool = false
    public init(manager: FillUpManager) {
        // Set up FillUpManager to provide animation info
        self.fillUpManager = manager
        super.init(frame: .zero)
        // Avoid automatically generated constraints
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layoutIfNeeded()
    }
    

    override open func layoutIfNeeded() {
        super.layoutIfNeeded()
        //Init fills view for filling up animation
        if fillView == nil {
            self.initFillsView()
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

    public func dismissWhenTankIsFull(_ dismiss: Bool) -> Tank {
        self.dismissWhenTankIsFull = dismiss
        return self
    }

    public func dismiss() {
        self.removeFromSuperview()
    }

    public func filltheTank(completion: ((Bool)->Void)? = nil) {
        //Update fillView's constraints to next target state
        fillView.updateConstraints(withManager: fillUpManager)
        
        // If fillUpManager.fDuration < 0 means fType is .progressively,
        // animation duration will be 0.2 for every progress update
        let duration = fillUpManager.fDuration < 0 ? 0.2 : fillUpManager.fDuration
        
        // Optional completion block with default nil value
        // If completion is nil, set animation completion block
        // equals to autoDismissBlock
        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseInOut], animations: { [unowned self] in
            self.layoutIfNeeded()
        }, completion: completion == nil ?
            autoDismissBlock : completion)
    }
    

    public func update(fillingProgress progress: Double) {
        fillUpManager.update(fillUpProgress: progress)
        // Animate tank to fill up to new state
        filltheTank()
    }
    
    private func initFillsView() {
        self.fillView = FillsView(frame: .zero)
        if let v = self.fillView {
            self.addSubview(v)
            v.setUp(withManager: fillUpManager)
            self.layoutIfNeeded()
        }
    }

    private lazy var autoDismissBlock: ((Bool)->Void)? = {
        if self.dismissWhenTankIsFull == false {
            // Noting to do when fill up animation completed
            return nil
        } else {
            // Check if tank is full
            // if YES, dismiss tank view
            return { success in
                if self.fillUpManager.fProgress >= 1 || self.fillUpManager.fDuration != -1 {
                    self.dismiss()
                }
            }
        }
    }()
}
