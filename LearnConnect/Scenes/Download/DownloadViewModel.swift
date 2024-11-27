//
//  DownloadViewModel.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 27.11.2024.
//

import Foundation

protocol DownloadViewDataSource{
    var downloadedVideos: [String] { get }
    func fetchDownloadedVideos()
}
    
protocol DownloadViewEventSource{
    func deleteDownloadedVideo(at index: Int)
}

protocol DownloadViewProtocol: DownloadViewDataSource, DownloadViewEventSource{}

final class DownloadViewModel: BaseViewModel, DownloadViewProtocol {
    
    private(set) var downloadedVideos: [String] = []
    
    func fetchDownloadedVideos() {
        downloadedVideos = UserDefaults.standard.downloadedVideos()
    }
    
    func deleteDownloadedVideo(at index: Int) {
        guard index >= 0 && index < downloadedVideos.count else { return }
        
        let videoName = downloadedVideos[index]
        let fileURL = FileManager.default.getDocumentsDirectory().appendingPathComponent(videoName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
            downloadedVideos.remove(at: index)
            UserDefaults.standard.set(downloadedVideos, forKey: UserDefaults.downloadedVideosKey)
        } catch {
            print("Dosya silme hatası: \(error.localizedDescription)")
        }
    }
}
