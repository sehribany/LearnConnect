//
//  APIRequest.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 22.11.2024.
//

import Alamofire

// MARK: - APIRequest
enum APIRequest: RequestProtocol {
    case getCourse
    
    var path: String {
        switch self {
        case .getCourse: return APIEndpoint.course.rawValue
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .getCourse : return .get
        }
    }
    
    var parameters: [String: Any] {
        return [:]
    }
    
    var headers: [String: String] {
        return ["Content-Type": "application/json"]
    }
    
    var encoding: RequestEncoding {
        return .url
    }
        
    var url: String {
        return APIConstants.baseURL + path
    }
}
