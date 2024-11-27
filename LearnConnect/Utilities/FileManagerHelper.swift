//
//  FileManagerHelper.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 27.11.2024.
//

import Foundation

extension FileManager {
    func getDocumentsDirectory() -> URL {
        return urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
