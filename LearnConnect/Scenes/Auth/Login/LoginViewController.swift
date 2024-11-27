//
//  LoginViewController.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 21.11.2024.
//

import UIKit
 
class LoginViewController: BaseViewController<LoginViewModel> {
    
    //MARK: - Properties
    private lazy var loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubView()
        self.navigationConfigure()
        loginView.delegate = self
        if let email = viewModel.getUserSession() {
            navigateToMainTabBar(email: email)
        }
    }
    
    private func navigateToMainTabBar(email: String) {
        let mainTabBarController = MainTabBarController(userEmail: email)
        self.navigationController?.pushViewController(mainTabBarController, animated: false)
    }
    
    private func navigationConfigure() {
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = localizedString("Login.login")
    }
}
//MARK: - UILayout
extension LoginViewController{
    private func addSubView(){
        addLoginView()
    }
    
    private func addLoginView(){
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.trailing.leading.equalToSuperview()
        }
    }
}
//MARK: - LoginViewDelegate
extension LoginViewController: LoginViewDelegate{
    func didTapLogin(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            ToastPresenter.showWarningToast(text: localizedString("Toast.ep.empty"))
            loginView.clearFields()
            return
        }
        if viewModel.authenticateUser(email: email, password: password) {
            ToastPresenter.showWarningToast(text: localizedString("Toast.loginsuccess"))
            loginView.clearFields()
            viewModel.saveUserSession(email: email)
            navigateToMainTabBar(email: email)
        } else {
            ToastPresenter.showWarningToast(text: localizedString("Toast.invalid"))
            loginView.clearFields()
        }
    }
    
    func didTapToRegister() {
        navigationController?.pushViewController(RegisterViewController(viewModel: RegisterViewModel()), animated: true)
    }
}
