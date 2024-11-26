//
//  IntroCell.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 21.11.2024.
//

import UIKit
import SnapKit

class IntroCell: UICollectionViewCell {
    
    static var identifier: String = "IntroCell"
    //MARK: - Properties
    private lazy var imageView: UIImageView = {
        let image         = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label           = UILabel()
        label.textColor     = .appTitle
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font          = UIFont.systemFont(ofSize: 25, weight: .semibold)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label           = UILabel()
        label.textColor     = .appText
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font          = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    weak var viewModel: IntroCellProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .appBackground
        addSubViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func set(viewModel: IntroCellProtocol){
        self.viewModel        = viewModel
        imageView.image       = viewModel.image
        titleLabel.text       = viewModel.titleText
        descriptionLabel.text = viewModel.descriptionText
    }
}

//MARK: -IULayout
extension IntroCell{
    private func addSubViews(){
        addImageView()
        addTitleLabel()
        addDescriptionLabel()
    }
    
    private func addImageView(){
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(260)
        }
    }
    
    private func addTitleLabel(){
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(70)
        }
    }
    
    private func addDescriptionLabel(){
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(70)
        }
    }
}
