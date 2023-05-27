//
//  LeaguesViewController.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 27/05/2023.
//

import UIKit
import SDWebImage

class LeaguesViewController: UIViewController {
    private var leagues: [League]!
    private var filteredDataArray: [League] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Leagues"
        print("hi")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupLeagueView(_ leagues: [League]!){
        self.leagues = leagues
        filteredDataArray = leagues
    }
    
}

extension LeaguesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section
        // Example: return yourDataArray.count
        return filteredDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue or create a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell
        // Example: cell.textLabel?.text = yourDataArray[indexPath.row]
        cell.textLabel?.text = filteredDataArray[indexPath.row].leagueName
        cell.textLabel?.textAlignment = .center
        
        if let logoURLString = filteredDataArray[indexPath.row].leagueLogo, let imageURL = URL(string: logoURLString) {
            cell.imageView?.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"))
        } else {
            cell.imageView?.image = UIImage(named: "placeholder")
        }
        return cell
    }
    
    // Implement other UITableViewDataSource and UITableViewDelegate methods as needed
}

extension LeaguesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterData(with: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        filterData(with: "")
        searchBar.resignFirstResponder()
    }

    func filterData(with searchText: String) {
        if searchText.isEmpty {
            filteredDataArray = leagues
        } else {
            filteredDataArray = leagues.filter { item in
                
                let lowercasedSearchText = searchText.lowercased()
                let itemText = item.leagueName.lowercased()
                return itemText.contains(lowercasedSearchText)
            }
        }
        tableView.reloadData()
    }
    
}
