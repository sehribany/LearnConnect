//
//  RegisterViewController.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 21.11.2024.
//

import UIKit
 
class RegisterViewController: BaseViewController<RegisterViewModel> {

    private lazy var registerView = RegisterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubView()
        self.navigationConfigure()
        configure()
    }
    
    private func navigationConfigure() {
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = localizedString("Register.signup")
    }
    
    private func configure(){
        registerView.toLoginButton.addTarget(self, action: #selector(toLogin), for: .touchUpInside)
        registerView.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
    }
}

//MARK: -UILayout
extension RegisterViewController{
    private func addSubView(){
        addRegisterView()
    }
    
    private func addRegisterView(){
        view.addSubview(registerView)
        registerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.trailing.leading.equalToSuperview()
        }
    }
}
//MARK: -Actions
extension RegisterViewController{
    
    @objc
    private func toLogin(){
        navigationController?.pushViewController(LoginViewController(viewModel: LoginViewModel()), animated: true)
    }
    
    @objc
    private func register(){
        
    }
}
