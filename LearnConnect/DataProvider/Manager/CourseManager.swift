//
//  CourseManager.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 26.11.2024.
//
import Foundation

final class CourseManager {
    static let shared = CourseManager()
    
    private init() {}

    var userEmail: String? {
        didSet {
            loadRegisteredCourses()
        }
    }

    private var registeredCourses: [Course] = []

    private let userDefaultsKey = "registeredCourses"
    
    var currentUserCourses: [Course] {
        return registeredCourses
    }
    
    func addCourse(_ course: Course) {
        guard userEmail != nil else { return }
        registeredCourses.append(course)
        saveRegisteredCourses()
        NotificationCenter.default.post(name: NSNotification.Name("CourseAdded"), object: nil)
    }
    
    func removeCourse(_ course: Course) {
        guard userEmail != nil else { return }
        registeredCourses.removeAll { $0.id == course.id }
        saveRegisteredCourses()
        NotificationCenter.default.post(name: NSNotification.Name("CourseRemoved"), object: course)
    }
    
    private func loadRegisteredCourses() {
        guard let userEmail = userEmail else { return }
        guard let data = UserDefaults.standard.data(forKey: "\(userDefaultsKey)_\(userEmail)") else {
            registeredCourses = []
            return
        }
        do {
            let courses = try JSONDecoder().decode([Course].self, from: data)
            self.registeredCourses = courses
        } catch {
            print("Failed to decode courses: \(error)")
            registeredCourses = []
        }
    }

    private func saveRegisteredCourses() {
        guard let userEmail = userEmail else { return }
        do {
            let data = try JSONEncoder().encode(registeredCourses)
            UserDefaults.standard.set(data, forKey: "\(userDefaultsKey)_\(userEmail)")
        } catch {
            print("Failed to encode courses: \(error)")
        }
    }
}
