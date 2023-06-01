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
    static let shared = DatabaseService()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private lazy var context = appDelegate.persistentContainer.viewContext
    
    private init() {}
    
    func insertToFavs(_ teamKey: Int, _ teamName: String, _ teamLogo: String) -> Bool {
        let favsEntity = NSEntityDescription.entity(forEntityName: "FavoritesDB", in: context)
        let mangaedObject = NSManagedObject(entity: favsEntity!, insertInto: context)
        
        mangaedObject.setValue(Int64(teamKey), forKey: "id")
        mangaedObject.setValue(teamName, forKey: "team_name")
        mangaedObject.setValue(teamLogo, forKey: "team_logo")
        
        do {
            try context.save()
            print("Success insert")
            return true
        } catch let error as NSError {
            print(error.localizedDescription)
            return false
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
