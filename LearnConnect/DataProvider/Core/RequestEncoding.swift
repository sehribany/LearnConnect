//
//  RequestEncoding.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 22.11.2024.
//

import Alamofire

//MARK: -RequestEncoding
enum RequestEncoding {
    case url
    case json
}

// MARK: - Get Alamofire ParameterEncoding
extension RequestEncoding {
    var toAlamofireEncoding: ParameterEncoding {
        switch self {
        case .json: return JSONEncoding.default
        case .url : return URLEncoding.default
        }
    }
}
