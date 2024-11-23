//
//  RequestManager.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 22.11.2024.
//

import Alamofire

// MARK: - Request Manager
class RequestManager {
    
    static let shared = RequestManager()
    
    private init() { }
    
    func performRequest<T: Decodable>(request: RequestProtocol, completion: @escaping (Result<T, Error>) -> Void) {
        let url = request.url
        let method = request.method.toAlamofireHTTPMethod
        let parameters = request.parameters
        let headers = HTTPHeaders(request.headers)
        let encoding = request.encoding.toAlamofireEncoding
        
        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseDecodable(of: T.self) { response in
            
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
