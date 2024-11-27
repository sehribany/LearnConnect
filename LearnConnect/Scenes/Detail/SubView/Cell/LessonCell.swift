//
//  LessonCell.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 23.11.2024.
//

import UIKit
import AVKit
import SnapKit

// MARK: - LessonCell: UICollectionViewCell
class LessonCell: UICollectionViewCell {

    // MARK: - Static Properties
    static let identifier: String = "LessonCell"

    // MARK: - UI Components
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appText
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()

    private lazy var playerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var playerLayer: AVPlayerLayer = {
        let layer = AVPlayerLayer()
        layer.videoGravity = .resizeAspect
        return layer
    }()
    
    private lazy var playPauseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.circle"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator: UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            indicator = UIActivityIndicatorView(style: .large)
        } else {
            indicator = UIActivityIndicatorView(style: .whiteLarge)
        }
        indicator.hidesWhenStopped = true
        indicator.color = .white
        return indicator
    }()
    
    private lazy var progressSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0
        slider.addTarget(self, action: #selector(progressSliderChanged(_:)), for: .valueChanged)
        return slider
    }()
    
    private lazy var currentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .appText
        return label
    }()
    
    private lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .appText
        return label
    }()
    
    private lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .appText
        label.textAlignment = .left
        label.text = "Last watched: 00:00"
        return label
    }()

    // MARK: - Player Properties
    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    private var isPlayerReady = false
    private var timeObserverToken: Any?
    private var progressSaveTimer: Timer?

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        configureSetUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = playerView.bounds
    }

    // MARK: - Prepare for Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        saveCurrentProgress()
        progressSaveTimer?.invalidate()
        cleanupPlayer()
    }

    private func cleanupPlayer() {
        player?.pause()
        playerLayer.player = nil
        playPauseButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        isPlayerReady = false

        if let currentItem = playerItem {
            currentItem.removeObserver(self, forKeyPath: "status")
        }
        playerItem = nil

        if let token = timeObserverToken {
            player?.removeTimeObserver(token)
            timeObserverToken = nil
        }
    }

    // MARK: - Configure Player
    func configure(with lesson: Lesson) {
        titleLabel.text = lesson.name
        guard let videoURL = URL(string: lesson.video) else {
            return
        }
        setupPlayer(with: videoURL)
        updateProgressLabel(for: videoURL)
    }
    
    private func updateProgressLabel(for videoURL: URL) {
        let videoURLString = videoURL.absoluteString
        let savedProgress = UserDefaults.standard.getVideoProgress(for: videoURLString)
        progressLabel.text = "Last watched: \(savedProgress.formatToTimeString())"
    }

    private func setupPlayer(with url: URL) {
        cleanupPlayer()
        activityIndicator.startAnimating()
        playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        playerLayer.player = player
        loadSavedProgress(for: url)
        guard let currentItem = playerItem else { return }
        currentItem.addObserver(self, forKeyPath: "status", options: [.new, .initial], context: nil)
        addPeriodicTimeObserver()
    }
    
    private func saveCurrentProgress() {
        guard let player = player, let currentItem = player.currentItem else {
            return
        }
        let currentTime = player.currentTime().seconds
        guard let videoURL = (currentItem.asset as? AVURLAsset)?.url.absoluteString else {
            print("Video URL alınamadı")
            return
        }
        UserDefaults.standard.saveVideoProgress(for: videoURL, progress: currentTime)
    }
    
    private func loadSavedProgress(for url: URL) {
        let videoURLString = url.absoluteString
        let savedProgress = UserDefaults.standard.getVideoProgress(for: videoURLString)
        guard savedProgress > 0 else {
            return
        }
        let seekTime = CMTime(seconds: savedProgress, preferredTimescale: 600)
        player?.seek(to: seekTime, toleranceBefore: .zero, toleranceAfter: .zero)
    }
    
    // MARK: - KVO for Player Status
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" {
            DispatchQueue.main.async {
                guard let currentItem = self.playerItem else { return }
                switch currentItem.status {
                case .readyToPlay:
                    self.isPlayerReady = true
                    self.activityIndicator.stopAnimating()
                    if currentItem.duration.isValid, !currentItem.duration.isIndefinite {
                        let duration = currentItem.duration.seconds
                        if duration > 0 {
                            self.progressSlider.value = 0
                            self.durationLabel.text = duration.formatToTimeString()
                        }
                    }
                case .failed:
                    self.isPlayerReady = false
                    self.activityIndicator.stopAnimating()
                case .unknown:
                    self.isPlayerReady = false
                    self.activityIndicator.startAnimating()
                @unknown default:
                    self.isPlayerReady = false
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }

    private func addPeriodicTimeObserver() {
        guard let player = player else { return }
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            guard let self = self, let currentItem = player.currentItem else { return }
            let duration = currentItem.duration.seconds
            let currentTime = time.seconds
            if duration > 0 {
                self.progressSlider.value = Float(currentTime / duration)
                self.currentTimeLabel.text = currentTime.formatToTimeString()
                self.durationLabel.text = duration.formatToTimeString()
            }
        }
    }
    
    // MARK: - Play/Pause
    @objc private func playPauseButtonTapped() {
        guard let player = player else { return }
        if isPlayerReady {
            if player.timeControlStatus == .playing {
                player.pause()
                playPauseButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
                progressSaveTimer?.invalidate()
            } else {
                player.play()
                playPauseButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
                startProgressSaveTimer()
            }
        } else {
            activityIndicator.startAnimating()
        }
    }
    
    private func startProgressSaveTimer() {
        progressSaveTimer?.invalidate()
        progressSaveTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            self?.saveCurrentProgress()
        }
    }

    @objc private func progressSliderChanged(_ sender: UISlider) {
        guard let player = player else { return }
        guard let currentItem = player.currentItem else { return }
        let duration = currentItem.duration.seconds
        if duration.isFinite && duration > 0 {
            let newTime = Double(sender.value) * duration
            let seekTime = CMTime(seconds: newTime, preferredTimescale: 600)
            player.seek(to: seekTime)
        }
    }
}

// MARK: - UILayout and ConfigureSetUp
extension LessonCell {
    private func addSubViews() {
        addTitle()
        addPlayerView()
        addPlayPauseButton()
        addActivityIndicator()
        addProgressSlider()
        addTimeLabels()
        addProgressLabel()
    }
    
    private func addTitle() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    private func addPlayerView() {
        contentView.addSubview(playerView)
        playerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(playerView.snp.width).multipliedBy(0.56)
        }
        playerView.layer.addSublayer(playerLayer)
    }
    
    private func addPlayPauseButton() {
        playerView.addSubview(playPauseButton)
        playPauseButton.snp.makeConstraints { make in
            make.center.equalTo(playerView)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
    }
    
    private func addActivityIndicator() {
        playerView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(playerView)
        }
    }
    
    private func addProgressSlider() {
        contentView.addSubview(progressSlider)
        progressSlider.snp.makeConstraints { make in
            make.top.equalTo(playerView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    private func addTimeLabels() {
        contentView.addSubview(currentTimeLabel)
        contentView.addSubview(durationLabel)
        
        currentTimeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(progressSlider.snp.bottom).offset(5)
        }
        
        durationLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.top.equalTo(progressSlider.snp.bottom).offset(5)
        }
    }
    
    private func addProgressLabel() {
        contentView.addSubview(progressLabel)
        progressLabel.snp.makeConstraints { make in
            make.top.equalTo(currentTimeLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(10)
        }
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
