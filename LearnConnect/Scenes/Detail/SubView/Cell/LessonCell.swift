//
//  LessonCell.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 23.11.2024.
//

import UIKit
import AVKit

class LessonCell: UICollectionViewCell {

    static var identifier: String = "LessonCell"

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()

    private var player: AVPlayer?
    private lazy var playerLayer: AVPlayerLayer = {
        let layer = AVPlayerLayer()
        layer.cornerRadius = 8
        layer.videoGravity = .resizeAspect
        return layer
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        configureSetUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UILayout
extension LessonCell {
    private func addSubViews() {
        addTitle()
        addPlayerView()
    }

    private func addTitle() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
    }

    private func addPlayerView() {
        contentView.layer.addSublayer(playerLayer)
        // PlayerLayer konumlandırma
        playerLayer.frame = CGRect(
            x: 10,
            y: titleLabel.frame.height + 10,
            width: contentView.frame.width - 20,
            height: (contentView.frame.width - 20) * 0.56
        )
    }
}

// MARK: - Configure and Set Localize
extension LessonCell {

    func configure(with lesson: Lesson) {
        titleLabel.text = lesson.name
        guard let videoURL = URL(string: lesson.video) else {
            print("Video URL geçersiz: \(lesson.video)")
            return
        }
        configurePlayer(with: videoURL)
    }

    private func configurePlayer(with url: URL) {
        // Eski player'ı temizle
        player?.pause()
        playerLayer.player = nil

        // Yeni player oluştur
        player = AVPlayer(url: url)
        playerLayer.player = player
        player?.play() // Otomatik oynatma
    }

    private func configureSetUp() {
        contentView.backgroundColor = .appBackground3
        contentView.layer.cornerRadius = 10
        layer.shadowColor = UIColor.appCellShadow.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowRadius = 10
        layer.masksToBounds = false
    }
}
