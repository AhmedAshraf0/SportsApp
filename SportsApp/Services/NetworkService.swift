//
//  NetworkService.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 26/05/2023.
//

import Foundation

class NetworkService{
    let endPoint = "football"
    let sportsUrl = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=06aa3e1750f0b7baaabb926d54c1772a6f0c32fa0df979eccf5c9b5e2dc008f0"
    
    func requestFromApi(completion : @escaping ([League]) -> ()) {
        guard let url = URL(string: sportsUrl) else {
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
                let response = try decoder.decode(LeagueResponse.self, from: data)
                DispatchQueue.main.async {
                    // Handle the decoded response here
                    completion(response.result)
//                    print(response.result.count)
                }
            } catch {
                print("JSON decoding error: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }

}
