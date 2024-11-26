//
//  CourseCell.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 22.11.2024.
//

import UIKit

protocol CourseCellDelegate: AnyObject {
    func didTapToCourseImageView(course: Course)
    func didTapRegisterButton(course: Course)
}

class CourseCell: UICollectionViewCell {
    
    //MARK: - Properties
    static var identifier: String = "CourseCell"
    
    private lazy var imageView: UIImageView = {
        let image           = UIImageView()
        image.contentMode   = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label           = UILabel()
        label.textColor     = .appTitle
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font          = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var toCourseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icGo")
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label             = UILabel()
        label.textColor       = .appCategoryTitle
        label.backgroundColor = .appCategory
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font          = UIFont.systemFont(ofSize: 16, weight: .light)
        label.sizeToFit()
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.sizeToFit()
        return label
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(localizedString("RegisterButton.Register"), for: .normal)
        button.setTitleColor(.appRegisterTitle, for: .normal)
        button.backgroundColor = UIColor.appRegisterButton
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .light)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()

    weak var delegate : CourseCellDelegate?
    weak var viewModel:  CourseCellProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        addSubViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - IULayout
extension CourseCell{
    private func addSubViews(){
        addImageView()
        addTitleLabel()
        addToCourseImageView()
        addCategoryLabel()
        addRegisterButton()
    }
    
    private func addImageView(){
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview()
            make.height.equalTo(220)
        }
    }
    
    private func addTitleLabel(){
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    private func addToCourseImageView() {
        contentView.addSubview(toCourseImageView)
        toCourseImageView.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().offset(-10)
            make.height.width.equalTo(32)
        }
    }
    
    private func addCategoryLabel() {
        contentView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(20)
        }
    }
    
    private func addRegisterButton() {
        contentView.addSubview(registerButton)
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(categoryLabel.snp.trailing).offset(10)
            make.height.equalTo(20)
            make.width.equalTo(85)
        }
    }
}

// MARK: - Configure and Set Localize
extension CourseCell{
    func set(viewModel: CourseCellProtocol) {
        self.viewModel = viewModel
        let course = viewModel.course
        imageView.setImage(course.image)
        titleLabel.text = course.name
        categoryLabel.text = "  \(course.category.rawValue)  "
    }
    
    private func configure(){
        contentView.backgroundColor = .appBackground3
        contentView.layer.cornerRadius = 10
        layer.shadowColor = UIColor.appCellShadow.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowRadius = 10
        layer.masksToBounds = false
        setupGestureRecognizers()
    }

    // MARK: - Gesture Recognizer
    private func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toCourseImageViewTapped))
        toCourseImageView.addGestureRecognizer(tapGesture)
    }
    
    func updateRegisterButtonState(isRegistered: Bool) {
        registerButton.setTitle(isRegistered ?  localizedString("RegisterButton.Registered") : localizedString("RegisterButton.Register"), for: .normal)
        registerButton.isEnabled = !isRegistered
        registerButton.backgroundColor = isRegistered ? .lightGray : .appRegisterButton
    }

    @objc private func toCourseImageViewTapped() {
        guard let course = viewModel?.course else { return }
        delegate?.didTapToCourseImageView(course: course)
    }

    @objc private func registerButtonTapped() {
        guard let course = viewModel?.course else { return }
        delegate?.didTapRegisterButton(course: course)
    }
}
