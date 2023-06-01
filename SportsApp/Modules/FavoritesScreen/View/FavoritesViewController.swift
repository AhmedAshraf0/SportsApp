//
//  FavoritesViewController.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 26/05/2023.
//

import UIKit

class FavoritesViewController: UIViewController {
    private var favoritesList: [FavoritesDB]?
    private var favortiesViewModel: TeamDetailsViewModel?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Favorites"
        print("in favs")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        favortiesViewModel = TeamDetailsViewModel(databaseService: DatabaseService.shared)
        favoritesList = favortiesViewModel?.fetchFavs()
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        favoritesList = favortiesViewModel?.fetchFavs()
        tableView.reloadData()
    }

}

extension FavoritesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteTableViewCell
        
        cell.teamImg.sd_setImage(with: URL(string: favoritesList![indexPath.row].team_logo ?? ""))
        cell.teamName.text = favoritesList![indexPath.row].team_name
                                 
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let teamKey = favoritesList?[indexPath.row].id else {
                return
            }

            let alertController = UIAlertController(title: "Confirm Deletion", message: "Are you sure you want to delete this item?", preferredStyle: .alert)

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)

            let deleteAction = UIAlertAction(title: "Ok", style: .destructive) { _ in
                let deleted = self.favortiesViewModel?.deleteFromFavs(teamKey: Int(teamKey))

                if deleted == true {
                    self.favoritesList?.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    tableView.reloadData()
                    print("Confirmed deletion and deleted from tableView.")
                }
            }
            alertController.addAction(deleteAction)

            present(alertController, animated: true, completion: nil)
        }
    }

}

extension FavoritesViewController: UITableViewDelegate{
    
}
