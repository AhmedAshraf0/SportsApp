//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 30/05/2023.
//

import UIKit
import CoreData

class TeamDetailsViewController: UIViewController {
    private var team: Team!
    private var goalkeepers: [Player] = []
    private var defenders: [Player] = []
    private var midfielders: [Player] = []
    private var forwrads: [Player] = []
    var players: [SportPlayer] = []
    var tempTeamName: String?
    var tempTeamUrl: String?
    var teamKey: Int?
    private var isHeartFilled: Bool?
    
    private var teamDetailsViewModel: TeamDetailsViewModel?
    
    @IBOutlet weak var coachLabelTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var coachName: UILabel!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        teamDetailsViewModel = TeamDetailsViewModel(databaseService: DatabaseService.shared)
        
        
        if players.isEmpty && !goalkeepers.isEmpty{
            coachName.text = team.coaches?.first?.coachName
            teamName.text = team.teamName
            
            if let teamLogoURLString = team.teamLogo, let teamLogoURL = URL(string: teamLogoURLString) {
                teamImg.sd_setImage(with: teamLogoURL, placeholderImage: UIImage(named: "placeholder"))
            } else {
                teamImg.image = UIImage(named: "placeholder")
            }
        }else if !players.isEmpty && goalkeepers.isEmpty{
            coachName.isHidden = true
            coachLabelTitle.isHidden = true
            teamName.text = tempTeamName
            teamImg.sd_setImage(with: URL(string: tempTeamUrl!), placeholderImage: UIImage(named: "placeholder"))
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        if teamDetailsViewModel!.isTeamInFavs(teamKey: teamKey ?? team.teamKey!){
            isHeartFilled = true
            let heartImage = UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysOriginal)
            let heartButton = UIBarButtonItem(image: heartImage, style: .plain, target: self, action: #selector(heartButtonTapped))
            navigationItem.rightBarButtonItem = heartButton
        }else{
            isHeartFilled = false
            let heartImage = UIImage(systemName: "heart")?.withRenderingMode(.alwaysOriginal)
            let heartButton = UIBarButtonItem(image: heartImage, style: .plain, target: self, action: #selector(heartButtonTapped))
            navigationItem.rightBarButtonItem = heartButton
        }
    }
    
    func setupTeamView(_ team: Team){
        self.team = team
        
        for player in team.players!{
            if (player.playerType != nil && player.playerType == "Goalkeepers"){
                goalkeepers.append(player)
            }else if (player.playerType != nil && player.playerType == "Defenders"){
                defenders.append(player)
            }else if (player.playerType != nil && player.playerType == "Midfielders"){
                midfielders.append(player)
            }else if (player.playerType != nil && player.playerType == "Forwards"){
                forwrads.append(player)
            }
        }
    }
    
    @objc func heartButtonTapped() {
        if let heartButton = navigationItem.rightBarButtonItem {
            if isHeartFilled! {
                // Delete team from favorites
                if teamDetailsViewModel!.deleteFromFavs(teamKey: teamKey ?? team.teamKey!) {
                    isHeartFilled = false
                    let heartImage = UIImage(systemName: "heart")?.withRenderingMode(.alwaysOriginal)
                    heartButton.image = heartImage
                }
            } else {
                // Add team to favorites
                if teamDetailsViewModel!.insertToFavs(teamKey ?? team.teamKey!, tempTeamName ?? team.teamName!, tempTeamUrl ?? team.teamLogo!) {
                    isHeartFilled = true
                    let heartImage = UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysOriginal)
                    heartButton.image = heartImage
                }
            }
        }
        print("ouch")
    }

}

extension TeamDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if players.isEmpty && !goalkeepers.isEmpty{
            return 4
        }else if !players.isEmpty && goalkeepers.isEmpty{
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if players.isEmpty{
            switch section {
            case 0:
                return goalkeepers.count
            case 1:
                return defenders.count
            case 2:
                return midfielders.count
            case 3:
                return forwrads.count
            default:
                return 0
            }
        }else{
            return players.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if players.isEmpty{
            let player: Player
            switch indexPath.section {
            case 0:
                player = goalkeepers[indexPath.row]
            case 1:
                player = defenders[indexPath.row]
            case 2:
                player = midfielders[indexPath.row]
            case 3:
                player = forwrads[indexPath.row]
            default:
                return UITableViewCell()
            }
            
            cell.textLabel?.text = player.playerName
            cell.detailTextLabel?.text = "Matches Played: \(player.playerMatchPlayed ?? "-") | Goals: \(player.playerGoals ?? "-")"

            
            if let playerImageURLString = player.playerImage, let playerImageURL = URL(string: playerImageURLString) {
                cell.imageView?.sd_setImage(with: playerImageURL, placeholderImage: UIImage(named: "player-placeholder"))
            } else {
                cell.imageView?.image = UIImage(named: "player-placeholder")
            }
        }else{
            cell.textLabel?.text = players[indexPath.row].playerName
            cell.detailTextLabel?.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if players.isEmpty{
            switch section {
            case 0:
                return "Goalkeepers"
            case 1:
                return "Defenders"
            case 2:
                return "Midfielders"
            case 3:
                return "Forwards"
            default:
                return nil
            }
        }else{
            return "Players"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView else { return }
        
        headerView.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    }
}

