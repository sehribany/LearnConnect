//
//  CourseCellViewModel.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 22.11.2024.
//

import Foundation
import UIKit

protocol CourseCellDataSource: AnyObject{
    var course: Course {get}
}

protocol CourseCellEventSource: AnyObject{}

protocol CourseCellProtocol: CourseCellDataSource, CourseCellEventSource{}

final class CourseCellViewModel: BaseViewModel, CourseCellProtocol{
    var course: Course
    
    init(course: Course) {
        self.course = course
    }
}
