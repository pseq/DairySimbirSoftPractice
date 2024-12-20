//
//  DairySimbirSoftPracticeTests.swift
//  DairySimbirSoftPracticeTests
//
//  Created by pseq on 01.12.2024.
//

import XCTest
@testable import DairySimbirSoftPractice

final class DairySimbirSoftPracticeTests: XCTestCase {
    
    var tasksDistributor: TasksDistributor!
    var calendarController: CalendarViewController!
    let december131027 = Date(timeIntervalSince1970: 1734085651) // GMT: Friday, 13 December 2024 г., 10:27:31
    let december131227 = Date(timeIntervalSince1970: 1734092851) // GMT: Friday, 13 December 2024 г., 12:27:31
    let december121200 = Date(timeIntervalSince1970: 1734004800) // GMT: Friday, 12 December 2024 г., 12:00:00
    var sut: CalendarViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        tasksDistributor = TasksDistributor()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: CalendarViewController.self))
        sut = viewController as? CalendarViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        tasksDistributor = nil
        try super.tearDownWithError()
    }
    
    func testCalendarViewControllerLoaded() {
        XCTAssertNotNil(sut.view, "CalendarViewController loaded")
        XCTAssertNotNil(sut.datePicker, "datePicker loaded")
        XCTAssertNotNil(sut.hoursTableView, "hoursTableView loaded")
    }
    
    func testTasksDistributorCount() throws {
        XCTAssertNotNil(tasksDistributor.dataService, "tasksDistributor data service not nil")
        XCTAssertEqual(tasksDistributor.tasksByHoursDistribution(december131027).count, 3, "13 December 2024 is 3 hours")
        XCTAssertEqual(tasksDistributor.tasksByHoursDistribution(december131227).count, 3, "13 December 2024 is 3 hours")
        XCTAssertEqual(tasksDistributor.tasksByHoursDistribution(december121200).count, 0, "12 December 2024 is 0 hours")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
