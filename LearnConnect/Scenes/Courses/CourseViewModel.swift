//
//  CourseViewModel.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 22.11.2024.
//

import Foundation

protocol CourseViewDataSource: AnyObject {
    func numberOfItemsAt(section: Int) -> Int
    func cellItemAt(indexPath: IndexPath) -> CourseCellViewModel
}

protocol CourseViewEventSource: AnyObject {}

protocol CourseViewProtocol: CourseViewDataSource, CourseViewEventSource {}

final class CourseViewModel: BaseViewModel, CourseViewProtocol {
    var cellItems: [CourseCellViewModel] = []

    override init() {
        super.init()
        fetchRegisteredCourses()
    }

    /// Fetches the registered courses for the current user.
    func fetchRegisteredCourses() {
        let courses = CourseManager.shared.currentUserCourses
        self.cellItems = courses.map { CourseCellViewModel(course: $0) }
    }
    
    /// - Parameter section: The section index.
    /// - Returns: The number of items in the section.
    func numberOfItemsAt(section: Int) -> Int {
        return cellItems.count
    }
    
    /// - Parameter indexPath: The index path of the cell.
    /// - Returns: The `CourseCellViewModel` for the cell.
    func cellItemAt(indexPath: IndexPath) -> CourseCellViewModel {
        return cellItems[indexPath.row]
    }
}
