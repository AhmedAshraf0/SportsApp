//
//  TeamsApiServiceProtocol.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 05/06/2023.
//

import Foundation

protocol TeamsApiServiceProtocol {
    func requestFromApi(sportType: String, endPoint: String, leagueId: Int, completion: @escaping ([Team]?) -> ())
}
