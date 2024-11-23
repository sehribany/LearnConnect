//
//  RegisterViewController.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 21.11.2024.
//

import UIKit
import CoreData
 
class RegisterViewController: BaseViewController<RegisterViewModel> {

    private lazy var registerView = RegisterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubView()
        self.navigationConfigure()
        registerView.delegate = self
    }
    
    private func navigationConfigure() {
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = localizedString("Register.signup")
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
//MARK: -RegisterViewDelegate
extension RegisterViewController: RegisterViewDelegate{
        
    func didTapRegister(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            ToastPresenter.showWarningToast(text: localizedString("Toast.ep.empty"))
            registerView.clearFields()
            return
        }
        
        if viewModel.isEmailAlreadyRegistered(email: email) {
            ToastPresenter.showWarningToast(text: localizedString("Toast.emailalready"))
            registerView.clearFields()
            return
        }
        
        viewModel.registerUser(email: email, password: password)
        ToastPresenter.showWarningToast(text: localizedString("Toast.registrationsuccess"))
        registerView.clearFields()
        self.didTapToLogin()
    }

    func didTapToLogin() {
        navigationController?.pushViewController(LoginViewController(viewModel: LoginViewModel()), animated: true)
    }
}
