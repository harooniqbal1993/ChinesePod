//
//  LessonFilterViewModel.swift
//  ChinesePod
//
//  Created by Haroon Iqbal on 03/01/2024.
//

import Foundation

class LessonFilterViewModel {
    
    let tabOptions: [String] = ["Intro", "Dialogue", "Vocabulary", "Expansion", "Grammer"]
    let courseTabOptions: [String] = ["Intro", "Lessons"]
    var options: [String] = []
    
    func getOptions(isCourseVC: Bool? = false) {
        options = (isCourseVC ?? false) ? courseTabOptions : tabOptions
    }
}
