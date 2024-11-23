//
//  APIEndpoint.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 22.11.2024.
//

import Foundation

// MARK: - APIEndpoint
enum APIEndpoint {
    case course
    
    var rawValue: String {
        switch self {
        case .course :
            return "/course"
        }
    }
    
    func url() -> String {
        return APIConstants.baseURL + self.rawValue
    }
}
