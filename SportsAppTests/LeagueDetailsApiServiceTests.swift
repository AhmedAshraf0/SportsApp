//
//  LeagueDetailsApiServiceTests.swift
//  SportsAppTests
//
//  Created by Ahmed Ashraf on 05/06/2023.
//

import Foundation
import XCTest
@testable import SportsApp

class LeagueDetailsApiServiceTests: XCTestCase {
    
    let apiService: LeagueDetailsApiServiceProtocol = LeagueDetailsApiService()

    func testRequestFromApiWithLeagueId() {
        let expectation = XCTestExpectation(description: "Calling API Loading....")
        
        apiService.requestFromApi(sportType: "football", endPoint: "Fixtures", from: "2023-01-01", to: "2023-12-31", leagueId: 12, teamId: nil) { fixtures in
            XCTAssertNotNil(fixtures, "Fixtures should not be nil.")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testRequestFromApiWithTeamId() {
        let expectation = XCTestExpectation(description: "Calling API Loading....")
        
        apiService.requestFromApi(sportType: "football", endPoint: "Fixtures", from: "2023-01-01", to: "2023-12-31", leagueId: nil, teamId: 96) { fixtures in
            XCTAssertNotNil(fixtures, "Fixtures should not be nil.")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testRequestFromApiFailed() {
        let expectation = XCTestExpectation(description: "Calling API Loading....")
        expectation.isInverted = true
        
        apiService.requestFromApi(sportType: "invalidSport", endPoint: "Fixtures", from: "2023-01-01", to: "2023-12-31", leagueId: nil, teamId: 96) { fixtures in
            XCTAssertNil(fixtures, "Fixtures should be nil.")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
}
