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

    
    var tanks: [Tank?] = []
    var progressBar: Tank!
    private let pink = UIColor(red: 255.0/255.0, green: 105.0/255.0, blue: 180.0/255.0, alpha: 1.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .black
        addProgressBarStyleTank()
        addFullScreenTanks()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startFullScreeIntro()
    }

    private func addFullScreenTanks() {
        
        let colors: [UIColor] = [pink, .black, .blue, .lightGray, .orange]
        let directions: [LevelMovingDirection] = [.leftToRight, .topDown, .rightToLeft, .bottomUp, .leftToRight]
        let titles: [String] = ["richlu1018", "By", "Tank", "The", "Fill"]
        for i in 0..<colors.count {
            let manager = LevelManager(moveWithDirection: directions[i],
                                       duration: i == 0 ? 1.5 : 0.5,
                                       initLevel: 0.0,
                                       fillingsColor: colors[i])
            let tank = Tank(lvManager: manager)
                .backgroundColor(i+1 < colors.count ? colors[i+1] : .white)
                .titleLabel(attributedString: titles[i],
                            withAttributes: [.font: UIFont.boldSystemFont(ofSize: 38),
                                             .foregroundColor: i == 0 ? UIColor.black : UIColor.white])
                .dismissWhenTankIsFull(true)
            tanks.append(tank)
            view.addSubview(tank)
            NSLayoutConstraint.activate([tank.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                         tank.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                         tank.widthAnchor.constraint(equalTo:view.widthAnchor),
                                         tank.heightAnchor.constraint(equalTo: view.heightAnchor)])
        }
    }

    private func startFullScreeIntro() {
        var i: Int = tanks.count {
            didSet {
                guard i >= 0 else {
                    progressBar.fillUptheTank { [unowned self] (_) in
                        self.startPianoBarFillUpAnimationGroup(with: self.addPianoBarViews())
                    }
                    return
                }
                tanks[i]?.fillUptheTank(completion: { [unowned self] (_) in
                    if i == 0 {
                        self.tanks[i]?.backgroundColor = .yellow
                        self.tanks[i]?.lvManager.reverseDirection()
                        self.tanks[i]?.drainTheTank(completion: { (_) in
                            self.tanks[i]?.dismiss()
                            i -= 1
                        })
                    } else {
                        self.tanks[i]?.dismiss()
                        i -= 1
                    }
                    
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
                        .titleLabel(attributedString: "pod \"FillTheTank\"",
                                    withAttributes: textAttributes)

        view.addSubview(progressBar)
        NSLayoutConstraint.activate([
            progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressBar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            progressBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            progressBar.heightAnchor.constraint(equalToConstant: 50)])
        
    }
    
    private func addPianoBarViews() -> [Tank] {
        let barCount = 21
        var bars:[Tank] = []
        for i in 0..<barCount {
            let direction: LevelMovingDirection = i % 2 == 0 ? .bottomUp: .topDown
            let fColor: UIColor = i % 2 == 0 ? .purple : .white
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

    private func startPianoBarFillUpAnimationGroup(with tanks: [Tank]) {
        UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1.0, animations: {
                tanks.forEach({$0.fillUptheTank(completion: { [unowned self] (_) in
                    self.progressBar.dismiss()
                    self.startPianoBarDrainAnimationGroup(with: tanks)
                })})
            })
        }, completion: nil)
    }

    private func startPianoBarDrainAnimationGroup(with tanks: [Tank]) {
        UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1.0, animations: {
                tanks.forEach { [unowned self] (tank) in
                    tank.lvManager.update(color: self.pink)
                    tank.lvManager.update(direction: .rightToLeft)
                    tank.drainTheTank()
                }
            })
        }, completion: nil)
    }

}

