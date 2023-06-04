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
    private var offlineLeagues: [LeaguesDB]!
    private var filterdOfflineLeagues: [LeaguesDB]!
    
    private var leaguesViewModel: LeaguesControllerViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "\(sportType ?? "") Leagues"
        print("hi")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "LeagueTableViewCell", bundle: nil), forCellReuseIdentifier: "cell2")
        
        leaguesViewModel = LeaguesControllerViewModel()
        
        leaguesViewModel.bindViewModelToController = {
            fixtures, teams in
            print("teams received \(teams?.count ?? -1)")
            DispatchQueue.main.async {
                let detailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
                
                if !(fixtures?.isEmpty ?? true) && !(teams?.isEmpty ?? true){
                    detailsViewController.setupDetailsView(fixtures!,teams!)
                }else if !(teams?.isEmpty ?? true){
                    detailsViewController.setupDetailsViewTeams(teams!)
                    print("else fixtures \(fixtures?.count) teams \(teams?.count)")
                }
                
                if self.sportType == "Tennis"{
                    print("ho")
                    detailsViewController.setupDetailsView(fixtures ?? [], [])
                }
                detailsViewController.title = self.leaguesViewModel.newScreenTitle
                detailsViewController.sportType = self.sportType
                
                self.navigationController?.pushViewController(detailsViewController, animated: true)
            }
        }
    }
    
    func setupLeagueView(_ leagues: [League]! , _ sportType: String){
        self.leagues = leagues
        filteredDataArray = leagues
        self.sportType = sportType
    }
    
    func setupLeagueViewOffline(_ leagues: [LeaguesDB] , _ sportType: String){
        offlineLeagues = leagues
        filterdOfflineLeagues = leagues
        self.sportType = sportType
    }
}

extension LeaguesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredDataArray.isEmpty{
            return filterdOfflineLeagues.count
        }else{
            return filteredDataArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! LeagueTableViewCell
        if filteredDataArray.isEmpty{
            cell.leagueTitle.text = filterdOfflineLeagues[indexPath.row].leagueId
            cell.imageView?.image = UIImage(named: "placeholder")
        }else{
            cell.leagueTitle.text = filteredDataArray[indexPath.row].leagueName
            if sportType == "Football"{
                cell.setupLeagueCellImage(filteredDataArray[indexPath.row].leagueLogo)
            }
        }
//        cell.textLabel?.text = filteredDataArray[indexPath.row].leagueName
//        cell.textLabel?.textAlignment = .center
//
//        if sportType == "Football"{
//            if let logoURLString = filteredDataArray[indexPath.row].leagueLogo, let imageURL = URL(string: logoURLString) {
//                cell.imageView?.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"))
//            } else {
//                cell.imageView?.image = UIImage(named: "placeholder")
//            }
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("pressed at \(indexPath.row)")
        if !filteredDataArray.isEmpty{
            leaguesViewModel.requestFromApi(sportType, filteredDataArray[indexPath.row].leagueKey!, nil)
            leaguesViewModel.newScreenTitle = filteredDataArray[indexPath.row].leagueName
        }else{
            print("offline no action")
        }
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
            if leagues.isEmpty{
                filterdOfflineLeagues = offlineLeagues
            }else{
                filteredDataArray = leagues
            }
        } else {
            if leagues.isEmpty{
                filterdOfflineLeagues = offlineLeagues
            }else{
                filterdOfflineLeagues = offlineLeagues.filter { item in
                    let lowercasedSearchText = searchText.lowercased()
                    let itemText = item.leagueId!.lowercased()
                    return itemText.contains(lowercasedSearchText)
                }
            }
        }
        tableView.reloadData()
    }
    
}
