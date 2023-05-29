//
//  LeagueDetailsApi.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 29/05/2023.
//

import Foundation

class LeagueDetailsApiService {
    private let baseUrl = "https://apiv2.allsportsapi.com/"
    private let apiKey = "06aa3e1750f0b7baaabb926d54c1772a6f0c32fa0df979eccf5c9b5e2dc008f0"
    
    func requestFromApi(endPoint: String, from: String, to: String, leagueId: Int, completion: @escaping ([Fixture]) -> ()) {
        let urlString = "\(baseUrl)\(endPoint)/?met=Fixtures&APIkey=\(apiKey)&from=\(from)&to=\(to)&leagueId=\(leagueId)"
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
                let response = try decoder.decode(LeagueDetailsResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response.result)
                    print(response.result.count)
                }
            } catch {
                print("JSON decoding error: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}

