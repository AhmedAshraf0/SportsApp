//
//  LeaguesViewController.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 27/05/2023.
//

import UIKit
import SDWebImage

class LeaguesViewController: UIViewController {
    private var sportType: String!
    private var leagues: [League]!
    private var filteredDataArray: [League] = []
    
    private var leaguesViewModel: LeaguesControllerViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "\(sportType ?? "") Leagues"
        print("hi")
        tableView.dataSource = self
        tableView.delegate = self
        
        leaguesViewModel = LeaguesControllerViewModel()
        
        leaguesViewModel.bindViewModelToController = {
            fixtures, teams in
            print("teams received \(teams?.count ?? -1)")
            let detailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
            
            if !(fixtures?.isEmpty ?? true) && !(teams?.isEmpty ?? true){
                detailsViewController.setupDetailsView(fixtures!,teams!)
            }
            detailsViewController.title = self.leaguesViewModel.newScreenTitle
            detailsViewController.sportType = self.sportType
            
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
    
    func setupLeagueView(_ leagues: [League]! , _ sportType: String){
        self.leagues = leagues
        filteredDataArray = leagues
        self.sportType = sportType
    }
}

extension LeaguesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = filteredDataArray[indexPath.row].leagueName
        cell.textLabel?.textAlignment = .center
        
        if sportType == "Football"{
            if let logoURLString = filteredDataArray[indexPath.row].leagueLogo, let imageURL = URL(string: logoURLString) {
                cell.imageView?.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"))
            } else {
                cell.imageView?.image = UIImage(named: "placeholder")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("pressed at \(indexPath.row)")
        leaguesViewModel.requestFromApi(sportType, filteredDataArray[indexPath.row].leagueKey!, nil)
        leaguesViewModel.newScreenTitle = filteredDataArray[indexPath.row].leagueName
    }
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
                let itemText = item.leagueName!.lowercased()
                return itemText.contains(lowercasedSearchText)
            }
        }
        tableView.reloadData()
    }
    
}
