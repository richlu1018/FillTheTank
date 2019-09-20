//
//  FillTheTankTests.swift
//  FillTheTankTests
//
//  Created by Richard Lu on 2019/9/18.
//  Copyright © 2019 Richard Lu. All rights reserved.
//

import XCTest
@testable import FillTheTank

class FillTheTankTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLevelManagerInit() {
        let cManager = LevelManager(constantlyMoveWithDirection: .topDown, countDownDuration: 3.0, fillingsColor: .gray)
        XCTAssert(cManager.movement == .constantly)
        XCTAssert(cManager.direction == .topDown)
        XCTAssert(cManager.duration == 3.0)
        XCTAssert(cManager.color == .gray)
        XCTAssert(cManager.progress == -1)
        
        let pManager = LevelManager(progressivelyMoveWithDirection: .topDown, initialProgress: 0.3, fillingsColor: .gray)
        XCTAssert(pManager.movement == .progressively)
        XCTAssert(pManager.direction == .topDown)
        XCTAssert(pManager.duration == -1)
        XCTAssert(pManager.color == .gray)
        XCTAssert(pManager.progress == 0.3)
        
    }
    
    func testValidProgress() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var manager = LevelManager(progressivelyMoveWithDirection: .bottomUp, initialProgress: 0, fillingsColor: .green)
        manager.update(levelProgress: -1)
        XCTAssert(manager.progress == 0)
        manager.update(levelProgress: 2)
        XCTAssert(manager.progress == 1)
        manager.update(levelProgress: 0.99)
        XCTAssert(manager.progress == 0.99)
    }

    func testLevelManagerUpdateProgress() {
        var manager = LevelManager(progressivelyMoveWithDirection: .bottomUp, initialProgress: 0, fillingsColor: .green)
        manager.update(levelProgress: 0.5)
        XCTAssertTrue(manager.progress == 0.5)
    }

    func textTankTitleLabelSetUp() {
        let manager = LevelManager(progressivelyMoveWithDirection: .bottomUp, initialProgress: 0, fillingsColor: .green)
        let tank = Tank(lvManager: manager)
            .titleLabel(attributedString: "Test", withAttributes: [.font: UIFont.systemFont(ofSize: 12)])
        XCTAssertTrue(tank.titleLabel != nil)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
