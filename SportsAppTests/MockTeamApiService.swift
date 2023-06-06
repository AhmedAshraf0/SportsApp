//
//  MockTeamApiService.swift
//  SportsAppTests
//
//  Created by Ahmed Ashraf on 06/06/2023.
//

import Foundation
import XCTest
@testable import SportsApp

class MockTeamApiService: TeamsApiServiceProtocol {
    var shouldReturnError: Bool
    
    let exampleResponse = """
    {
        "success": 1,
        "result": [
            {
                "team_key": 96,
                "team_name": "Juventus",
                "team_logo": "https://apiv2.allsportsapi.com/logo/96_juventus.jpg",
                "players": [
                    {
                        "player_key": 41841276,
                        "player_name": "M. Perin",
                        "player_number": "36",
                        "player_country": null,
                        "player_type": "Goalkeepers",
                        "player_age": "30",
                        "player_match_played": "11",
                        "player_goals": "0",
                        "player_yellow_cards": "0",
                        "player_red_cards": "0",
                        "player_image": "https://apiv2.allsportsapi.com/logo/players/472_m-perin.jpg"
                    },
                    {
                        "player_key": 600699875,
                        "player_name": "G. Garofani",
                        "player_number": "41",
                        "player_country": null,
                        "player_type": "Goalkeepers",
                        "player_age": "20",
                        "player_match_played": "0",
                        "player_goals": "0",
                        "player_yellow_cards": "0",
                        "player_red_cards": "0",
                        "player_image": "https://apiv2.allsportsapi.com/logo/players/124214_g-garofani.jpg"
                    },
                    {
                        "player_key": 671816971,
                        "player_name": "S. Scaglia",
                        "player_number": "47",
                        "player_country": null,
                        "player_type": "Goalkeepers",
                        "player_age": "18",
                        "player_match_played": "0",
                        "player_goals": "0",
                        "player_yellow_cards": "0",
                        "player_red_cards": "0",
                        "player_image": "https://apiv2.allsportsapi.com/logo/players/145118_s-scaglia.jpg"
                    },
                    {
                        "player_key": 3104825088,
                        "player_name": "G. Crespi",
                        "player_number": "",
                        "player_country": null,
                        "player_type": "Goalkeepers",
                        "player_age": "21",
                        "player_match_played": "0",
                        "player_goals": "0",
                        "player_yellow_cards": "0",
                        "player_red_cards": "0",
                        "player_image": "https://apiv2.allsportsapi.com/logo/players/114534_g-crespi.jpg"
                    },
                    {
                        "player_key": 2522601687,
                        "player_name": "M. De Sciglio",
                        "player_number": "2",
                        "player_country": null,
                        "player_type": "Defenders",
                        "player_age": "30",
                        "player_match_played": "17",
                        "player_goals": "0",
                        "player_yellow_cards": "0",
                        "player_red_cards": "0",
                        "player_image": "https://apiv2.allsportsapi.com/logo/players/9637_m-de-sciglio.jpg"
                    }
                ]
            }
        ]
    }

    """
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    func requestFromApi(sportType: String, endPoint: String, leagueId: Int, completion: @escaping ([Team]?) -> ()) {
        if shouldReturnError {
            completion([])
        } else {
            guard let mockData = exampleResponse.data(using: .utf8) else {
                completion([])
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(TeamResponse.self, from: mockData)
                completion(response.result)
            } catch {
                completion([])
            }
        }
    }
}
