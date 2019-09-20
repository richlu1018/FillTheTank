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
        let cManager = LevelManager(moveWithDirection: .topDown, duration: 3.0, initLevel: 0.0, fillingsColor: .gray)
        XCTAssert(cManager.direction == .topDown)
        XCTAssert(cManager.duration == 3.0)
        XCTAssert(cManager.color == .gray)
        XCTAssert(cManager.level == 0.0)
    }
    
    func testValidProgress() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var manager = LevelManager(moveWithDirection: .bottomUp, duration: 0.1, initLevel: 0.0, fillingsColor: .green)
        manager.update(level: -1)
        XCTAssert(manager.level == 0)
        manager.update(level: 2)
        XCTAssert(manager.level == 1)
        manager.update(level: 0.99)
        XCTAssert(manager.level == 0.99)
    }

    func textTankTitleLabelSetUp() {
        let manager = LevelManager(moveWithDirection: .bottomUp, duration: 1.0, initLevel: 0, fillingsColor: .green)
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
