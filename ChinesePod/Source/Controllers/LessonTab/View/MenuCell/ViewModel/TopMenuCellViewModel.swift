//
//  TopMenuViewModel.swift
//  ChinesePod
//
//  Created by Haroon Iqbal on 28/12/2023.
//

import Foundation

class TopMenuCellViewModel {
    
    var cellNumber: Int = 0
    var selectedTab: Int = 0
    var isActive: Bool = false
    
    init(isActive: Bool) {
        self.isActive = isActive
    }
    
}
