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
    
    private(set) var teamsData: [Team]?{
        didSet{
            self.bindViewModelToController(leagueDetailsData,teamsData)
        }
    }
    
    var bindViewModelToController: ((_ fixtures: [Fixture]?,_ teams: [Team]?) -> ()) = {fixtures, teams in }
    
    var newScreenTitle: String!
    
    init(){
        self.networkService = LeagueDetailsApiService()
        self.teamsNetworkService = TeamsApiService()
    }
    
    func requestFromApi(_ sportType: String,_ leagueId: Int? , _ teamId: Int?){
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: 5, to: Date())!)

        print("Current Date: \(currentDate)")

        let currentYear = String(Calendar.current.component(.year, from: Date()))
        print(currentYear)
        

        
        if sportType == "Football"{
            networkService.requestFromApi(sportType: sportType, endPoint: "Fixtures", from: "\(currentYear)-01-01", to: "\(currentYear)-12-30", leagueId: leagueId, teamId: teamId, completion: {
                (fixtures) in
                print("fixtures: \(fixtures?.count ?? -1)")
                
                self.leagueDetailsData = fixtures
                self.requestTeamsFromApi(sportType, leagueId!)
            })
        }else if sportType == "Tennis"{
            networkService.requestFromApi(sportType: sportType, endPoint: "Fixtures", from: "\(currentYear)-05-25", to: currentDate, leagueId: leagueId, teamId: teamId, completion: {
                (fixtures) in
                print("fixtures: not football \(fixtures?.count ?? -1)")
                
                self.leagueDetailsData = fixtures
                self.bindViewModelToController(self.leagueDetailsData,nil)
            })
        }else{
            networkService.requestFromApi(sportType: sportType, endPoint: "Fixtures", from: "\(currentYear)-05-01", to: "\(currentYear)-12-30", leagueId: leagueId, teamId: teamId, completion: {
                (fixtures) in
                print("fixtures: not football \(fixtures?.count ?? -1)")
                
                self.leagueDetailsData = fixtures
                if teamId == nil{
                    self.requestTeamsFromApi(sportType, leagueId!)
                }else{
                    self.bindViewModelToController(self.leagueDetailsData,nil)
                }
            })
        }
    }
    
    func requestTeamsFromApi(_ sportType: String, _ leagueId: Int){
        teamsNetworkService.requestFromApi(sportType: sportType, endPoint: "Teams", leagueId: leagueId, completion: {
            (teams) in
            print("teams: \(teams?.count)")
            
            self.teamsData = teams
        })
    }
    
    func getLeagueDetailsData() -> [Fixture] {
            return leagueDetailsData
    }
}
