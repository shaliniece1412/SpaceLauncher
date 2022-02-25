//
//  SpaceLauncherTests.swift
//  SpaceLauncherTests
//
//  Created by 922235 on 25/02/22.
//

import XCTest
@testable import SpaceLauncher

class SpaceLauncherTests: XCTestCase {
    
    var launcherController = LauncherViewController()
    let launcherViewModel = LauncherViewModel()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testThatViewConformsToUITableViewDataSource() {
        XCTAssertTrue(self.launcherController.conforms(to: UITableViewDataSource.self), "View does not conform to UITableView datasource protocol")
        
    }
    
    func testThatViewConformsToUITableViewDelegate(){
        XCTAssertTrue(self.launcherController.conforms(to: UITableViewDelegate.self), "View does not conform to UITableView delegate protocol")
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(launcherController.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(launcherController.responds(to: #selector(launcherController.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(launcherController.responds(to: #selector(launcherController.tableView(_:cellForRowAt:))))
    }
    
    func testAPIWorking() {
        let expectation = XCTestExpectation.init(description: "API request")
        
        launcherViewModel.fetchDetailedList(idValue: nil) { (completed) in
            XCTAssert(self.launcherViewModel.launcherResponse?.results.count != 0)
            expectation.fulfill()
        }
    }
    
}
