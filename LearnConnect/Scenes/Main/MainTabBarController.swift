//
//  MainTabBarController.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 22.11.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    var userEmail: String?
    
    init(userEmail: String?) {
        self.userEmail = userEmail
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .appButtonBackground1
        tabBar.backgroundColor = .appBackground
        let homeViewController = createHomeViewController()
        let courseViewController = createCourseViewController()
        let profileViewController = createProfileViewController()
        viewControllers = [homeViewController, courseViewController, profileViewController]
        navigationItem.title = localizedString("Maintab.navigationtitle")
        navigationItem.hidesBackButton = true
    }
    
    private func configureTabBarIcons(iconName: String?) -> UIImage? {
        guard let iconName = iconName,
              let icon = UIImage(named: iconName) else { return nil }
        return icon.withRenderingMode(.alwaysOriginal).scaled(to: CGSize(width: 19, height: 20))
    }
    
    private func createHomeViewController() -> UIViewController {
        let homeViewController = HomeViewController(viewModel: HomeViewModel())
        homeViewController.tabBarItem.image = configureTabBarIcons(iconName: "icHome")
        homeViewController.tabBarItem.title = localizedString("Maintab.home")
        return homeViewController
    }

    private func createCourseViewController() -> UIViewController {
        let courseViewController = CourseViewController(viewModel: CourseViewModel())
        courseViewController.tabBarItem.image = configureTabBarIcons(iconName: "icCourse")
        courseViewController.tabBarItem.title = localizedString("Maintab.course")
        return courseViewController
    }

    private func createProfileViewController() -> UIViewController {
        let profileViewController = ProfileViewController(viewModel: ProfileViewModel(userEmail: userEmail))
        profileViewController.tabBarItem.image = configureTabBarIcons(iconName: "icProfile")
        profileViewController.tabBarItem.title = localizedString("Maintab.profile")
        return profileViewController
    }
}
