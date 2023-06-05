//
//  LeagueDetailsApiServiceApi.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 05/06/2023.
//

import Foundation

protocol LeagueDetailsApiServiceProtocol {
    func requestFromApi(sportType: String, endPoint: String, from: String, to: String, leagueId: Int?, teamId: Int?, completion: @escaping ([Fixture]?) -> ())
}
