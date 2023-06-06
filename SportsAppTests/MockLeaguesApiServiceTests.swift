//
//  MockLeaguesApiServiceTests.swift
//  SportsAppTests
//
//  Created by Ahmed Ashraf on 06/06/2023.
//

import Foundation
import XCTest
@testable import SportsApp

class MockLeaguesApiServiceTests: XCTestCase {
    var apiService: LeaguesApiServiceProtocol!
    
    override func setUp() {
        super.setUp()
        apiService = MockLeaguesApiService(shouldReturnError: false)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRequestFromApiShouldReturnLeagues() {        
        apiService.requestFromApi("football") { leagues in
            print("  ---\(leagues.count)")
            XCTAssertGreaterThan(leagues.count, 0, "Got \(leagues.count) leagues")
        }
    }
    
    func testRequestFromApiShouldHandleError() {
        apiService = MockLeaguesApiService(shouldReturnError: true)
        
        apiService.requestFromApi("football") { leagues in
            print("2  ---  \(leagues.count)")
            XCTAssertEqual(leagues.count, 0, "Expected 0 leagues")
        }
    }
}
