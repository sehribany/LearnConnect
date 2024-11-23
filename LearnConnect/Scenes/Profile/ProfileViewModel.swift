//
//  ProfileViewModel.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 22.11.2024.
//

import Foundation

protocol ProfileViewDataSource{}

protocol ProfileViewEventSource{}

protocol ProfileViewProtocol: ProfileViewDataSource, ProfileViewEventSource{}

final class ProfileViewModel: BaseViewModel, ProfileViewProtocol{}

