//
//  String+Extensions.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 27.11.2024.
//

extension String {
    static func videoProgressKey(for lessonID: String) -> String {
        return "videoProgress_\(lessonID)"
    }
}

