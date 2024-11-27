//
//  DownloadViewModel.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 27.11.2024.
//

import Foundation

protocol DownloadViewDataSource{}
    
protocol DownloadViewEventSource{}

protocol DownloadViewProtocol: DownloadViewDataSource, DownloadViewEventSource{}

final class DownloadViewModel: BaseViewModel, DownloadViewProtocol {
    
    // MARK: - Properties
    private(set) var downloadedVideos: [String] = []
    
    // MARK: - Fetch Downloaded Videos
    func fetchDownloadedVideos() {
        downloadedVideos = UserDefaults.standard.downloadedVideos()
    }
    
    // MARK: - Delete Video
    func deleteDownloadedVideo(at index: Int) {
        guard index >= 0 && index < downloadedVideos.count else { return }
        
        let videoName = downloadedVideos[index]
        let fileURL = FileManager.default.getDocumentsDirectory().appendingPathComponent(videoName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
            downloadedVideos.remove(at: index)
            
            // Güncellenmiş listeyi UserDefaults'ta sakla
            UserDefaults.standard.set(downloadedVideos, forKey: UserDefaults.downloadedVideosKey)
        } catch {
            print("Dosya silme hatası: \(error.localizedDescription)")
        }
    }
}

