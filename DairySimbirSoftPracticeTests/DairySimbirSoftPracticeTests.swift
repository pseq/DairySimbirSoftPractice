//
//  DairySimbirSoftPracticeTests.swift
//  DairySimbirSoftPracticeTests
//
//  Created by pseq on 01.12.2024.
//

import XCTest
@testable import DairySimbirSoftPractice

final class DairySimbirSoftPracticeTests: XCTestCase {
    
    var calendarViewController: CalendarViewController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        calendarViewController = CalendarViewController()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        calendarViewController = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.

        
        var tasksByHours = [Int: [TaskItem]]()
        var taskToDetails = TaskItem()
        
//        calendarViewController.sut_tasksByHoursDistribution()
        
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
