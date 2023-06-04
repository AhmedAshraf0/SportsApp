//
//  LeagueTableViewCell.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 01/06/2023.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {

    @IBOutlet weak var leagueTitle: UILabel!
    @IBOutlet weak var leagueImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        leagueImg.roundedImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupLeagueCellImage(_ imgLink: String?){
        leagueImg.sd_setImage(with: URL(string: imgLink ?? ""), placeholderImage: UIImage(named: "placeholder"))
    }
    
    func setupLeagueCellTitle(_ leagueTitle: String){
        self.leagueTitle.text = leagueTitle
    }
}

extension UIImageView{
    func roundedImage(){
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
    func borderImage(){
        self.layer.cornerRadius = self.frame.size.width/10
        self.clipsToBounds = true
    }
}
