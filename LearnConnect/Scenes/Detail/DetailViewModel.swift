//
//  DetailViewModel.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 23.11.2024.
//

import Foundation

protocol DetailViewDataSource{
    var course: Course {get}
}
    
protocol DetailViewEventSource{}

protocol DetailViewProtocol: DetailViewDataSource, DetailViewEventSource{}

final class DetailViewModel: BaseViewModel, DetailViewProtocol{
    var course: Course
    
    init(course: Course) {
        self.course = course
    }
}
