//
//  HomeControllerViewModel.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 26/05/2023.
//

import Foundation

class HomeControllerViewModel{
    private var networkService: LeaguesApiService!
    var sportType: String!
    
    private(set) var leagueData : [League]! {
            didSet {
                self.bindViewModelToController(leagueData)
            }
        }
    
    var bindViewModelToController : ((_ leagues: [League]) -> ()) = {leagues in }
    
    init() {
        self.networkService = LeaguesApiService()
    }
    
    func requestFromApi(_ sportType: String){
        networkService.requestFromApi(sportType){ (leagueData) in
            print(leagueData.count)
            self.leagueData = leagueData
        }
    }

}
