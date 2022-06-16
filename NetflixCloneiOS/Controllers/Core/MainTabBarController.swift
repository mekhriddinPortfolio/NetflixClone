//
//  MainTabBarController.swift
//  NetflixCloneiOS
//
//  Created by Mekhriddin on 07/06/22.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let nc1 = UINavigationController(rootViewController: HomeViewController())
        let nc2 = UINavigationController(rootViewController: UpcomingViewController())
        let nc3 = UINavigationController(rootViewController: SearchViewController())
        let nc4 = UINavigationController(rootViewController: DownloadsViewController())
        
        nc1.tabBarItem.image = UIImage(systemName: "house")
        nc2.tabBarItem.image = UIImage(systemName: "play.circle")
        nc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        nc4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        nc1.title = "Home"
        nc2.title = "Coming Soon"
        nc3.title = "Top Seaches"
        nc4.title = "Downloads"
        
        tabBar.tintColor = .label
        
        setViewControllers([nc1, nc2, nc3, nc4], animated: true)
    }

}
