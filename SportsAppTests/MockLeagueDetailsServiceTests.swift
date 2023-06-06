//
//  MockLeagueDetailsServiceTests.swift
//  SportsAppTests
//
//  Created by Ahmed Ashraf on 06/06/2023.
//

import Foundation
import XCTest
@testable import SportsApp

class MockLeaguesDetailsServiceTests: XCTestCase {
    var apiService: LeagueDetailsApiServiceProtocol!
    
    override func setUp() {
        super.setUp()
        apiService = MockLeagueDetailsService(shouldReturnError: false)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRequestFromApiShouldReturnLeagues() {
        apiService.requestFromApi(sportType: "football", endPoint: "Fixtures", from: "2023-01-01", to: "2023-12-30", leagueId: 207, teamId: nil){ fixtures in
            print("  ---\(fixtures?.count ?? -1)")
            XCTAssertGreaterThan(fixtures?.count ?? -1, 0, "Got \(fixtures?.count ?? -1) fixtures")
        }
    }
    
    func testRequestFromApiShouldHandleError() {
        apiService = MockLeagueDetailsService(shouldReturnError: true)
        
        apiService.requestFromApi(sportType: "football", endPoint: "Fixtures", from: "2023-01-01", to: "2023-12-30", leagueId: 207, teamId: nil){ fixtures in
            print("2  ---  \(fixtures?.count ?? -1)")
            XCTAssertEqual(fixtures?.count ?? -1, 0, "Expected 0 leagues")
        }
    }
}
