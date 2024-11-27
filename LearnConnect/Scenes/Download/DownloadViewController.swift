//
//  DownloadViewController.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 27.11.2024.
//

import UIKit
import AVKit

class DownloadViewController: BaseViewController<DownloadViewModel> {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .appBackground
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = localizedString("Download.download")
        view.backgroundColor = .appBackground
        setupViews()
        viewModel.fetchDownloadedVideos()
        tableView.reloadData()
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension DownloadViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.downloadedVideos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = viewModel.downloadedVideos[indexPath.row]
        cell.textLabel?.textColor = .appTitle
        cell.backgroundColor = .appBackground3
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let videoName = viewModel.downloadedVideos[indexPath.row]
        let fileURL = FileManager.default.getDocumentsDirectory().appendingPathComponent(videoName)
        
        let player = AVPlayer(url: fileURL)
        let playerVC = AVPlayerViewController()
        playerVC.player = player
        present(playerVC, animated: true) {
            player.play()
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteDownloadedVideo(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
