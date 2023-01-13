//
//  MainTabBarController.swift
//  FocusStart-Swift-iOS-TestTask
//
//  Created by Дмитрий Скворцов on 13.01.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let viewController1 = UINavigationController(rootViewController: HomeViewController())
        viewController1.tabBarItem.image = UIImage(systemName: "house")
        viewController1.title = "Home"
        tabBar.tintColor = .label
        setViewControllers([viewController1], animated: true)
    }

}
