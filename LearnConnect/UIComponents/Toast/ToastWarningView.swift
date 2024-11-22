//
//  ToastWarningView.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 21.11.2024.
//

import UIKit
import SnapKit

class ToastWarningView: UIView {
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .appTitle
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    init(text: String) {
        super.init(frame: .zero)
        label.text = text
        configureContents()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureContents() {
        addSubview(label)

        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}
