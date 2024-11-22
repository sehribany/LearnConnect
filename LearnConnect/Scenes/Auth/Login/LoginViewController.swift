//
//  LoginViewController.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 21.11.2024.
//

import UIKit
 
class LoginViewController: BaseViewController<LoginViewModel> {

    private lazy var loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubView()
        self.navigationConfigure()
        loginView.delegate = self
    }
    
    private func navigationConfigure() {
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = localizedString("Login.login")
    }
}

//MARK: -UILayout
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
//MARK: -LoginViewDelegate
extension LoginViewController: LoginViewDelegate{
    func didTapLogin(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            ToastPresenter.showWarningToast(text: "Email and Password cannot be empty!")
            loginView.clearFields()
            return
        }
        
        if viewModel.authenticateUser(email: email, password: password) {
            ToastPresenter.showWarningToast(text: "Login successful!")
            loginView.clearFields()
            self.navigationController?.pushViewController(HomeViewController(), animated: true)
        } else {
            ToastPresenter.showWarningToast(text: "Invalid email or password!")
            loginView.clearFields()
        }
    }
    
    func didTapToRegister() {
        navigationController?.pushViewController(RegisterViewController(viewModel: RegisterViewModel()), animated: true)
    }
}
