//
//  BaseViewModel.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 21.11.2024.
//

import Foundation

protocol BaseViewDataSource: AnyObject {}

// MARK: - Closures for various view events
protocol BaseViewEventSource:AnyObject {
    var showActivityIndicatorView: VoidClosure? {get set}
    var hideActivityIndicatorView: VoidClosure? {get set}
    var showLoading              : VoidClosure? {get set}
    var hideLoading              : VoidClosure? {get set}
    var showWarningToast         : StringClosure? {get set}
}

protocol BaseViewProtocol: BaseViewDataSource, BaseViewEventSource {}

class BaseViewModel: BaseViewProtocol  {
    
    // MARK: - Properties
    var showActivityIndicatorView: VoidClosure?
    var hideActivityIndicatorView: VoidClosure?
    var showLoading              : VoidClosure?
    var hideLoading              : VoidClosure?
    var showWarningToast         : StringClosure?
}
