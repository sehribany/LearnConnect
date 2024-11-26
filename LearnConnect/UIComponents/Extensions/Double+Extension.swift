//
//  Double+Extension.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 26.11.2024.
//

import Foundation

extension Double {
    /// Formats the time value (in seconds) to "MM:SS".
    /// - Returns: A string representing the formatted time.
    func formatToTimeString() -> String {
        guard !self.isNaN && !self.isInfinite else { return "00:00" }
        let totalSeconds = Int(self)
        let minutes = totalSeconds / 60
        let remainingSeconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
}

