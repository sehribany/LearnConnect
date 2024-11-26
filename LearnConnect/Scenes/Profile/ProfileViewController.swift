//
//  ProfileViewController.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 22.11.2024.
//

import UIKit

class ProfileViewController: BaseViewController<ProfileViewModel> {
    
    private lazy var userView: UserView = {
        let view = UserView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureUserView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUserView()
    }
    
    private func setupView() {
        view.backgroundColor = .appBackground
        view.addSubview(userView)
        userView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(150)
        }
    }
    
    private func configureUserView() {
        let email = viewModel.userEmail ?? localizedString("Profile.noemail")
        userView.setUserEmail(email)
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        userView.setThemeSwitchState(isOn: isDarkMode)
    }
}
