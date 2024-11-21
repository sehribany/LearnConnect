//
//  LoginView.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 22.11.2024.
//

import UIKit
import SnapKit

class LoginView: UIView {

    private lazy var emailLabel: UILabel = {
        let label  = UILabel()
        label.text = localizedString("Login.email")
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .appText
        return label
    }()
        
    lazy var emailText : UITextField = {
        let text = UITextField()
        text.borderStyle = .roundedRect
        text.backgroundColor = .clear
        text.textColor = .appTitle
        text.font = UIFont.systemFont(ofSize: 15)
        let placeholderFont = UIFont.systemFont(ofSize: 15)
        let placeholderColor = UIColor.appText
        let attributes = [NSAttributedString.Key.font: placeholderFont,NSAttributedString.Key.foregroundColor: placeholderColor]
        text.attributedPlaceholder = NSAttributedString(string:localizedString("Login.emailplace"),attributes: attributes )
        text.layer.cornerRadius = 9
        text.keyboardType = .emailAddress
        return text
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label  = UILabel()
        label.text = localizedString("Login.password")
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .appText
        return label
    }()
        
    lazy var passwordText : UITextField = {
        let text = UITextField()
        text.borderStyle = .roundedRect
        text.backgroundColor = .clear
        text.textColor = .appTitle
        text.font = UIFont.systemFont(ofSize: 15)
        let placeholderFont = UIFont.systemFont(ofSize: 15)
        let placeholderColor = UIColor.appText
        let attributes = [NSAttributedString.Key.font: placeholderFont,NSAttributedString.Key.foregroundColor: placeholderColor]
        text.attributedPlaceholder = NSAttributedString(string:localizedString("Login.passwordplace"),attributes: attributes )
        text.layer.cornerRadius = 9
        text.isSecureTextEntry = true
        return text
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .appButtonBackground1
        button.setTitle(localizedString("Login.login"), for: .normal)
        button.tintColor = .appButtonTitle1
        button.layer.cornerRadius = 9
        button.titleLabel?.font  = UIFont.systemFont(ofSize: 23)
        return button
    }()
    
    private lazy var toRegisterLabel: UILabel = {
        let label  = UILabel()
        label.text = localizedString("Login.toRegister")
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .appText
        return label
    }()
    
     lazy var toRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle(localizedString("Register.register"), for: .normal)
         button.tintColor = .appButtonBackground1
        button.titleLabel?.font  = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -UILayout
extension LoginView{
    private func addSubView(){
        backgroundColor = UIColor.appBackground3
        addEmail()
        addEmailText()
        addPassword()
        addPasswordText()
        addLoginButton()
        addtoLogin()
        addTapGestureToDismissKeyboard()
    }
    
    private func addEmail(){
        addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(25)
        }
    }
    
    private func addEmailText(){
        addSubview(emailText)
        emailText.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.height.equalTo(60)
        }
    }
    
    private func addPassword(){
        addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailText.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(25)
            make.height.equalTo(60)
        }
    }
    
    private func addPasswordText(){
        addSubview(passwordText)
        passwordText.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(-10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.height.equalTo(60)
        }
    }
    
    private func addLoginButton(){
        addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordText.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(25)
            make.height.equalTo(50)
        }
    }

    private func addtoLogin(){
        addSubview(toRegisterLabel)
        addSubview(toRegisterButton)
        
        toRegisterLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview().offset(-40)
        }
        
        toRegisterButton.snp.makeConstraints { make in
            make.centerY.equalTo(toRegisterLabel)
            make.leading.equalTo(toRegisterLabel.snp.trailing).offset(5)
        }
    }
}
//MARK: -Keyboard
extension LoginView{
    
    private func addTapGestureToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
    }
    
    @objc private func dismissKeyboard(){
        self.endEditing(true)
    }
}
