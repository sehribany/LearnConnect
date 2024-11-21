//
//  IntroViewController.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 21.11.2024.
//

import UIKit
import SnapKit

class IntroViewController: BaseViewController<IntroViewModel> {
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.tintColor = .blue
        pageControl.pageIndicatorTintColor = .appPaginationOff
        pageControl.currentPageIndicatorTintColor = .appPaginationOn
        pageControl.numberOfPages = 3
        pageControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        return pageControl
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.register(IntroCell.self, forCellWithReuseIdentifier: IntroCell.identifier)
        collectionView.showsVerticalScrollIndicator   = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .appButtonBackground1
        button.setTitle(localizedString("Register.register"), for: .normal)
        button.tintColor = .appButtonTitle1
        button.layer.cornerRadius = 9
        button.titleLabel?.font  = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.isHidden = true
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .appButtonBackground2
        button.setTitle(localizedString("Login.login"), for: .normal)
        button.tintColor = .appButtonTitle2
        button.layer.cornerRadius = 9
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.appButtonBackground1.cgColor
        button.titleLabel?.font  = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.isHidden = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        contentConfigure()
    }
}

//MARK: - UILayout
extension IntroViewController{

    private func addSubView() {
        view.backgroundColor = .appBackground
        navigationController?.navigationBar.isHidden = true
        addCollectionView()
        addPageControl()
        addRegisterButton()
        addLoginButton()
    }
        
    private func addPageControl() {
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(-120)
            make.centerX.equalToSuperview()
        }
    }
        
    private func addCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-150)
        }
    }
    
    private func addRegisterButton(){
        view.addSubview(registerButton)
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(50)
            make.width.equalTo(160)
        }
        
    }
    
    private func addLoginButton(){
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
            make.width.equalTo(160)
        }
        
    }
}
//MARK: -Configuration
extension IntroViewController{
    private func contentConfigure(){
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}
//MARK: - UICollectionViewDataSource
extension IntroViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsAt(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IntroCell.identifier, for: indexPath) as! IntroCell
        let cellItem = viewModel.cellItemAt(indexPath: indexPath)
        cell.set(viewModel: cellItem)
        return cell
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension IntroViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        guard width != 0 else { return }
        pageControl.currentPage = Int(scrollView.contentOffset.x / width)
        if pageControl.currentPage == viewModel.numberOfItemsAt(section: 0) - 1 {
            registerButton.isHidden = false
            loginButton.isHidden = false
        } else {
            registerButton.isHidden = true
            loginButton.isHidden = true
        }
    }
}
// MARK: -Actions
extension IntroViewController {
    @objc
    private func nextButtonTapped() {
        if pageControl.currentPage == viewModel.numberOfItemsAt(section: 0) - 1 {
            //let loginViewController = LoginViewController(viewModel: LoginViewModel())
            //loginViewController.modalPresentationStyle = .fullScreen
            //present(loginViewController, animated: true, completion: nil)
        } else {
            pageControl.currentPage += 1
            let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}
