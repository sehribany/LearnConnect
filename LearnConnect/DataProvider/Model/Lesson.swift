//
//  Lesson.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 22.11.2024.
//

// MARK: - Lesson Model
struct Lesson: Codable {
    let id: String
    let courseId: String
    let name: String
    let video: String
    let progress: Int
}
