//
//  RequestProtocol.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 22.11.2024.
//

import Foundation

//MARK: -RequestProtocol
protocol RequestProtocol{
    var path       : String{ get }
    var method     : RequestMethod { get }
    var parameters : [String: Any] { get }
    var headers    : [String: String] { get }
    var encoding   : RequestEncoding { get }
    var url        : String { get }
}
