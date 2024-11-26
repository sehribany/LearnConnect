//
//  CourseManager.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 26.11.2024.
//
import Foundation

// MARK: - Course Manager
final class CourseManager {
    // Singleton instance
    static let shared = CourseManager()
    
    private init() {}

    var registeredCourses: [Course] = []

    /// - Parameter course: The course to be added.
    func addCourse(_ course: Course) {
        registeredCourses.append(course)
        NotificationCenter.default.post(name: NSNotification.Name("CourseAdded"), object: nil)
    }
    
    /// - Parameter course: The course to be removed.
    func removeCourse(_ course: Course) {
        registeredCourses.removeAll { $0.id == course.id }
        NotificationCenter.default.post(name: NSNotification.Name("CourseRemoved"), object: course)
    }
}
