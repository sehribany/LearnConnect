//
//  CourseViewModel.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 22.11.2024.
//

import Foundation

protocol CourseViewDataSource{}

protocol CourseViewEventSource{}

protocol CourseViewProtocol: CourseViewDataSource, CourseViewEventSource{}

final class CourseViewModel: BaseViewModel, CourseViewProtocol{}

