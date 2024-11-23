//
//  ProductService.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 22.11.2024.
//

import Foundation

// MARK: - Product Service
class CourseService{
    func fetchCourse(completion: @escaping (Result<[Course], Error>) -> Void) {
        RequestManager.shared.performRequest(request: APIRequest.getCourse) { (result: Result<[Course], Error>) in
            completion(result)
        }
    }
}
