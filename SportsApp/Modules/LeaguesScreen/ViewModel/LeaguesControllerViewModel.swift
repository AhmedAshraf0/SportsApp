//
//  LeaguesControllerViewModel.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 29/05/2023.
//

import Foundation

class LeaguesControllerViewModel{
    private var networkService: LeagueDetailsApiService
    private var teamsNetworkService: TeamsApiService
    
    private var leagueDetailsData: [Fixture]!
    
    private(set) var teamsData: [Team]!{
        didSet{
            self.bindViewModelToController(leagueDetailsData,teamsData)
        }
    }
    
    var bindViewModelToController: ((_ fixtures: [Fixture],_ teams: [Team]) -> ()) = {fixtures, teams in }
    
    var newScreenTitle: String!
    
    init(){
        self.networkService = LeagueDetailsApiService()
        self.teamsNetworkService = TeamsApiService()
    }
    
    func requestFromApi(_ leagueId: Int){
        let currentYear = String(Calendar.current.component(.year, from: Date()))
        print(currentYear)

        networkService.requestFromApi(endPoint: "Fixtures", from: "\(currentYear)-01-01", to: "\(currentYear)-12-30", leagueId: leagueId, completion: {
            (fixtures) in
            print("fixtures: \(fixtures.count)")
            
            self.leagueDetailsData = fixtures
            self.requestTeamsFromApi(leagueId)
        })
    }
    
    func requestTeamsFromApi(_ leagueId: Int){
        teamsNetworkService.requestFromApi(endPoint: "Teams", leagueId: leagueId, completion: {
            (teams) in
            print("teams: \(teams.count)")
            
            self.teamsData = teams
        })
    }
    
    func getLeagueDetailsData() -> [Fixture] {
            return leagueDetailsData
    }
}
