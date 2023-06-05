//
//  LeaguesViewController.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 27/05/2023.
//

import UIKit
import SDWebImage
import Reachability

class LeaguesViewController: UIViewController {
    private var sportType: String!
    private var leagues: [League]!
    private var filteredDataArray: [League] = []
    private var offlineLeagues: [LeaguesDB]!
    private var filterdOfflineLeagues: [LeaguesDB]!
    private let reachability = try! Reachability()
    
    private var leaguesViewModel: LeaguesControllerViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            try reachability.startNotifier()
        }catch{
            print("unable to start notifier")
        }

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
    
    deinit {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
}

extension LeaguesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if reachability.connection == .unavailable{
            return filterdOfflineLeagues.count
        }else{
            return filteredDataArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! LeagueTableViewCell
        if reachability.connection == .unavailable{
            cell.leagueTitle.text = filterdOfflineLeagues[indexPath.row].league_name
            cell.imageView?.image = UIImage(named: "placeholder")
        }else{
            cell.leagueTitle.text = filteredDataArray[indexPath.row].leagueName
            if sportType == "Football"{
                cell.setupLeagueCellImage(filteredDataArray[indexPath.row].leagueLogo)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("pressed at \(indexPath.row)")
        if reachability.connection == .unavailable{
            let alert = UIAlertController(title: "No Internet Connection",
                                                  message: "There is no internet connection available.",
                                                  preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okAction)
                    
                    present(alert, animated: true, completion: nil)
            print("offline no action")
        }else{
            leaguesViewModel.requestFromApi(sportType, filteredDataArray[indexPath.row].leagueKey!, nil)
            leaguesViewModel.newScreenTitle = filteredDataArray[indexPath.row].leagueName
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
            if reachability.connection == .unavailable {
                filterdOfflineLeagues = offlineLeagues
            } else {
                filteredDataArray = leagues
            }
        } else {
            if reachability.connection == .unavailable {
                filterdOfflineLeagues = offlineLeagues.filter { item in
                    let lowercasedSearchText = searchText.lowercased()
                    let itemText = item.league_name?.lowercased() ?? ""
                    return itemText.contains(lowercasedSearchText)
                }
            } else {
                filteredDataArray = leagues.filter { item in
                    let lowercasedSearchText = searchText.lowercased()
                    let itemText = item.leagueName!.lowercased()
                    return itemText.contains(lowercasedSearchText)
                }
            }
        }
        tableView.reloadData()
    }

    
}
