//
//  IntroViewModel.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 21.11.2024.
//

import Foundation
import UIKit

protocol IntroViewDataSource{
    func numberOfItemsAt(section:Int) -> Int
    func cellItemAt(indexPath: IndexPath) -> IntroCellProtocol
}

protocol IntroViewEventSource{}

protocol IntroViewProtocol: IntroViewDataSource, IntroViewEventSource{}

final class IntroViewModel: BaseViewModel, IntroViewProtocol{
    
    private var cellItems : [IntroCellProtocol] = [IntroCellViewModel(image: UIImage(named: "imgIntro1") ?? UIImage(),
                                                                  titleText: localizedString("Intro.firstTitle"),
                                                                  descriptionText: localizedString("Intro.descriptionText1")),
                                                   IntroCellViewModel(image: UIImage(named: "imgIntro2") ?? UIImage(),
                                                                titleText: localizedString("Intro.secondTitle"),
                                                                descriptionText: localizedString("Intro.descriptionText2")),
                                                   IntroCellViewModel(image: UIImage(named: "imgIntro3") ?? UIImage(),
                                                                titleText: localizedString("Into.thirdTitle"),
                                                                descriptionText: localizedString("Intro.descriptionText3"))]
    
    func numberOfItemsAt(section: Int) -> Int {
        cellItems.count
    }
    
    func cellItemAt(indexPath: IndexPath) -> IntroCellProtocol {
        cellItems[indexPath.row]
    }
}
