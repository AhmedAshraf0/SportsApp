//
//  LeagueDetailsModel.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 29/05/2023.
//

import Foundation

struct LeagueDetailsResponse: Codable {
    let success: Int
    let result: [Fixture]?
}

struct Fixture: Codable {
    let eventKey: Int?
    let eventDate: String?
    let eventTime: String?
    let eventHomeTeam: String?
    let homeTeamKey: Int?
    let eventHomeTeamLogo: String?
    let eventAwayTeamLogo: String?
    let eventAwayTeam: String?
    let awayTeamKey: Int?
    let eventHalftimeResult: String?
    let eventFinalResult: String?
    let eventFTResult: String?
    let eventStatus: String?
    let countryName: String?
    let leagueName: String?
    let leagueKey: Int?
    let leagueRound: String?
    let leagueSeason: String?
    let eventLive: String?
    let eventStadium: String?
    let eventReferee: String?
    let homeTeamLogo: String?
    let awayTeamLogo: String?
    let eventCountryKey: Int?
    let leagueLogo: String?
    let countryLogo: String?
    let eventHomeFormation: String?
    let eventAwayFormation: String?
    let fkStageKey: Int?
    let stageName: String?
    let leagueGroup: String?
    let lineups: Lineups?
    
    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case eventHomeTeam = "event_home_team"
        case homeTeamKey = "home_team_key"
        case eventHomeTeamLogo = "event_home_team_logo"
        case eventAwayTeamLogo = "event_away_team_logo"
        case eventAwayTeam = "event_away_team"
        case awayTeamKey = "away_team_key"
        case eventHalftimeResult = "event_halftime_result"
        case eventFinalResult = "event_final_result"
        case eventFTResult = "event_ft_result"
        case eventStatus = "event_status"
        case countryName = "country_name"
        case leagueName = "league_name"
        case leagueKey = "league_key"
        case leagueRound = "league_round"
        case leagueSeason = "league_season"
        case eventLive = "event_live"
        case eventStadium = "event_stadium"
        case eventReferee = "event_referee"
        case homeTeamLogo = "home_team_logo"
        case awayTeamLogo = "away_team_logo"
        case eventCountryKey = "event_country_key"
        case leagueLogo = "league_logo"
        case countryLogo = "country_logo"
        case eventHomeFormation = "event_home_formation"
        case eventAwayFormation = "event_away_formation"
        case fkStageKey = "fk_stage_key"
        case stageName = "stage_name"
        case leagueGroup = "league_group"
        case lineups = "lineups"
    }
}

struct Lineups: Codable {
    let homeTeam: TeamLineup?
    let awayTeam: TeamLineup?
    
    enum CodingKeys: String, CodingKey {
        case homeTeam = "home_team"
        case awayTeam = "away_team"
    }
}

struct TeamLineup: Codable {
    let startingLineups: [SportPlayer]?
    let substitutes: [SportPlayer]?
    
    enum CodingKeys: String, CodingKey {
        case startingLineups = "starting_lineups"
        case substitutes = "substitutes"
    }
}

struct SportPlayer: Codable {
    let playerName: String?
    let playerID: Int?
    
    enum CodingKeys: String, CodingKey {
        case playerName = "player"
        case playerID = "player_id"
    }
}

