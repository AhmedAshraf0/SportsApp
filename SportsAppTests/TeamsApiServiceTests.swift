//
//  TeamsApiServiceTests.swift
//  SportsAppTests
//
//  Created by Ahmed Ashraf on 05/06/2023.
//

import Foundation
import XCTest
@testable import SportsApp

class TeamsApiServiceTests: XCTestCase {

    let apiService: TeamsApiServiceProtocol = TeamsApiService()

    func testRequestFromApi() {
        let expectation = XCTestExpectation(description: "Calling API Loading....")
        
        apiService.requestFromApi(sportType: "football", endPoint: "Teams", leagueId: 1234) { teams in
            XCTAssertNotNil(teams, "Teams should not be nil.")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }

    func testRequestFromApiFailed() {
        let expectation = XCTestExpectation(description: "Calling API Loading....")
        
        apiService.requestFromApi(sportType: "invalidSport", endPoint: "Teams", leagueId: 1234) { teams in
            XCTAssertNil(teams, "Teams should be nil.")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
}
