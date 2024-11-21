//
//  MainNavigationController.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 21.11.2024.
//

import UIKit

class MainNavigationController: UINavigationController {
    // MARK: - Status Bar Style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContents()
    }
    
    // MARK: - Configuration Methods
    private func configureContents() {
        let backImage = UIImage(named: "icBack")?
            .resize(to: .init(width: 11, height: 18))
            .withRenderingMode(.alwaysTemplate)
            .withAlignmentRectInsets(.init(top: 0, left: 0, bottom: -2, right: 0))
        
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18, weight: .bold),
            .foregroundColor: UIColor.appTitle
        ]
        
        let largeTitleTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 26, weight: .bold),
            .foregroundColor: UIColor.appTitle
        ]
        
        navigationBar.barTintColor        = UIColor.orange
        navigationBar.shadowImage         = UIImage()
        navigationBar.tintColor           = .appTitle
        navigationBar.titleTextAttributes = titleTextAttributes
        navigationBar.backIndicatorImage               = backImage
        navigationBar.backIndicatorTransitionMaskImage = backImage
        
        // MARK: - iOS 13+ Appearance Configuration
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.appBackground2
            
            appearance.titleTextAttributes = titleTextAttributes
            appearance.largeTitleTextAttributes = largeTitleTextAttributes
            appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
            
            navigationBar.standardAppearance   = appearance
            navigationBar.scrollEdgeAppearance = appearance
            navigationBar.compactAppearance    = appearance
        }
        navigationBar.backItem?.backBarButtonItem?.setTitlePositionAdjustment(.init(horizontal: 0, vertical: -13), for: .default)
    }
}
