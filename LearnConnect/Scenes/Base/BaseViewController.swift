//
//  BaseViewController.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 21.11.2024.
//

import UIKit

class BaseViewController<V: BaseViewProtocol>: UIViewController {
    
    // MARK: - Properties
    var viewModel: V
    
    // MARK: - Initializer
    init(viewModel: V) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToast()
    }
    
    // MARK: - Toast Functionality
    private func subscribeToast() {
        viewModel.showWarningToast = { text in
            ToastPresenter.showWarningToast(text: text)
        }
    }
    
    func showWarningToast(message: String) {
        ToastPresenter.showWarningToast(text: message)
    }
}

// MARK: - Navigation Bar Customization
extension BaseViewController {
    
}
