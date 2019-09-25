//
//  ContainterView.swift
//  FillTheTank
//
//  Created by Richard Lu on 2019/9/25.
//  Copyright © 2019 Richard Lu. All rights reserved.
//

import Foundation
import RxSwift

public class ContainerView: UIView {
    let disposeBag = DisposeBag()
    public var viewModel: Containable
    
    public init(model: Containable) {
        viewModel = model
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        initSetUp()
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initSetUp() {
        viewModel.fillViewSubject
            .asObservable()
            .observeOn(MainScheduler())
            .subscribe(onNext: { [unowned self] (newFillView) in
                self.addSubview(newFillView)
        }).disposed(by: disposeBag)
    }
    
    public func setUpFillViewConstraints() {
        self.layoutIfNeeded()
        self.viewModel.setUpConstraints(toView: self)
    }
}

public extension UIView {
    func insertContainerViewModel(model viewModel: Containable, disposeBag: DisposeBag) {
        viewModel.fillViewSubject
            .asObservable()
            .observeOn(MainScheduler())
            .subscribe(onNext: { [unowned self] (newFillView) in
                self.addSubview(newFillView)
            }).disposed(by: disposeBag)
        self.layoutIfNeeded()
        viewModel.setUpConstraints(toView: self)
    }
}
