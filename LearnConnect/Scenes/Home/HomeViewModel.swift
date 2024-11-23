//
//  HomeViewModel.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 21.11.2024.
//

import Foundation

protocol HomeViewDataSource{
    func numberOfItemsAt(section:Int) -> Int
    func cellItemAt(indexPath: IndexPath) -> CourseCellProtocol
}
    
protocol HomeViewEventSource{
    var didSuccessFetchCourse: VoidClosure? { get set }
    var didFailWithError: StringClosure?     { get set }
    var didSelectCourse: ((Course) -> Void)? { get set }
}

protocol HomeViewProtocol: HomeViewDataSource, HomeViewEventSource{}

final class HomeViewModel: BaseViewModel, HomeViewProtocol{
    var didSuccessFetchCourse: VoidClosure?
    var didFailWithError: StringClosure?
    var didSelectCourse: ((Course) -> Void)?
    
    var cellItems : [CourseCellViewModel] = []
    private let courseService = CourseService()
    private var allCourses: [Course] = []
    
    func numberOfItemsAt(section: Int) -> Int {
        return cellItems.count
    }
    
    func cellItemAt(indexPath: IndexPath) -> any CourseCellProtocol {
        return cellItems[indexPath.row]
    }
}

// MARK: - Fetching Course
extension HomeViewModel{

    func fetchCourse() {
        courseService.fetchCourse { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let courses):
                self.allCourses = courses
                self.cellItems = courses.map { CourseCellViewModel(course: $0) }
                self.didSuccessFetchCourse?()
            case .failure(let error):
                self.didFailWithError?(error.localizedDescription)
            }
        }
    }
}
