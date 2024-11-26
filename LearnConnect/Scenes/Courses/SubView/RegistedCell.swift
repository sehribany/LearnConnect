//
//  RegistedCell.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 26.11.2024.
//

import UIKit

protocol RegistedCellDelegate: AnyObject {
    func didTapToCourseImageView(course: Course)
}

class RegistedCell: UITableViewCell {
    static var identifier: String = "RegistedTableCell"
    
    //MARK: - Properties
    private lazy var courseImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appTitle
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appCategoryTitle
        label.backgroundColor = .appCategory
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
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
    
    weak var viewModel: CourseCellProtocol?
    weak var delegate : RegistedCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        addSubViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - IULayout
extension RegistedCell{
    private func addSubViews(){
        addImageView()
        addTitleLabel()
        addCategoryLabel()
        addToCourseImageView()
    }
    
    private func addImageView(){
        contentView.addSubview(courseImageView)
        courseImageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(10)
            make.width.equalTo(80)
        }
    }
    
    private func addTitleLabel(){
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(courseImageView.snp.trailing).offset(10)
            make.top.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().offset(-5)
        }
    }
    private func addCategoryLabel() {
        contentView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(courseImageView.snp.trailing).offset(10)
            make.height.equalTo(20)
        }
    }
    
    private func addToCourseImageView() {
        contentView.addSubview(toCourseImageView)
        toCourseImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.trailing.equalToSuperview().inset(10)
            make.height.width.equalTo(32)
        }
    }
}
// MARK: - Configure and Set Localize
extension RegistedCell{
    func set(viewModel: CourseCellProtocol) {
        self.viewModel = viewModel
        let course = viewModel.course
        courseImageView.setImage(course.image)
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

    @objc private func toCourseImageViewTapped() {
        guard let course = viewModel?.course else { return }
        delegate?.didTapToCourseImageView(course: course)
    }
}
