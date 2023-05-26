//
//  HomeCollectionViewCell.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 26/05/2023.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func setup(with sport : InitialSport){
        img.image = sport.image
        label.text = sport.title
    }
}
