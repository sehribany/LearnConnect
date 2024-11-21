//
//  IntroCellViewModel.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 21.11.2024.
//

import UIKit

protocol IntroCellDataSource: AnyObject{
    var image          : UIImage {get}
    var titleText      : String {get}
    var descriptionText: String {get}
}

protocol IntroCellEventSource: AnyObject {}

protocol IntroCellProtocol: IntroCellDataSource, IntroCellEventSource {}

final class IntroCellViewModel: IntroCellProtocol{
    var image          : UIImage
    var titleText      : String
    var descriptionText: String
    
    init(image: UIImage, titleText: String, descriptionText: String) {
        self.image           = image
        self.titleText       = titleText
        self.descriptionText = descriptionText
    }
}
