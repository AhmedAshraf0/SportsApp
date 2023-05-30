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
    private var teams: [Team] = []
    
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
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
        upcomingCollectionView.dataSource = self
        upcomingCollectionView.delegate = self
        teamsCollectionView.dataSource = self
        teamsCollectionView.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ResultTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        teamsCollectionView.register(UINib(nibName: "TeamCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TeamCollectionViewCell")
    }
    
    func setupDetailsView(_ fixtures: [Fixture] , _ teams: [Team]){
        self.fixtures = fixtures
        self.teams = teams
        
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
        switch collectionView{
        case upcomingCollectionView:
            return upcomingFixtures.count
        case teamsCollectionView:
            return teams.count
        default:
            print("default!")
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView{
        case upcomingCollectionView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCollectionViewCell", for: indexPath) as! DetailsCollectionViewCell
            cell.layer.cornerRadius = 25.0
            cell.homeTeamLabel.text = upcomingFixtures[indexPath.row].eventHomeTeam
            cell.awayTeamLabel.text = upcomingFixtures[indexPath.row].eventAwayTeam
            cell.labelTime.text = upcomingFixtures[indexPath.row].eventTime
            cell.labelDate.text = upcomingFixtures[indexPath.row].eventDate
            cell.awayTeamImg.sd_setImage(with: URL(string: upcomingFixtures[indexPath.row].awayTeamLogo), placeholderImage: UIImage(named: "placeholder"))
            cell.homeTeamImg.sd_setImage(with: URL(string: upcomingFixtures[indexPath.row].homeTeamLogo), placeholderImage: UIImage(named: "placeholder"))
            return cell
            
        case teamsCollectionView:
            let cell = teamsCollectionView.dequeueReusableCell(withReuseIdentifier: "TeamCollectionViewCell", for: indexPath) as! TeamCollectionViewCell
            cell.teamLabel.text = teams[indexPath.row].teamName
            cell.teamImg.sd_setImage(with: URL(string: teams[indexPath.row].teamLogo!), placeholderImage: UIImage(named: "placeholder"))
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    
}

extension DetailsViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("ouch")
    }
}

extension DetailsViewController: UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsOfFixtures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ResultTableViewCell
        cell.homeTeam.text = resultsOfFixtures[indexPath.row].eventHomeTeam
        cell.awayTeam.text = resultsOfFixtures[indexPath.row].eventAwayTeam
        cell.matchScore.text = resultsOfFixtures[indexPath.row].eventFTResult
        cell.homeImg?.sd_setImage(with: URL(string: resultsOfFixtures[indexPath.row].homeTeamLogo), placeholderImage: UIImage(named: "placeholder"))
        cell.awayImg?.sd_setImage(with: URL(string: resultsOfFixtures[indexPath.row].awayTeamLogo), placeholderImage: UIImage(named: "placeholder"))
        
        return cell
    }
    
    
}
