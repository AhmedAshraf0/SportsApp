//
//  DetailsViewController.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 29/05/2023.
//

import UIKit

class DetailsViewController: UIViewController {
    private var fixtures : [Fixture]!
    private var upcomingFixtures: [Fixture] = []
    private var resultsOfFixtures: [Fixture] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    /*let randomDates: [String] = [
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
    ]*/
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setupDetailsView(_ fixtures: [Fixture]){
        self.fixtures = fixtures
        
        //filtering fixtures
        print("filtering started")
        for fixture in fixtures {
            if fixture.eventStatus.isEmpty{//means upcoming match
                upcomingFixtures.append(fixture)
            }else if fixture.eventStatus == "Finished"{
                resultsOfFixtures.append(fixture)
            }
        }
        print("filtering finished")
    }

}


extension DetailsViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upcomingFixtures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCollectionViewCell", for: indexPath) as! DetailsCollectionViewCell
        cell.layer.cornerRadius = 25.0
        
        cell.homeTeamLabel.text = upcomingFixtures[indexPath.row].eventHomeTeam
        cell.awayTeamLabel.text = upcomingFixtures[indexPath.row].eventAwayTeam
        cell.labelTime.text = upcomingFixtures[indexPath.row].eventTime
        cell.labelDate.text = upcomingFixtures[indexPath.row].eventDate
        cell.awayTeamImg.sd_setImage(with: URL(string: upcomingFixtures[indexPath.row].awayTeamLogo), placeholderImage: UIImage(named: "placeholder"))
        cell.homeTeamImg.sd_setImage(with: URL(string: upcomingFixtures[indexPath.row].homeTeamLogo), placeholderImage: UIImage(named: "placeholder"))
        
        return cell
    }
    
    
}

extension DetailsViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("ouch")
    }
}
