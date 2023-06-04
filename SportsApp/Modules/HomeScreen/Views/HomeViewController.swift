//
//  ViewController.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 26/05/2023.
//

import UIKit
import Reachability

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private var homeViewModel : HomeControllerViewModel!
    private let reachability = try! Reachability()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        homeViewModel = HomeControllerViewModel()
        
        //Setting up tabBar
        title = "Home"
        tabBarController?.tabBar.items?.first?.image = UIImage(systemName: "house.fill")
        tabBarController?.tabBar.items?.last?.title = "Favorites"
        tabBarController?.tabBar.items?.last?.image = UIImage(systemName: "heart.fill")
        
        homeViewModel.bindViewModelToController = { leagues in
            self.backupLeagues(leagues)
            print("data received \(leagues.count)")
            //upgrade ui and navigate to new screen with the list of leagues
            let leaguesViewController = self.storyboard?.instantiateViewController(withIdentifier: "LeaguesViewController") as! LeaguesViewController
            
            leaguesViewController.setupLeagueView(leagues,self.homeViewModel.sportType)
            self.navigationController?.pushViewController(leaguesViewController, animated: true)
        }
        
        do{
            try reachability.startNotifier()
        }catch{
            print("unable to start notifier")
        }
        
    }
    
    func backupLeagues(_ leagues:[League]){
        for league in leagues{
            DatabaseService.shared.insertToFavs(false, league.leagueKey!, league.leagueName!, nil)
        }
    }

    deinit {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }

}

extension HomeViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        cell.setup(with: sports[indexPath.row])
        
        
        return cell
    }
    
    
}

extension HomeViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
 
        return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let itemWidth = view.frame.width / 2 - (layout.minimumInteritemSpacing + 8)
        let itemHeight = view.frame.height / 3
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}

extension HomeViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(sports[indexPath.row])
        if reachability.connection == .unavailable {
            print("offline")
            let offlineLeagues = DatabaseService.shared.fetchLeagues()
            
            
            print("data received \(offlineLeagues?.count)")
            
            let leaguesViewController = self.storyboard?.instantiateViewController(withIdentifier: "LeaguesViewController") as! LeaguesViewController

            leaguesViewController.setupLeagueViewOffline(offlineLeagues!, sports[indexPath.row].title)
            self.navigationController?.pushViewController(leaguesViewController, animated: true)
        }else{
            print("online")
            homeViewModel.sportType = sports[indexPath.row].title
            homeViewModel.requestFromApi(sports[indexPath.row].title.lowercased())
        }
    }
}
