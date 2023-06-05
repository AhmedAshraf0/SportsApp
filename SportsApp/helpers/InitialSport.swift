//
//  InitialSport.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 26/05/2023.
//

import UIKit

struct InitialSport{
    let image : UIImage
    let title : String
}

let sports : [InitialSport] = [
    InitialSport(image: UIImage(named: "football")!, title: "Football"),
    InitialSport(image: UIImage(named: "basketball")!, title: "Basketball"),
    InitialSport(image: UIImage(named: "tennis")!, title: "Tennis"),
    InitialSport(image: UIImage(named: "cricket")!, title: "Cricket")
]
