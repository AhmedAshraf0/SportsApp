//
//  MockLeaguesApiService.swift
//  SportsAppTests
//
//  Created by Ahmed Ashraf on 06/06/2023.
//

import Foundation
import XCTest
@testable import SportsApp

class MockLeaguesApiService: LeaguesApiServiceProtocol {
    var shouldReturnError: Bool
    
    let exampleResponse = """
    {
        "success": 1,
        "result": [
            {
                "league_key": 4,
                "league_name": "UEFA Europa League",
                "country_key": 1,
                "country_name": "eurocups",
                "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/",
                "country_logo": null
            },
            {
                "league_key": 1,
                "league_name": "European Championship",
                "country_key": 1,
                "country_name": "eurocups",
                "league_logo": null,
                "country_logo": null
            },
            {
                "league_key": 683,
                "league_name": "UEFA Europa Conference League",
                "country_key": 1,
                "country_name": "eurocups",
                "league_logo": null,
                "country_logo": null
            },
            {
                "league_key": 3,
                "league_name": "UEFA Champions League",
                "country_key": 1,
                "country_name": "eurocups",
                "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/3_uefa_champions_league.png",
                "country_logo": null
            }
        ]
    }
    """
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    func requestFromApi(_ sportType: String, completion: @escaping ([League]) -> ()) {
        if shouldReturnError {
            completion([])
        } else {
            guard let mockData = exampleResponse.data(using: .utf8) else {
                completion([])
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(LeagueResponse.self, from: mockData)
                completion(response.result)
            } catch {
                completion([])
            }
        }
    }
}
