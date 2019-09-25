//
//  ViewController.swift
//  FillTheTankDemo
//
//  Created by Richard Lu on 2019/9/18.
//  Copyright © 2019 Richard Lu. All rights reserved.
//

import UIKit
import FillTheTank
import RxSwift


class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    private let pink = UIColor(red: 255.0/255.0, green: 105.0/255.0, blue: 180.0/255.0, alpha: 1.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .black
        
        let container = UIButton(frame: .zero)
        container.backgroundColor = .white
        container.setTitle("FillTheTank", for: .normal)
        container.setTitleColor(.blue, for: .normal)
        self.view.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            container.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            container.heightAnchor.constraint(equalToConstant: 50)])
        
        var topDownfillViewModel: DirectionalFillable = TopDownFillViewModel(initLevel: 0.0, fillColor: .orange)
        let fillView = FillView(model: topDownfillViewModel, animateDuration: 5.0)
        let containerViewModel = ContainerViewModel(fillView: fillView)
        container.insertContainerViewModel(model: containerViewModel, disposeBag: disposeBag)
        topDownfillViewModel.update(level: 1.0, inContainerView: container)
        
        var LRFillViewModel = LeftToRightFillViewModel(initLevel: 1.0, fillColor: .blue)
        let LRFillView = FillView(model:LRFillViewModel, animateDuration: 2.0)
        let cViewModel = ContainerViewModel(fillView: LRFillView)
        container.insertContainerViewModel(model: cViewModel, disposeBag: disposeBag)
        LRFillViewModel.update(level: 0.0, inContainerView: container)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //startFullScreeIntro()
    }

}
