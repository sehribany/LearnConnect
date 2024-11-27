//
//  HomeViewController.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 21.11.2024.
//
import UIKit

class HomeViewController: BaseViewController<HomeViewModel> {
    
    // MARK: - Properties
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CourseCell.self, forCellWithReuseIdentifier: CourseCell.identifier)
        collectionView.backgroundColor = .appBackground
        collectionView.showsVerticalScrollIndicator   = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        contentConfigure()
        viewModel.fetchCourse()
        bindViewModel()
    }
    
    private func contentConfigure(){
        NotificationCenter.default.addObserver(self, selector: #selector(courseDeleted(_:)), name: NSNotification.Name("CourseDeleted"), object: nil)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func bindViewModel() {
        viewModel.didSuccessFetchCourse = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    @objc private func courseDeleted(_ notification: Notification) {
        guard notification.object is Course else { return }
        collectionView.reloadData()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - UILayout
extension HomeViewController {
    private func addSubView() {
        view.backgroundColor = .appBackground
        addCollectionView()
    }
        
    private func addCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.bottom.top.leading.trailing.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsAt(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CourseCell.identifier, for: indexPath) as! CourseCell
        let cellItem = viewModel.cellItemAt(indexPath: indexPath)
        cell.set(viewModel: cellItem)
        cell.delegate = self
        
        let isRegistered = CourseManager.shared.currentUserCourses.contains { $0.id == cellItem.course.id }
        cell.updateRegisterButtonState(isRegistered: isRegistered)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
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
        let totalSpacing = 40
        let width = (collectionView.frame.width - CGFloat(totalSpacing))
        return CGSize(width: width, height: 320)
    }
}

// MARK: - CourseCellDelegate
extension HomeViewController: CourseCellDelegate {
    func didTapToCourseImageView(course: Course) {
        let detailViewModel = DetailViewModel(course: course)
        let detailVC = DetailViewController(viewModel: detailViewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func didTapRegisterButton(course: Course) {
        guard !CourseManager.shared.currentUserCourses.contains(where: { $0.id == course.id }) else {
            return
        }
        CourseManager.shared.addCourse(course)
        collectionView.reloadData()
    }
}
