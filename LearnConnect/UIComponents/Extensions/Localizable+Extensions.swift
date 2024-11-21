//
//  Localizable+Extensions.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 21.11.2024.
//

import Foundation

func localizedString(_ key: String) -> String {
    return NSLocalizedString(key, tableName: "Localizable", bundle: .main, value: "", comment: "")
}

