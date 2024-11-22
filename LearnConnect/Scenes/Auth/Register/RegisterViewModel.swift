//
//  RegisterViewModel.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 21.11.2024.
//
import Foundation
import CoreData

protocol RegisterViewDataSource {}

protocol RegisterViewEventSource {}

protocol RegisterViewProtocol: RegisterViewDataSource, RegisterViewEventSource {}

final class RegisterViewModel: BaseViewModel, RegisterViewProtocol {
    
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
