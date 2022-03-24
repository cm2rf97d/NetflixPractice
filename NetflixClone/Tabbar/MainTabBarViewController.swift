//
//  MainTabBarViewController.swift
//  NetflixClone
//
//  Created by 陳郁勳 on 2022/2/22.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarViewControllers()
    }

    private func setTabBarViewControllers() {
        let homeViewController: HomeViewController = HomeViewController()
        let upcomingViewController: UpcomingViewController = UpcomingViewController()
        let searchViewController: SearchViewController = SearchViewController()
        let downloadsViewController: DownloadsViewController = DownloadsViewController()
        
        homeViewController.tabBarItem.image = UIImage(systemName: "house")
        upcomingViewController.tabBarItem.image = UIImage(systemName: "play.circle")
        searchViewController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        downloadsViewController.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        homeViewController.title = "Home"
        upcomingViewController.title = "UpComing"
        searchViewController.title = "Search"
        downloadsViewController.title = "Download"
        
        let navHome: UINavigationController = UINavigationController(rootViewController: homeViewController)
        let navUpcoming: UINavigationController = UINavigationController(rootViewController: upcomingViewController)
        let navSearch: UINavigationController = UINavigationController(rootViewController: searchViewController)
        let navDownloads: UINavigationController = UINavigationController(rootViewController: downloadsViewController)
        
        tabBar.tintColor = .label
        
        setViewControllers([navHome,
                            navUpcoming,
                            navSearch,
                            navDownloads], animated: true)
    }

}

