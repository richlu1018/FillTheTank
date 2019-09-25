//
//  Filling.swift
//  FillTheTank
//
//  Created by Richard Lu on 2019/9/17.
//  Copyright © 2019 Richard Lu. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

public class FillView: UIView, Animatable {
    public typealias AnimationCompletionBlock = ((Bool)->Void)?
    let disposeBag = DisposeBag()
    public var animateDuration: Double
    public var animationCompletionBlock: AnimationCompletionBlock = nil
    var viewModel: DirectionalFillable
    public init(model: DirectionalFillable, animateDuration: Double) {
        self.animateDuration = animateDuration
        viewModel = model
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = viewModel.fillColor
        initSetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initSetUp() {
        viewModel.onUpdateView
            .asObservable()
            .observeOn(MainScheduler())
            .subscribe(onNext: {[unowned self] (update) in
                self.animateForChanges()
        }).disposed(by: disposeBag)
    }
}
