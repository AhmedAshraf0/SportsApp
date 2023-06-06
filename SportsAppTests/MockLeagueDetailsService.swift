//
//  MockLeagueDetailsService.swift
//  SportsAppTests
//
//  Created by Ahmed Ashraf on 06/06/2023.
//

import Foundation
import XCTest
@testable import SportsApp

class MockLeagueDetailsService: LeagueDetailsApiServiceProtocol {
    var shouldReturnError: Bool
    
    let exampleResponse = """
    {
        "success": 1,
        "result": [
            {
                "event_key": 1223924,
                "event_date": "2023-06-11",
                "event_time": "20:45",
                "event_home_team": "Spezia",
                "home_team_key": 4977,
                "event_away_team": "Verona",
                "away_team_key": 4982,
                "event_halftime_result": "",
                "event_final_result": "-",
                "event_ft_result": "",
                "event_penalty_result": "",
                "event_status": "",
                "country_name": "Italy",
                "league_name": "Serie A - Relegation Decider",
                "league_key": 207,
                "league_round": "",
                "league_season": "2022/2023",
                "event_live": "0",
                "event_stadium": "",
                "event_referee": "",
                "home_team_logo": "https://apiv2.allsportsapi.com/logo/4977_spezia.jpg",
                "away_team_logo": "https://apiv2.allsportsapi.com/logo/4982_verona.jpg",
                "event_country_key": 5,
                "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/207_serie-a.png",
                "country_logo": "https://apiv2.allsportsapi.com/logo/logo_country/5_italy.png",
                "event_home_formation": "",
                "event_away_formation": "",
                "fk_stage_key": 9194,
                "stage_name": "Relegation Decider",
                "league_group": null,
                "goalscorers": [],
                "substitutes": [],
                "cards": [],
                "lineups": {
                    "home_team": {
                        "starting_lineups": [],
                        "substitutes": [],
                        "coaches": [],
                        "missing_players": []
                    },
                    "away_team": {
                        "starting_lineups": [],
                        "substitutes": [],
                        "coaches": [],
                        "missing_players": []
                    }
                },
                "statistics": []
            },
            {
                "event_key": 1071579,
                "event_date": "2023-06-04",
                "event_time": "21:00",
                "event_home_team": "Atalanta",
                "home_team_key": 85,
                "event_away_team": "Monza",
                "away_team_key": 4990,
                "event_halftime_result": "2 - 0",
                "event_final_result": "5 - 2",
                "event_ft_result": "5 - 2",
                "event_penalty_result": "",
                "event_status": "Finished",
                "country_name": "Italy",
                "league_name": "Serie A - Regular Season",
                "league_key": 207,
                "league_round": "Round 38",
                "league_season": "2022/2023",
                "event_live": "0",
                "event_stadium": "Gewiss Stadium (Bergamo)",
                "event_referee": "M. Di Bello",
                "home_team_logo": "https://apiv2.allsportsapi.com/logo/85_atalanta.jpg",
                "away_team_logo": "https://apiv2.allsportsapi.com/logo/4990_monza.jpg",
                "event_country_key": 5,
                "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/207_serie-a.png",
                "country_logo": "https://apiv2.allsportsapi.com/logo/logo_country/5_italy.png",
                "event_home_formation": "3-4-2-1",
                "event_away_formation": "3-4-2-1",
                "fk_stage_key": 331,
                "stage_name": "Regular Season",
                "league_group": null,
                "goalscorers": [
                    {
                        "time": "12",
                        "home_scorer": "T. Koopmeiners",
                        "home_scorer_id": "3842200340",
                        "home_assist": "J. Maehle",
                        "home_assist_id": "4039639866",
                        "score": "1 - 0",
                        "away_scorer": "",
                        "away_scorer_id": "",
                        "away_assist": "",
                        "away_assist_id": "",
                        "info": "",
                        "info_time": "1st Half"
                    },
                    {
                        "time": "45+1",
                        "home_scorer": "T. Koopmeiners",
                        "home_scorer_id": "3842200340",
                        "home_assist": "",
                        "home_assist_id": "",
                        "score": "2 - 0",
                        "away_scorer": "",
                        "away_scorer_id": "",
                        "away_assist": "",
                        "away_assist_id": "",
                        "info": "",
                        "info_time": "1st Half"
                    },
                    {
                        "time": "51",
                        "home_scorer": "",
                        "home_scorer_id": "",
                        "home_assist": "",
                        "home_assist_id": "",
                        "score": "2 - 1",
                        "away_scorer": "A. Colpani",
                        "away_scorer_id": "818864052",
                        "away_assist": "Dany Mota",
                        "away_assist_id": "928971081",
                        "info": "",
                        "info_time": "2nd Half"
                    },
                    {
                        "time": "74",
                        "home_scorer": "R. Hojlund",
                        "home_scorer_id": "1302503360",
                        "home_assist": "T. Koopmeiners",
                        "home_assist_id": "3842200340",
                        "score": "3 - 1",
                        "away_scorer": "",
                        "away_scorer_id": "",
                        "away_assist": "",
                        "away_assist_id": "",
                        "info": "",
                        "info_time": "2nd Half"
                    },
                    {
                        "time": "79",
                        "home_scorer": "T. Koopmeiners",
                        "home_scorer_id": "3842200340",
                        "home_assist": "J. Maehle",
                        "home_assist_id": "4039639866",
                        "score": "4 - 1",
                        "away_scorer": "",
                        "away_scorer_id": "",
                        "away_assist": "",
                        "away_assist_id": "",
                        "info": "",
                        "info_time": "2nd Half"
                    },
                    {
                        "time": "81",
                        "home_scorer": "",
                        "home_scorer_id": "",
                        "home_assist": "",
                        "home_assist_id": "",
                        "score": "4 - 2",
                        "away_scorer": "A. Petagna",
                        "away_scorer_id": "2053903855",
                        "away_assist": "N. Rovella",
                        "away_assist_id": "876847878",
                        "info": "",
                        "info_time": "2nd Half"
                    },
                    {
                        "time": "90+2",
                        "home_scorer": "L. Muriel",
                        "home_scorer_id": "740446579",
                        "home_assist": "A. Lookman",
                        "home_assist_id": "3996848288",
                        "score": "5 - 2",
                        "away_scorer": "",
                        "away_scorer_id": "",
                        "away_assist": "",
                        "away_assist_id": "",
                        "info": "",
                        "info_time": "2nd Half"
                    }
                ],
                "substitutes": [
                    {
                        "time": "62",
                        "home_scorer": [],
                        "home_assist": null,
                        "score": "substitution",
                        "away_scorer": {
                            "in": "A. Petagna",
                            "out": "Dany Mota",
                            "in_id": 2053903855,
                            "out_id": 928971081
                        },
                        "away_assist": null,
                        "info": null,
                        "info_time": "2nd Half"
                    },
                    {
                        "time": "81",
                        "home_scorer": [],
                        "home_assist": null,
                        "score": "substitution",
                        "away_scorer": {
                            "in": "José Machín",
                            "out": "G. Caprari",
                            "in_id": 4114811006,
                            "out_id": 3546408474
                        },
                        "away_assist": null,
                        "info": null,
                        "info_time": "2nd Half"
                    },
                    {
                        "time": "81",
                        "home_scorer": [],
                        "home_assist": null,
                        "score": "substitution",
                        "away_scorer": {
                            "in": "V. Antov",
                            "out": "P. Ciurria",
                            "in_id": 1013055305,
                            "out_id": 739837867
                        },
                        "away_assist": null,
                        "info": null,
                        "info_time": "2nd Half"
                    },
                    {
                        "time": "60",
                        "home_scorer": {
                            "in": "A. Lookman",
                            "out": "M. Pašalić",
                            "in_id": 3996848288,
                            "out_id": 3247090484
                        },
                        "home_assist": null,
                        "score": "substitution",
                        "away_scorer": [],
                        "away_assist": null,
                        "info": null,
                        "info_time": "2nd Half"
                    },
                    {
                        "time": "60",
                        "home_scorer": {
                            "in": "C. Okoli",
                            "out": "G. Scalvini",
                            "in_id": 1698558166,
                            "out_id": 865702032
                        },
                        "home_assist": null,
                        "score": "substitution",
                        "away_scorer": [],
                        "away_assist": null,
                        "info": null,
                        "info_time": "2nd Half"
                    },
                    {
                        "time": "88",
                        "home_scorer": {
                            "in": "F. Rossi",
                            "out": "M. Sportiello",
                            "in_id": 2721682592,
                            "out_id": 3363903911
                        },
                        "home_assist": null,
                        "score": "substitution",
                        "away_scorer": [],
                        "away_assist": null,
                        "info": null,
                        "info_time": "2nd Half"
                    },
                    {
                        "time": "83",
                        "home_scorer": {
                            "in": "L. Muriel",
                            "out": "R. Højlund",
                            "in_id": 740446579,
                            "out_id": 1302503360
                        },
                        "home_assist": null,
                        "score": "substitution",
                        "away_scorer": [],
                        "away_assist": null,
                        "info": null,
                        "info_time": "2nd Half"
                    },
                    {
                        "time": "88",
                        "home_scorer": {
                            "in": "T. De Nipoti",
                            "out": "Éderson",
                            "in_id": 3012292715,
                            "out_id": 1315450921
                        },
                        "home_assist": null,
                        "score": "substitution",
                        "away_scorer": [],
                        "away_assist": null,
                        "info": null,
                        "info_time": "2nd Half"
                    }
                ],
                "cards": [
                    {
                        "time": "33",
                        "home_fault": "",
                        "card": "yellow card",
                        "away_fault": "N. Rovella",
                        "info": "",
                        "home_player_id": "",
                        "away_player_id": "876847878",
                        "info_time": "1st Half"
                    },
                    {
                        "time": "63",
                        "home_fault": "",
                        "card": "yellow card",
                        "away_fault": "A. Izzo",
                        "info": "",
                        "home_player_id": "",
                        "away_player_id": "3292395742",
                        "info_time": "2nd Half"
                    },
                    {
                        "time": "64",
                        "home_fault": "R. Toloi",
                        "card": "yellow card",
                        "away_fault": "",
                        "info": "",
                        "home_player_id": "3757950750",
                        "away_player_id": "",
                        "info_time": "2nd Half"
                    },
                    {
                        "time": "67",
                        "home_fault": "G. Gasperini",
                        "card": "red card",
                        "away_fault": "",
                        "info": "",
                        "home_player_id": "2943725468",
                        "away_player_id": "",
                        "info_time": "2nd Half"
                    },
                    {
                        "time": "70",
                        "home_fault": "",
                        "card": "red card",
                        "away_fault": "Marlon",
                        "info": "",
                        "home_player_id": "",
                        "away_player_id": "2372991312",
                        "info_time": "2nd Half"
                    }
                ],
                "lineups": {
                    "home_team": {
                        "starting_lineups": [],
                        "substitutes": [
                            {
                                "player": "Iacopo Regonesi",
                                "player_number": 51,
                                "player_position": 0,
                                "player_country": null,
                                "player_key": 771774096,
                                "info_time": ""
                            },
                            {
                                "player": "Tommaso Del Lungo",
                                "player_number": 50,
                                "player_position": 0,
                                "player_country": null,
                                "player_key": 2183103790,
                                "info_time": ""
                            }
                        ],
                        "coaches": [],
                        "missing_players": []
                    },
                    "away_team": {
                        "starting_lineups": [],
                        "substitutes": [],
                        "coaches": [],
                        "missing_players": []
                    }
                },
                "statistics": [
                    {
                        "type": "Substitution",
                        "home": "5",
                        "away": "5"
                    },
                    {
                        "type": "Attacks",
                        "home": "91",
                        "away": "98"
                    },
                    {
                        "type": "Dangerous Attacks",
                        "home": "46",
                        "away": "29"
                    },
                    {
                        "type": "On Target",
                        "home": "9",
                        "away": "5"
                    },
                    {
                        "type": "Off Target",
                        "home": "11",
                        "away": "3"
                    },
                    {
                        "type": "Shots Total",
                        "home": "21",
                        "away": "8"
                    },
                    {
                        "type": "Shots On Goal",
                        "home": "10",
                        "away": "4"
                    },
                    {
                        "type": "Shots Off Goal",
                        "home": "9",
                        "away": "4"
                    },
                    {
                        "type": "Shots Blocked",
                        "home": "2",
                        "away": "0"
                    },
                    {
                        "type": "Shots Inside Box",
                        "home": "16",
                        "away": "4"
                    },
                    {
                        "type": "Shots Outside Box",
                        "home": "5",
                        "away": "4"
                    },
                    {
                        "type": "Fouls",
                        "home": "13",
                        "away": "8"
                    },
                    {
                        "type": "Corners",
                        "home": "5",
                        "away": "1"
                    },
                    {
                        "type": "Offsides",
                        "home": "2",
                        "away": "3"
                    },
                    {
                        "type": "Ball Possession",
                        "home": "38%",
                        "away": "62%"
                    },
                    {
                        "type": "Yellow Cards",
                        "home": "1",
                        "away": "2"
                    },
                    {
                        "type": "Red Cards",
                        "home": "0",
                        "away": "1"
                    },
                    {
                        "type": "Saves",
                        "home": "2",
                        "away": "5"
                    },
                    {
                        "type": "Passes Total",
                        "home": "406",
                        "away": "664"
                    },
                    {
                        "type": "Passes Accurate",
                        "home": "347",
                        "away": "585"
                    }
                ]
            }
    ]
    }
    """
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    func requestFromApi(sportType: String, endPoint: String, from: String, to: String, leagueId: Int?, teamId: Int?, completion: @escaping ([SportsApp.Fixture]?) -> ()) {
        if shouldReturnError {
            completion([])
        } else {
            guard let mockData = exampleResponse.data(using: .utf8) else {
                completion([])
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(LeagueDetailsResponse.self, from: mockData)
                completion(response.result)
            } catch {
                completion([])
            }
        }
    }
}
