//
//  StuffedTests.swift
//  StuffedTests
//
//  Created by Mac Bellingrath on 10/27/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import XCTest
@testable import Stuffed

class StuffedTests: XCTestCase {
    
    let testGamePad = GamePadController()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
        
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGameBoardControllerStartGame() {
        
        
        testGamePad.startGame()
        XCTAssertTrue(testGamePad.gameStatusActive)
    }
    
}
