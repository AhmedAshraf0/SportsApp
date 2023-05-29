//
//  LeaguesControllerViewModel.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 29/05/2023.
//

import Foundation

class LeaguesControllerViewModel{
    private var networkService: LeagueDetailsApiService
    
    private(set) var leagueDetailsData: [Fixture]!{
        didSet{
            self.bindViewModelToController(leagueDetailsData)
        }
    }
    
    var bindViewModelToController: ((_ fixtures: [Fixture]) -> ()) = {fixtures in }
    var newScreenTitle: String!
    
    init(){
        self.networkService = LeagueDetailsApiService()
    }
    
    func requestFromApi(_ leagueId: Int){
        let currentYear = String(Calendar.current.component(.year, from: Date()))
        print(currentYear)

        networkService.requestFromApi(endPoint: "Fixtures", from: "\(currentYear)-01-01", to: "\(currentYear)-12-30", leagueId: leagueId, completion: {
            (fixtures) in
            print("fixtures: \(fixtures.count)")
            
            self.leagueDetailsData = fixtures
        })
    }
}
