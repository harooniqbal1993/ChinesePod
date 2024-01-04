//
//  HomeViewModel.swift
//  ChinesePod
//
//  Created by Haroon Iqbal on 26/12/2023.
//

import Foundation

class HomeViewModel {
//    var lessons
//    var courses
    var showQuickTags: Bool = false
    
    func getLessons() {
        NetworkService.shared.getLessons { result, error in
            print(result)
        }
    }
}
