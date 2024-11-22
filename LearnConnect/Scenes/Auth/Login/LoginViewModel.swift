//
//  LoginViewModel.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 21.11.2024.
//

import UIKit
import CoreData

protocol LoginViewDataSource {}

protocol LoginViewEventSource {}

protocol LoginViewProtocol: LoginViewDataSource, LoginViewEventSource {}

final class LoginViewModel: BaseViewModel, LoginViewProtocol {
    
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
    
    func authenticateUser(email: String, password: String) -> Bool {
        if let user = fetchUser(byEmail: email) {
            return user.password == password
        }
        return false
    }

}
