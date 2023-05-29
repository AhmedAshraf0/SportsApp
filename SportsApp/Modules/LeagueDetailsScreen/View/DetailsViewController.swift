//
//  DetailsViewController.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 29/05/2023.
//

import UIKit

class DetailsViewController: UIViewController {
    private var upcomingFixtures : [Fixture]!
    
    @IBOutlet weak var collectionView: UICollectionView!
    let randomDates: [String] = [
        "05-12", "06-20", "03-05", "09-10", "11-15",
        "02-28", "07-01", "12-25", "08-18", "04-30"
    ]

    // Array with 10 random football teams
    let randomFootballTeams: [String] = [
        "Team A", "Team B", "Team C", "Team D", "Team E",
        "Team F", "Team G", "Team H", "Team I", "Team J"
    ]

    // Array with 10 random teams
    let randomTeams: [String] = [
        "Team X", "Team Y", "Team Z", "Team W", "Team V",
        "Team U", "Team T", "Team S", "Team R", "Team Q"
    ]

    // Array with 10 random times
    let randomTimes: [String] = [
        "12:00", "15:30", "18:45", "20:15", "13:20",
        "16:50", "19:00", "21:30", "14:10", "17:55"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setupDetailsView(_ fixtures: [Fixture]){
        self.upcomingFixtures = fixtures
    }

}


extension DetailsViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return randomDates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCollectionViewCell", for: indexPath) as! DetailsCollectionViewCell
        cell.layer.cornerRadius = 25.0
        
        cell.homeTeamLabel.text = randomFootballTeams[indexPath.row]
        cell.awayTeamLabel.text = randomTeams[indexPath.row]
        cell.labelTime.text = randomTimes[indexPath.row]
        cell.labelDate.text = randomDates[indexPath.row]
        cell.awayTeamImg.image = UIImage(named: "football")
        cell.homeTeamImg.image = UIImage(named: "basketball")
        
        return cell
    }
    
    
}

extension DetailsViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("ouch")
    }
}
