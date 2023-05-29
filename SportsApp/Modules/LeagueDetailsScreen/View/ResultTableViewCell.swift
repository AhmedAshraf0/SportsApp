//
//  ResultTableViewCell.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 29/05/2023.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var matchScore: UILabel!
    @IBOutlet weak var awayTeam: UILabel!
    @IBOutlet weak var homeTeam: UILabel!
    @IBOutlet weak var awayImg: UIImageView!
    @IBOutlet weak var homeImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
