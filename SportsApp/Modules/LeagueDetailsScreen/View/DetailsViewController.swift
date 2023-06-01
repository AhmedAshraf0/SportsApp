//
//  DetailsViewController.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 29/05/2023.
//

import UIKit

class DetailsViewController: UIViewController {
    var sportType: String!
    private var teamName: String!
    private var tempTeamUrl: String!
    private var teamKey: Int!
    private var fixtures : [Fixture]!
    private var upcomingFixtures: [Fixture] = []
    private var resultsOfFixtures: [Fixture] = []
    private var teams: [Team] = []
    
    private var detailsViewModel: LeaguesControllerViewModel!
    
    @IBOutlet weak var labelTeams: UILabel!
    @IBOutlet weak var labelUpcoming: UILabel!
    @IBOutlet weak var labelResults: UILabel!
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var upcomingCollectionView: UICollectionView!

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
        
        detailsViewModel = LeaguesControllerViewModel()
        
        detailsViewModel.bindViewModelToController = {// we use fixtures to get teams from it and teams is null her
            fixtures , teams in
            var players: [SportPlayer] = []
            if let unwrappedFixtures = fixtures {
                for fixture in unwrappedFixtures {
                    if fixture.eventHomeTeam == self.teamName {
                        if let homeStartingLineups = fixture.lineups?.homeTeam?.startingLineups {
                            for player in homeStartingLineups {
                                players.append(player)
                            }
                        }
                        if let homeSubLineups = fixture.lineups?.homeTeam?.substitutes {
                            for player in homeSubLineups {
                                players.append(player)
                            }
                        }
                        break
                    } else {
                        if let awayStartingLineups = fixture.lineups?.awayTeam?.startingLineups {
                            for player in awayStartingLineups {
                                players.append(player)
                            }
                        }
                        if let awaySubLineups = fixture.lineups?.awayTeam?.substitutes {
                            for player in awaySubLineups {
                                players.append(player)
                            }
                        }
                        break
                    }
                }
            }
            
            //list of players is ready
            let teamDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetailsViewController") as! TeamDetailsViewController
            
            teamDetailsViewController.title = self.teamName
            teamDetailsViewController.players = players
            teamDetailsViewController.teamKey = self.teamKey
            teamDetailsViewController.tempTeamName = self.teamName
            teamDetailsViewController.tempTeamUrl = self.tempTeamUrl
            
            self.navigationController?.pushViewController(teamDetailsViewController, animated: true)

        }
        
        if upcomingFixtures.isEmpty{
            labelUpcoming.isHidden = false
        }
        if resultsOfFixtures.isEmpty{
            labelResults.isHidden = false
        }
        if teams.isEmpty{
            labelTeams.isHidden = false
        }
    }
    
    func setupDetailsView(_ fixtures: [Fixture] , _ teams: [Team]){
        self.fixtures = fixtures
        self.teams = teams
        
        //filtering fixtures
        print("filtering started")
        for fixture in fixtures.reversed() {
            if fixture.eventStatus!.isEmpty || fixture.eventStatus == "1"{//means upcoming match
                upcomingFixtures.append(fixture)
            }
            
        }
        for fixture in fixtures {
            if fixture.eventStatus == "Finished"{
               resultsOfFixtures.append(fixture)
           }
        }
        print("filtering finished")
    }

    func setupDetailsViewTeams( _ teams: [Team]){
        self.teams = teams
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
            if sportType == "Tennis"{
                cell.homeTeamLabel.text = upcomingFixtures[indexPath.row].eventFirstPlayer
                cell.awayTeamLabel.text = upcomingFixtures[indexPath.row].eventSecondPlayer
                
                
                cell.awayTeamImg.sd_setImage(with: URL(string: upcomingFixtures[indexPath.row].eventSecondPlayerLogo ?? ""), placeholderImage: UIImage(named: "player-placeholder"))
                cell.homeTeamImg.sd_setImage(with: URL(string: upcomingFixtures[indexPath.row].eventFirstPlayerLogo ?? ""), placeholderImage: UIImage(named: "player-placeholder"))
            }else{
                cell.homeTeamLabel.text = upcomingFixtures[indexPath.row].eventHomeTeam
                cell.awayTeamLabel.text = upcomingFixtures[indexPath.row].eventAwayTeam
                
                if upcomingFixtures[indexPath.row].awayTeamLogo == nil{
                    cell.awayTeamImg.sd_setImage(with: URL(string: upcomingFixtures[indexPath.row].eventAwayTeamLogo ?? ""), placeholderImage: UIImage(named: "placeholder"))
                    cell.homeTeamImg.sd_setImage(with: URL(string: upcomingFixtures[indexPath.row].eventHomeTeamLogo ?? ""), placeholderImage: UIImage(named: "placeholder"))
                }else{
                    cell.awayTeamImg.sd_setImage(with: URL(string: upcomingFixtures[indexPath.row].awayTeamLogo ?? ""), placeholderImage: UIImage(named: "placeholder"))
                    cell.homeTeamImg.sd_setImage(with: URL(string: upcomingFixtures[indexPath.row].homeTeamLogo ?? ""), placeholderImage: UIImage(named: "placeholder"))
                }
            }
            cell.labelTime.text = upcomingFixtures[indexPath.row].eventTime
            cell.labelDate.text = upcomingFixtures[indexPath.row].eventDate ?? upcomingFixtures[indexPath.row].evenDateStarted
            

            return cell
            
        case teamsCollectionView:
            let cell = teamsCollectionView.dequeueReusableCell(withReuseIdentifier: "TeamCollectionViewCell", for: indexPath) as! TeamCollectionViewCell
            cell.teamLabel.text = teams[indexPath.row].teamName
            cell.teamImg.sd_setImage(with: URL(string: teams[indexPath.row].teamLogo ?? ""), placeholderImage: UIImage(named: "placeholder"))
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    
}

