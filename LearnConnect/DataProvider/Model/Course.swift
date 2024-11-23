//
//  Course.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 22.11.2024.
//

import Foundation

// MARK: - Course Model
struct Course: Codable {
    let id: String
    let name: String
    let image: String
    let description: String
    let category: Category
    let lessons: [Lesson]
}

enum Category: String, Codable {
    case development = "Development"
    case language = "Language"
    case design = "Design"
    case health = "Health"
}
