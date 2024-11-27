//
//  LoginViewModel.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 21.11.2024.
//

import UIKit
import CoreData

protocol LoginViewDataSource {
    func fetchUser(byEmail email: String) -> Users?
    func authenticateUser(email: String, password: String) -> Bool
}

protocol LoginViewEventSource {}

protocol LoginViewProtocol: LoginViewDataSource, LoginViewEventSource {}

final class LoginViewModel: BaseViewModel, LoginViewProtocol {
    
    /// - Returns: The `Users` object if found, otherwise `nil`.
    func fetchUser(byEmail email: String) -> Users? {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<Users> = Users.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            let users = try context.fetch(fetchRequest)
            return users.first
        } catch {
            print("Error fetching user: \(error)")
            return nil
        }
    }
    
    /// - Returns: `true` if the user is authenticated, otherwise `false`.
    func authenticateUser(email: String, password: String) -> Bool {
        if let user = fetchUser(byEmail: email) {
            return user.password == password
        }
        return false
    }
}

// MARK: - User Session Management
extension LoginViewModel {
    func saveUserSession(email: String) {
        UserDefaults.standard.set(email, forKey: "loggedInUserEmail")
    }

    func getUserSession() -> String? {
        return UserDefaults.standard.string(forKey: "loggedInUserEmail")
    }
}
