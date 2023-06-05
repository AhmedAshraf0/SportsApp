//
//  TeamDetailsViewModel.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 01/06/2023.
//

import Foundation

class TeamDetailsViewModel{
    private var databaseService: DatabaseService
    
    init(databaseService: DatabaseService) {
        self.databaseService = databaseService
    }
    
    func insertToFavs(_ isFavorite: Bool, _ teamKey: Int, _ teamName: String, _ teamLogo: String) -> Bool{
        return databaseService.insertToFavs(isFavorite , nil, teamKey, teamName, teamLogo)
    }
    
    func deleteFromFavs(teamKey: Int) -> Bool {
        return databaseService.deleteFromFavs(teamKey: teamKey)
    }
    func isTeamInFavs(teamKey: Int) -> Bool {
        return databaseService.isTeamInFavs(teamKey: teamKey)
    }
    
    func fetchFavs() -> [FavoritesDB]?{
        return databaseService.fetchFavs()
    }
}
