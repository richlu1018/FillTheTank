//
//  ViewController.swift
//  FillTheTankDemo
//
//  Created by Richard Lu on 2019/9/18.
//  Copyright © 2019 Richard Lu. All rights reserved.
//

import UIKit
import FillTheTank

class ViewController: UIViewController {

    var tank: Tank!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let pink = UIColor(red: 255.0/255.0, green: 105.0/255.0, blue: 180.0/255.0, alpha: 1.0)
        let manager = FillUpManager(constantlyFillUpWithDirection: .bottmUp, countDownDuration: 5, fillUpColor: .blue)
        tank = Tank(manager: manager)
            .backgroundColor(.black)
            .dismissWhenTankIsFull(true)
        
        view.addSubview(tank)
      
        NSLayoutConstraint.activate([tank.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     tank.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     tank.widthAnchor.constraint(equalTo:view.widthAnchor),
                                     tank.heightAnchor.constraint(equalTo: view.heightAnchor)])
      
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tank.filltheTank()
    }

}

