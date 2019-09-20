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

    var colors: [UIColor] = []
    var directions: [LevelMovingDirection] = []
    var tanks: [Tank?] = []
    var progressBar: Tank!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addProgressBarStyleTank()
        let pink = UIColor(red: 255.0/255.0, green: 105.0/255.0, blue: 180.0/255.0, alpha: 1.0)
        colors = [.white, pink, .purple, .orange, .gray]
        directions = [.rightToLeft, .bottomUp,.leftToRight, .topDown, .rightToLeft]
        for i in 0..<colors.count {
            let manager = LevelManager(moveWithDirection: directions[i], duration: 0.5, initLevel: 0.0, fillingsColor: colors[i])
            let tank = Tank(lvManager: manager)
                .backgroundColor(i+1 < colors.count ? colors[i+1] : .white)
                .dismissWhenTankIsFull(true)
            tanks.append(tank)
            view.addSubview(tank)
            NSLayoutConstraint.activate([tank.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                         tank.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                         tank.widthAnchor.constraint(equalTo:view.widthAnchor),
                                         tank.heightAnchor.constraint(equalTo: view.heightAnchor)])
        }
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var i: Int = tanks.count {
            didSet {
                guard i >= 0 else {
                    progressBar.fillUptheTank { [unowned self] (_) in
                        self.progressBar.drainTheTank()
                        self.startAnimationGroup(with: self.addPianoBarViews())
                    }
                    return
                }
                tanks[i]?.fillUptheTank(completion: { [unowned self] (_) in
                    self.tanks[i]?.dismiss()
                    i -= 1
                })
            }
        }
        i -= 1
    }
    
    private func addProgressBarStyleTank() {
        let textAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
            as [NSAttributedString.Key : Any]
        let manager = LevelManager(moveWithDirection: .leftToRight, duration: 2.0, initLevel: 0.0, fillingsColor: .orange)
        progressBar = Tank(lvManager: manager)
                        .cornerRadius(10.0)
                        .borderColor(.orange)
                        .borderWidth(3.0)
                        .backgroundColor(.white)
                        .titleLabel(attributedString: "FillTheTank",
                                    withAttributes: textAttributes)

        view.addSubview(progressBar)
        NSLayoutConstraint.activate([
            progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressBar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            progressBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            progressBar.heightAnchor.constraint(equalToConstant: 50)])
        
        
    }
    
    private func addPianoBarViews() -> [Tank] {
        let barCount = 20
        var bars:[Tank] = []
        for i in 0..<barCount {
            let direction: LevelMovingDirection = i % 2 == 0 ? .bottomUp: .topDown
            let fColor: UIColor = i % 2 == 0 ? .black : .purple
            let manager = LevelManager(moveWithDirection: direction, duration: 2.0, initLevel: 0.0, fillingsColor: fColor)
            let bar = Tank(lvManager: manager)
                    .backgroundColor(.clear)
            view.addSubview(bar)
            bars.append(bar)
            let xShift = UIScreen.main.bounds.width*(1.0/CGFloat(barCount))
            NSLayoutConstraint.activate([
                bar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0),
                bar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0/CGFloat(barCount)),
                bar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                bar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: CGFloat(i)*xShift)])
            bar.layoutIfNeeded()
        }
        return bars
    }

    private func startAnimationGroup(with tanks: [Tank]) {
        UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1.0, animations: {
                tanks.forEach({$0.fillUptheTank(completion: { (_) in
                    UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: .calculationModeLinear, animations: {
                        UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                            tanks.forEach({$0.drainTheTank()})
                        })
                    }, completion: nil)
                })})
            })
        }, completion: nil)
    }

}

