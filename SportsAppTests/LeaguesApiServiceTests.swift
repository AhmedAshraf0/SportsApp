//
//  LeaguesApiServiceTests.swift
//  SportsAppTests
//
//  Created by Ahmed Ashraf on 05/06/2023.
//

import Foundation
import XCTest
@testable import SportsApp

class LeaguesApiServiceTests: XCTestCase {

    let apiService: LeaguesApiServiceProtocol = LeaguesApiService()
    
    func testRequestFromApi() {
        let myExpectation = expectation(description: "Calling API Loading....")

        apiService.requestFromApi("football") { leagues in
            XCTAssertNotNil(leagues, "Leagues should not be nil.")
            XCTAssertGreaterThan(leagues.count, 0, "Got \(leagues.count) leagues.")
            
            myExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testRequestFromApiFailed() {
        let expectation = expectation(description: "Calling API Loading....")
        expectation.isInverted = true
        
        apiService.requestFromApi("invalidSport") { leagues in
            XCTAssertNil(leagues, "Leagues should be nil.")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }



}

