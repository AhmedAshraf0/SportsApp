//
//  MockTeamApiServiceTests.swift
//  SportsAppTests
//
//  Created by Ahmed Ashraf on 06/06/2023.
//

import Foundation
import XCTest
@testable import SportsApp

class MockTeamApiServiceTests: XCTestCase {
    var apiService: TeamsApiServiceProtocol!
    
    override func setUp() {
        super.setUp()
        apiService = MockTeamApiService(shouldReturnError: false)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRequestFromApiShouldReturnLeagues() {
        apiService.requestFromApi(sportType: "football", endPoint: "Teams", leagueId: 207){teams in
            print("  ---\(teams?.count ?? -1)")
            XCTAssertGreaterThan(teams?.count ?? -1, 0, "Got \(teams?.count ?? -1) teams")
        }
    }
    
    func testRequestFromApiShouldHandleError() {
        apiService = MockTeamApiService(shouldReturnError: true)
        
        apiService.requestFromApi(sportType: "football", endPoint: "Teams", leagueId: 207){teams in
            print("  ---\(teams?.count ?? -1)")
            XCTAssertEqual(teams?.count ?? -1, 0, "Got \(teams?.count ?? -1) teams")
        }
    }
}
