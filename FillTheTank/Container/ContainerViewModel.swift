//
//  ContainerViewModel.swift
//  FillTheTank
//
//  Created by Richard Lu on 2019/9/25.
//  Copyright © 2019 Richard Lu. All rights reserved.
//

import Foundation
import RxSwift

public class ContainerViewModel: Containable {
    public var fillViewSubject: BehaviorSubject<FillView>
    public init(fillView: FillView) {
        fillViewSubject = BehaviorSubject(value: fillView)
    }
    
    
    
}
