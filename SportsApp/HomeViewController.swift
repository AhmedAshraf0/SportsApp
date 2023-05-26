//
//  ViewController.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 26/05/2023.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting up tabBar
        title = "Home"
        tabBarController?.tabBar.items?.first?.image = UIImage(systemName: "house.fill")
        tabBarController?.tabBar.items?.last?.title = "Favorites"
        tabBarController?.tabBar.items?.last?.image = UIImage(systemName: "heart.fill")
        
    }


}

