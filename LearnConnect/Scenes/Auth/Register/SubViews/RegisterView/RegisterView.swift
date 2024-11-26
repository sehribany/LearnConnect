//
//  RegisterView.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 21.11.2024.
//

import UIKit
import SnapKit

protocol RegisterViewDelegate: AnyObject {
    func didTapRegister(email: String, password: String)
    func didTapToLogin()
}

class RegisterView: UIView {
    
    //MARK: - Properties
    weak var delegate: RegisterViewDelegate?

    private lazy var emailLabel: UILabel = {
        let label  = UILabel()
        label.text = localizedString("Register.email")
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .appText
        return label
    }()
        
    private lazy var emailText : UITextField = {
        let text = UITextField()
        text.borderStyle = .roundedRect
        text.backgroundColor = .clear
        text.textColor = .appTitle
        text.font = UIFont.systemFont(ofSize: 15)
        let placeholderFont = UIFont.systemFont(ofSize: 15)
        let placeholderColor = UIColor.appText
        let attributes = [NSAttributedString.Key.font: placeholderFont,NSAttributedString.Key.foregroundColor: placeholderColor]
        text.attributedPlaceholder = NSAttributedString(string:localizedString("Register.emailplace"),attributes: attributes )
        text.layer.cornerRadius = 9
        text.keyboardType = .emailAddress
        return text
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label  = UILabel()
        label.text = localizedString("Register.password")
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .appText
        return label
    }()
        
    private lazy var passwordText : UITextField = {
        let text = UITextField()
        text.borderStyle = .roundedRect
        text.backgroundColor = .clear
        text.textColor = .appTitle
        text.font = UIFont.systemFont(ofSize: 15)
        let placeholderFont = UIFont.systemFont(ofSize: 15)
        let placeholderColor = UIColor.appText
        let attributes = [NSAttributedString.Key.font: placeholderFont,NSAttributedString.Key.foregroundColor: placeholderColor]
        text.attributedPlaceholder = NSAttributedString(string:localizedString("Register.passwordplace"),attributes: attributes )
        text.layer.cornerRadius = 9
        text.isSecureTextEntry = true
        return text
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .appButtonBackground1
        button.setTitle(localizedString("Register.register"), for: .normal)
        button.tintColor = .appButtonTitle1
        button.layer.cornerRadius = 9
        button.titleLabel?.font  = UIFont.systemFont(ofSize: 23)
        button.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        return button
    }()
    
    private lazy var toRegisterLabel: UILabel = {
        let label  = UILabel()
        label.text = localizedString("Register.toLogin")
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .appText
        return label
    }()
    
    private lazy var toLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle(localizedString("Login.login"), for: .normal)
         button.tintColor = .appButtonBackground1
        button.titleLabel?.font  = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(didTapToLogin), for: .touchUpInside)
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

//MARK: - UILayout
extension RegisterView{
    private func addSubView(){
        backgroundColor = UIColor.appBackground3
        addEmail()
        addEmailText()
        addPassword()
        addPasswordText()
        addRegisterButton()
        addtoRegister()
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
    
    private func addRegisterButton(){
        addSubview(registerButton)
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(passwordText.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(25)
            make.height.equalTo(50)
        }
    }

    private func addtoRegister(){
        addSubview(toRegisterLabel)
        addSubview(toLoginButton)
        
        toRegisterLabel.snp.makeConstraints { make in
            make.top.equalTo(registerButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview().offset(-40)
        }
        
        toLoginButton.snp.makeConstraints { make in
            make.centerY.equalTo(toRegisterLabel)
            make.leading.equalTo(toRegisterLabel.snp.trailing).offset(5)
        }
    }
}
//MARK: -Keyboard and Action
extension RegisterView{
    
    private func addTapGestureToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
    }
    
    @objc private func dismissKeyboard(){
        self.endEditing(true)
    }
    
    @objc private func didTapRegister() {
        guard let email = emailText.text,
              let password = passwordText.text else { return }
        delegate?.didTapRegister(email: email, password: password)
    }
    
    @objc private func didTapToLogin() {
        delegate?.didTapToLogin()
    }
    
    func clearFields() {
        emailText.text = ""
        passwordText.text = ""
    }
}
