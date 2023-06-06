//
//  DatabaseService.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 31/05/2023.
//

import Foundation
import UIKit
import CoreData

class DatabaseService {
    private let favEntity = "FavoritesDB"
    private let leagueEntity = "LeaguesDB"
    
    static let shared = DatabaseService()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private lazy var context = appDelegate.persistentContainer.viewContext
    
    private init() {}
    
    func insertToFavs(_ isFavoriteDb: Bool,_ sportId: Int?, _ teamKey: Int, _ teamName: String, _ teamLogo: String?) -> Bool {
        if isFavoriteDb{
            let favsEntity = NSEntityDescription.entity(forEntityName: favEntity, in: context)
            let mangaedObject = NSManagedObject(entity: favsEntity!, insertInto: context)
            
            mangaedObject.setValue(Int64(teamKey), forKey: "id")
            mangaedObject.setValue(teamName, forKey: "team_name")
            mangaedObject.setValue(teamLogo, forKey: "team_logo")
            
            do {
                try context.save()
                return true
            } catch let error as NSError {
                print(error.localizedDescription)
                return false
            }
        }else{
            let leaguesEntity = NSEntityDescription.entity(forEntityName: leagueEntity, in: context)
            let mangaedObject = NSManagedObject(entity: leaguesEntity!, insertInto: context)
            
            mangaedObject.setValue(Int64(teamKey), forKey: "id")
            mangaedObject.setValue(teamName, forKey: "league_name")
            mangaedObject.setValue(Int64(sportId!), forKey: "sport_id")
            
            do {
                try context.save()
                return true
            } catch let error as NSError {
                print(error.localizedDescription)
                return false
            }
        }
        
    }
    
    func deleteFromFavs(teamKey: Int) -> Bool {
        let fetchRequest: NSFetchRequest<FavoritesDB> = FavoritesDB.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", Int64(teamKey))
        
        do {
            let fetchedResults = try context.fetch(fetchRequest)
            
            if !fetchedResults.isEmpty {
                for result in fetchedResults {
                    context.delete(result)
                }
                
                try context.save()
                print("Successfully deleted data.")
                return true
            } else {
                print("No matching data found.")
                return false
            }
        } catch let error as NSError {
            print("Failed to delete data: \(error.localizedDescription)")
            return false
        }
    }
    
    func fetchFavs() -> [FavoritesDB]? {
        let fetchRequest: NSFetchRequest<FavoritesDB> = FavoritesDB.fetchRequest()
        
        do {
            let fetchedResults = try context.fetch(fetchRequest)
            return fetchedResults
        } catch let error as NSError {
            print("Failed to fetch data: \(error.localizedDescription)")
            return nil
        }
    }
    
    func fetchLeagues(_ sportId: Int) -> [LeaguesDB]? {
        let fetchRequest: NSFetchRequest<LeaguesDB> = LeaguesDB.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "sport_id == %d", sportId)
        
        do {
            let fetchedResults = try context.fetch(fetchRequest)
            return fetchedResults
        } catch let error as NSError {
            print("Failed to fetch data from leagues: \(error.localizedDescription)")
            return nil
        }
    }
    
    func isTeamInFavs(teamKey: Int) -> Bool {
        let fetchRequest: NSFetchRequest<FavoritesDB> = FavoritesDB.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", Int64(teamKey))
        
        do {
            let count = try context.count(for: fetchRequest)
            return count != 0
        } catch let error as NSError {
            print("Failed to fetch team: \(error.localizedDescription)")
            return false
        }
    }
}
