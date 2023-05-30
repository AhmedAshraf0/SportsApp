//
//  TeamsApiService.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 30/05/2023.
//

import Foundation

class TeamsApiService{
    private let baseUrl = "https://apiv2.allsportsapi.com/"
    private let apiKey = "06aa3e1750f0b7baaabb926d54c1772a6f0c32fa0df979eccf5c9b5e2dc008f0"
    
    func requestFromApi(endPoint: String, leagueId: Int, completion: @escaping ([Team]) -> ()) {
        let urlString = "\(baseUrl)football/?met=\(endPoint)&APIkey=\(apiKey)&leagueId=\(leagueId)"
        
        print(urlString)
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            guard data.count > 0 else {
                print("Empty response")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(TeamResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response.result)
                }
            } catch {
                print("JSON decoding error in TeamsApiService: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}
