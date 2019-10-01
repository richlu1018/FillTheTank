//
//  UIView+Container.swift
//  FillTheTank
//
//  Created by Richard Lu on 2019/9/25.
//  Copyright © 2019 Richard Lu. All rights reserved.
//

import Foundation
import RxSwift

public extension UIView {
    func insertContainerViewModel(model viewModel: Containable, disposeBag: DisposeBag) {
        viewModel.fillViewSubject
            .asObservable()
            .observeOn(MainScheduler())
            .subscribe(onNext: { [unowned self] (newFillView) in
                self.addSubview(newFillView)
                newFillView.setUpConstraints()
            }).disposed(by: disposeBag)
        self.layoutIfNeeded()
    }
}
