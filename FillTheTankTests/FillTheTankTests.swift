//
//  FillTheTankTests.swift
//  FillTheTankTests
//
//  Created by Richard Lu on 2019/9/17.
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

    func testFillUpManagerInit() {
        let cManager = FillUpManager(constantlyFillUpWithDirection: .topDown, countDownDuration: 3.0, fillUpColor: .gray)
        XCTAssert(cManager.fType == .constantly)
        XCTAssert(cManager.fDirection == .topDown)
        XCTAssert(cManager.fDuration == 3.0)
        XCTAssert(cManager.fColor == .gray)
        XCTAssert(cManager.fProgress == -1)
        
        let pManager = FillUpManager(progressivelyFillUpWithDirection: .topDown, initialProgress: 0.3, fillUpColor: .gray)
        XCTAssert(pManager.fType == .progressively)
        XCTAssert(pManager.fDirection == .topDown)
        XCTAssert(pManager.fDuration == -1)
        XCTAssert(pManager.fColor == .gray)
        XCTAssert(pManager.fProgress == 0.3)
    
    }

    func testValidProgress() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var manager = FillUpManager(progressivelyFillUpWithDirection: .bottmUp, initialProgress: 0, fillUpColor: .green)
        manager.update(fillUpProgress: -1)
        XCTAssert(manager.fProgress == 0)
        manager.update(fillUpProgress: 2)
        XCTAssert(manager.fProgress == 1)
        manager.update(fillUpProgress: 0.99)
        XCTAssert(manager.fProgress == 0.99)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