extension DetailsViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == teamsCollectionView{
            print("ouch")
            
            if sportType == "Football"{
                let teamDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetailsViewController") as! TeamDetailsViewController
                
                teamDetailsViewController.setupTeamView(teams[indexPath.row])
                teamDetailsViewController.title = teams[indexPath.row].teamName
                
                self.navigationController?.pushViewController(teamDetailsViewController, animated: true)
            }else if sportType == "Basketball"{
                teamKey = teams[indexPath.row].teamKey
                teamName = teams[indexPath.row].teamName
                tempTeamUrl = teams[indexPath.row].teamLogo
                detailsViewModel.requestFromApi(sportType.lowercased(), nil, teams[indexPath.row].teamKey)
            }
        }
    }
}

extension DetailsViewController: UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsOfFixtures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ResultTableViewCell
        
        cell.matchScore.text = resultsOfFixtures[indexPath.row].eventFinalResult ?? resultsOfFixtures[indexPath.row].eventHomeFinalResult
        
        if sportType == "Tennis"{
            cell.homeTeam.text = resultsOfFixtures[indexPath.row].eventFirstPlayer
            cell.awayTeam.text = resultsOfFixtures[indexPath.row].eventSecondPlayer
            cell.awayImg.sd_setImage(with: URL(string: resultsOfFixtures[indexPath.row].eventSecondPlayerLogo ?? ""), placeholderImage: UIImage(named: "player-placeholder"))
            cell.homeImg.sd_setImage(with: URL(string: resultsOfFixtures[indexPath.row].eventFirstPlayerLogo ?? ""), placeholderImage: UIImage(named: "player-placeholder"))
        }else{
            cell.homeTeam.text = resultsOfFixtures[indexPath.row].eventHomeTeam
            cell.awayTeam.text = resultsOfFixtures[indexPath.row].eventAwayTeam
            
            if resultsOfFixtures[indexPath.row].homeTeamLogo == nil{
                if let homeTeamLogoURLString = resultsOfFixtures[indexPath.row].eventHomeTeamLogo,
                        let homeTeamLogoURL = URL(string: homeTeamLogoURLString) {
                         cell.homeImg?.sd_setImage(with: homeTeamLogoURL, placeholderImage: UIImage(named: "placeholder"))
                     } else {
                         cell.homeImg?.image = UIImage(named: "placeholder")
                     }

                     if let awayTeamLogoURLString = resultsOfFixtures[indexPath.row].eventAwayTeamLogo,
                        let awayTeamLogoURL = URL(string: awayTeamLogoURLString) {
                         cell.awayImg?.sd_setImage(with: awayTeamLogoURL, placeholderImage: UIImage(named: "placeholder"))
                     } else {
                         cell.awayImg?.image = UIImage(named: "placeholder")
                     }
            }else{
                if let homeTeamLogoURLString = resultsOfFixtures[indexPath.row].homeTeamLogo,
                        let homeTeamLogoURL = URL(string: homeTeamLogoURLString) {
                         cell.homeImg?.sd_setImage(with: homeTeamLogoURL, placeholderImage: UIImage(named: "placeholder"))
                     } else {
                         cell.homeImg?.image = UIImage(named: "placeholder")
                     }

                     if let awayTeamLogoURLString = resultsOfFixtures[indexPath.row].awayTeamLogo,
                        let awayTeamLogoURL = URL(string: awayTeamLogoURLString) {
                         cell.awayImg?.sd_setImage(with: awayTeamLogoURL, placeholderImage: UIImage(named: "placeholder"))
                     } else {
                         cell.awayImg?.image = UIImage(named: "placeholder")
                     }
            }
        }
        
        return cell
    }
    
    
}
