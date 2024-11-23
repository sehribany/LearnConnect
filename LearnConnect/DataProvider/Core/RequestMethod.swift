//
//  RequestMethod.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 22.11.2024.
//

import Alamofire

//MARK: - RequestMethod
enum RequestMethod {
    case connect
    case delete
    case get
    case head
    case options
    case patch
    case post
    case put
    case trace
}

// MARK: - Get Alamofire HTTPMethod
extension RequestMethod{
    var toAlamofireHTTPMethod: HTTPMethod {
        switch self {
        case .connect: return .connect
        case .delete : return .delete
        case .get    : return .get
        case .head   : return .head
        case .options: return .options
        case .patch  : return .patch
        case .post   : return .post
        case .put    : return .put
        case .trace  : return .trace
        }
    }
}
