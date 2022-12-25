//
//  TabBarViewController.swift
//  PomodoroApp
//
//  Created by Акбота Бакыт on 30.11.2022.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    private let mainVC = MainViewController()
    private let settingsVC = SettingsViewController()
    private let historyVC = HistoryViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    private func setupVC() {
        viewControllers = [mainVC, settingsVC, historyVC]
        
        mainVC.tabBarItem = UITabBarItem(title: "Main", image: UIImage(named: "home"), selectedImage: UIImage(named: "homeSlctd"))
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "settings"), selectedImage: UIImage(named: "settingsSlctd"))
        historyVC.tabBarItem = UITabBarItem(title: "History", image: UIImage(named: "history"), selectedImage: UIImage(named: "historySlctd"))
        
        self.tabBar.tintColor = .white
        self.tabBar.unselectedItemTintColor = .white
    }
}
