//
//  MainTabBarController.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 22.11.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    var userEmail: String? {
        didSet {
            CourseManager.shared.userEmail = userEmail
        }
    }

    init(userEmail: String?) {
        self.userEmail = userEmail
        super.init(nibName: nil, bundle: nil)
        CourseManager.shared.userEmail = userEmail
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
    
    private func createHomeViewController() -> UIViewController {
        let homeViewController = HomeViewController(viewModel: HomeViewModel())
        homeViewController.tabBarItem.title = localizedString("Maintab.home")
        homeViewController.tabBarItem.image = UIImage(named: "icHome") // Replace with icon logic
        return homeViewController
    }

    private func createCourseViewController() -> UIViewController {
        let courseViewController = CourseViewController(viewModel: CourseViewModel())
        courseViewController.tabBarItem.title = localizedString("Maintab.course")
        courseViewController.tabBarItem.image = UIImage(named: "icCourse") // Replace with icon logic
        return courseViewController
    }

    private func createProfileViewController() -> UIViewController {
        let profileViewController = ProfileViewController(viewModel: ProfileViewModel(userEmail: userEmail))
        profileViewController.tabBarItem.title = localizedString("Maintab.profile")
        profileViewController.tabBarItem.image = UIImage(named: "icProfile") // Replace with icon logic
        return profileViewController
    }
}

