//
//  UserView.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 26.11.2024.
//

import UIKit

protocol UserViewDelegate: AnyObject {
    func didTapLogout()
}

class UserView: UIView {
    
    // MARK: - Properties
    private lazy var emailLabel: UILabel = {
        let label  = UILabel()
        label.text = localizedString("Login.email")
        label.font = UIFont.systemFont(ofSize: 16,weight: .bold)
        label.textColor = .appTitle
        return label
    }()
        
    private lazy var userEmailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16,weight: .medium)
        label.textColor = .appTitle
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var themeLabel: UILabel = {
        let label  = UILabel()
        label.text = localizedString("Theme.preference")
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .appTitle
        return label
    }()
    
    private lazy var themeSwitch: UISwitch = {
        let switchControl = UISwitch()
        switchControl.onTintColor = .appButtonBackground1
        switchControl.isOn = traitCollection.userInterfaceStyle == .dark
        switchControl.addTarget(self, action: #selector(didToggleThemeSwitch(_:)), for: .valueChanged)
        return switchControl
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .appButtonBackground1
        button.setTitle(localizedString("Logout.button"), for: .normal)
        button.tintColor = .appButtonTitle1
        button.layer.cornerRadius = 9
        button.titleLabel?.font  = UIFont.systemFont(ofSize: 23)
        button.addTarget(self, action: #selector(didTapLogoutButton), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: UserViewDelegate?
    
    @objc private func didTapLogoutButton() {
        delegate?.didTapLogout()
    }
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubView()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func setUserEmail(_ email: String) {
        userEmailLabel.text = email
    }
    
    func setThemeSwitchState(isOn: Bool) {
        themeSwitch.isOn = isOn
    }
    
    // MARK: - Actions
    @objc private func didToggleThemeSwitch(_ sender: UISwitch) {
        if sender.isOn {
            setAppAppearance(.dark)
        } else {
            setAppAppearance(.light)
        }
    }
    
    private func setAppAppearance(_ style: UIUserInterfaceStyle) {
        guard let window = UIApplication.shared.windows.first else { return }
        
        UIView.transition(with: window, duration: 0.3, options: [.transitionCrossDissolve], animations: {
            window.overrideUserInterfaceStyle = style
        }, completion: nil)
    }
}

// MARK: - UILayout
extension UserView {
    private func addSubView() {
        backgroundColor = UIColor.appBackground3
        addEmail()
        addUserEmailLabel()
        addThemeLabel()
        addSwitch()
        addLogoutButton()
    }
    
    private func addEmail() {
        addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
        }
    }
    
    private func addUserEmailLabel() {
        addSubview(userEmailLabel)
        userEmailLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
        }
    }
    
    private func addThemeLabel() {
        addSubview(themeLabel)
        themeLabel.snp.makeConstraints { make in
            make.top.equalTo(userEmailLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
        }
    }
    
    private func addSwitch() {
        addSubview(themeSwitch)
        themeSwitch.snp.makeConstraints { make in
            make.top.equalTo(themeLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
        }
    }
    
    private func addLogoutButton() {
        addSubview(logoutButton)
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(themeSwitch.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    private func configure(){
        backgroundColor = .appBackground3
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.appCellShadow.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowRadius = 10
        layer.masksToBounds = false
    }
}
