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
        homeViewController.tabBarItem.image =  resizedImage(named: "icHome", size: CGSize(width: 26, height: 28))
        return homeViewController
    }
    
    private func createCourseViewController() -> UIViewController {
        let courseViewController = CourseViewController(viewModel: CourseViewModel())
        courseViewController.tabBarItem.title = localizedString("Maintab.course")
        courseViewController.tabBarItem.image = resizedImage(named: "icCourse", size: CGSize(width: 26, height: 28))
        return courseViewController
    }
    
    private func createProfileViewController() -> UIViewController {
        let profileViewController = ProfileViewController(viewModel: ProfileViewModel(userEmail: userEmail))
        profileViewController.tabBarItem.title = localizedString("Maintab.profile")
        profileViewController.tabBarItem.image = resizedImage(named: "icProfile", size: CGSize(width: 26, height: 28))
        return profileViewController
    }
    
    /// - Returns: A resized UIImage or nil if the image does not exist
    private func resizedImage(named: String, size: CGSize) -> UIImage? {
        guard let image = UIImage(named: named) else { return nil }
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
