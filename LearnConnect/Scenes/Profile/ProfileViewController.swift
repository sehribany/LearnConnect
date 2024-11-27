//
//  ProfileViewController.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 22.11.2024.
//

import UIKit

class ProfileViewController: BaseViewController<ProfileViewModel> {
    
    // MARK: - Properties
    private lazy var userView: UserView = {
        let view = UserView()
        return view
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureUserView()
        userView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUserView()
    }
    
    // MARK: - Setup View
    private func setupView() {
        view.backgroundColor = .appBackground
        view.addSubview(userView)
        userView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(200)
        }
    }
    
    // MARK: - Configure User View
    private func configureUserView() {
        let email = viewModel.getUserEmail() ?? localizedString("Profile.noemail")
        userView.setUserEmail(email)
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        userView.setThemeSwitchState(isOn: isDarkMode)
    }
}

// MARK: - UserViewDelegate
extension ProfileViewController: UserViewDelegate {
    func didTapLogout() {
        viewModel.clearUserSession()
        let loginViewController = LoginViewController(viewModel: LoginViewModel())
        navigationController?.setViewControllers([loginViewController], animated: true)
    }
}
