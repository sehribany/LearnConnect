//
//  RegisterViewModel.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 21.11.2024.
//
import Foundation
import CoreData

protocol RegisterViewDataSource {
    func isEmailAlreadyRegistered(email: String) -> Bool
    func registerUser(id: UUID, email: String, password: String)
}

protocol RegisterViewEventSource {}

protocol RegisterViewProtocol: RegisterViewDataSource, RegisterViewEventSource {}

final class RegisterViewModel: BaseViewModel, RegisterViewProtocol {
    
    /// - Parameter email: The email to check.
    /// - Returns: `true` if the email exists, otherwise `false`.
    func isEmailAlreadyRegistered(email: String) -> Bool {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<Users> = Users.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            let users = try context.fetch(fetchRequest)
            return !users.isEmpty
        } catch {
            print("Error fetching user: \(error)")
            return false
        }
    }
    
    ///   - Parameters:
    ///   - id: The unique identifier for the user (default: UUID).
    ///   - email: The user's email.
    ///   - password: The user's password.
    func registerUser(id: UUID = UUID(), email: String, password: String) {
        let context = CoreDataManager.shared.context
        
        let newUser = Users(context: context)
        newUser.id = id
        newUser.email = email
        newUser.password = password
        
        do {
            try context.save()
            print("User registered successfully")
        } catch {
            print("Failed to save user: \(error)")
        }
    }
}
