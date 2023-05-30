//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 30/05/2023.
//

import UIKit

class TeamDetailsViewController: UIViewController {
    private var team: Team!
    private var goalkeepers: [Player] = []
    private var defenders: [Player] = []
    private var midfielders: [Player] = []
    private var forwrads: [Player] = []
    private var isHeartFilled = false
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var coachName: UILabel!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        coachName.text = team.coaches?.first?.coachName
        teamName.text = team.teamName
        if let teamLogoURLString = team.teamLogo, let teamLogoURL = URL(string: teamLogoURLString) {
            teamImg.sd_setImage(with: teamLogoURL, placeholderImage: UIImage(named: "placeholder"))
        } else {
            teamImg.image = UIImage(named: "placeholder")
        }

        let heartImage = UIImage(systemName: "heart")?.withRenderingMode(.alwaysOriginal)
        let heartButton = UIBarButtonItem(image: heartImage, style: .plain, target: self, action: #selector(heartButtonTapped))
        navigationItem.rightBarButtonItem = heartButton
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
                isHeartFilled.toggle()
                
                let heartImageName = isHeartFilled ? "heart.fill" : "heart"
                let heartImage = UIImage(systemName: heartImageName)?.withRenderingMode(.alwaysOriginal)
                heartButton.image = heartImage
            }
        print("ouch")
    }


    

}

extension TeamDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
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
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView else { return }
        
        headerView.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    }
}

