//
//  MainTabBarController.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 22.11.2024.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor          = .appButtonBackground1
        tabBar.backgroundColor    = .appBackground
        let homeViewController    = createHomeViewController()
        let courseViewController  = createCourseViewController()
        let profileViewController = createProfileViewController()
        viewControllers = [homeViewController, courseViewController, profileViewController,]
    }
    
    private func configureTabBarIcons(navController: MainNavigationController, icon: UIImage?) {
        guard let icon = icon else { return }
        let resizedIcon = icon.withRenderingMode(.alwaysOriginal).scaled(to: CGSize(width: 19, height: 20))
        navController.tabBarItem.image = resizedIcon
    }
    
    private func configureTabBarTitle(navController: MainNavigationController, title: String?){
        navController.tabBarItem.title = title
    }
    
    private func createHomeViewController()-> UINavigationController {
        let homeViewModel      = HomeViewModel()
        let homeViewController = HomeViewController(viewModel:homeViewModel)
        let navController      = MainNavigationController(rootViewController: homeViewController)
        configureTabBarIcons(navController: navController, icon: UIImage(named: "icHome"))
        configureTabBarTitle(navController: navController, title: "Home")
        return navController
    }
    
    private func createCourseViewController()-> UINavigationController {
        let courseViewModel      = CourseViewModel()
        let courseViewController = CourseViewController(viewModel: courseViewModel)
        let navController                = MainNavigationController(rootViewController: courseViewController)
        configureTabBarIcons(navController: navController, icon: UIImage(named: "icCourse"))
        configureTabBarTitle(navController: navController, title: "Course")
        return navController
    }
    
    private func createProfileViewController()-> UINavigationController{
        let profileViewModel      = ProfileViewModel()
        let profileViewController = ProfileViewController(viewModel: profileViewModel)
        let navController         = MainNavigationController(rootViewController: profileViewController)
        configureTabBarIcons(navController: navController, icon: UIImage(named: "icProfile"))
        configureTabBarTitle(navController: navController, title: "Profile")
        return navController
    }
}
