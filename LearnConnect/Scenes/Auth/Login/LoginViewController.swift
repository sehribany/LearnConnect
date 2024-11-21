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
        configure()
    }
    
    private func navigationConfigure() {
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = localizedString("Login.login")
    }
    
    private func configure(){
        loginView.toRegisterButton.addTarget(self, action: #selector(toLogin), for: .touchUpInside)
        loginView.loginButton.addTarget(self, action: #selector(register), for: .touchUpInside)
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
//MARK: -Actions
extension LoginViewController{
    
    @objc
    private func toLogin(){
        navigationController?.pushViewController(RegisterViewController(viewModel: RegisterViewModel()), animated: true)
    }
    
    @objc
    private func register(){
        
    }
}
