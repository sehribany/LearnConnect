//
//  StatementView.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 23.11.2024.
//

import UIKit
import SnapKit

class StatementView: UIView {
    
    //MARK: - Properties
    private lazy var descriptinLabel: UILabel = {
        let label = UILabel()
        label.textColor     = .appTitle
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font          = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with description: String) {
        descriptinLabel.text = description
        layoutIfNeeded()
    }
}

//MARK: -UILayout
extension StatementView{
    private func addSubView(){
        self.setupUI()
        addDescLabel()
    }
    
    private func addDescLabel(){
        addSubview(descriptinLabel)
        descriptinLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview().inset(5)
        }
    }
    
    private func setupUI(){
        backgroundColor = UIColor.appBackground3
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.appPaginationOn.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowRadius = 10
        layer.masksToBounds = false
    }
}
