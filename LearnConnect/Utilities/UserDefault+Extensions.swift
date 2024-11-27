//
//  UserDefault+Extensions.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 27.11.2024.
//

import Foundation

extension UserDefaults {
    private enum Keys {
        static let videoProgress = "videoProgress"
    }
    
    func saveVideoProgress(for videoID: String, progress: Double) {
        var progressData = dictionary(forKey: Keys.videoProgress) as? [String: Double] ?? [:]
        progressData[videoID] = progress
        set(progressData, forKey: Keys.videoProgress)
    }
    
    func getVideoProgress(for videoID: String) -> Double {
        let progressData = dictionary(forKey: Keys.videoProgress) as? [String: Double] ?? [:]
        return progressData[videoID] ?? 0
    }
}


extension UserDefaults {
    static let downloadedVideosKey = "DownloadedVideos"

    func saveDownloadedVideo(_ videoName: String) {
        var downloadedVideos = self.downloadedVideos()
        downloadedVideos.append(videoName)
        set(downloadedVideos, forKey: UserDefaults.downloadedVideosKey)
    }

    func downloadedVideos() -> [String] {
        return array(forKey: UserDefaults.downloadedVideosKey) as? [String] ?? []
    }
}
