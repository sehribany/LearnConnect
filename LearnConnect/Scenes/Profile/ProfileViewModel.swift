//
//  ProfileViewModel.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 22.11.2024.
//

import Foundation

protocol ProfileViewDataSource {
    func getUserEmail() -> String?
}

protocol ProfileViewEventSource {
    func clearUserSession()
}

protocol ProfileViewProtocol: ProfileViewDataSource, ProfileViewEventSource {}

final class ProfileViewModel: BaseViewModel, ProfileViewProtocol {
    
    private var userEmail: String?

    init(userEmail: String?) {
        self.userEmail = userEmail
    }

    func getUserEmail() -> String? {
        return userEmail
    }

    func clearUserSession() {
        UserDefaults.standard.removeObject(forKey: "loggedInUserEmail")
    }
}
