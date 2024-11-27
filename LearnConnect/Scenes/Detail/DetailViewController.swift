//
//  DetailViewController.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 23.11.2024.
//

import UIKit

class DetailViewController: BaseViewController<DetailViewModel> {

    //MARK: - Properties
    private lazy var statementView = StatementView()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(LessonCell.self, forCellWithReuseIdentifier: LessonCell.identifier)
        collectionView.backgroundColor = .appBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationConfigure()
        addSubViews()
        contentConfigure()
        statementView.configure(with: viewModel.course.description)
    }
    
    private func contentConfigure(){
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func navigationConfigure() {
        view.backgroundColor = .appBackground
        navigationItem.title = viewModel.course.name
        
        // Download Button
        let downloadButton = UIBarButtonItem(image: UIImage(systemName: "arrow.down.to.line"), style: .plain, target: self, action: #selector(didTapDownloadButton))
        navigationItem.rightBarButtonItem = downloadButton
    }
    
    @objc private func didTapDownloadButton() {
        let downloadVC = DownloadViewController(viewModel: DownloadViewModel())
        navigationController?.pushViewController(downloadVC, animated: true)
    }
}

//MARK: - UILayout
extension DetailViewController{
    private func addSubViews(){
        addStatementView()
        addCollectionView()
    }
    
    private func addStatementView() {
        view.addSubview(statementView)
        statementView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(100)
        }
    }
    
    private func addCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(statementView.snp.bottom).offset(10)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.course.lessons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LessonCell.identifier, for: indexPath) as? LessonCell else {
            return UICollectionViewCell()
        }
        
        let lesson = viewModel.course.lessons[indexPath.item]
        cell.configure(with: lesson)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing: CGFloat = 40
        let width = (collectionView.frame.width - totalSpacing)
        return CGSize(width: width, height: 340)
    }
}
