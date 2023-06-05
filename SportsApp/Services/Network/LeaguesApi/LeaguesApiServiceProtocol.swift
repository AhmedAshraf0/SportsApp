//
//  LeaguesApiServiceProtocol.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 05/06/2023.
//

import Foundation

protocol LeaguesApiServiceProtocol {
    func requestFromApi(_ sportType: String, completion: @escaping ([League]) -> ())
}
