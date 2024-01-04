//
//  LessonViewModel.swift
//  ChinesePod
//
//  Created by Haroon Iqbal on 28/12/2023.
//

import Foundation

class LessonViewModel {
    
    var lessons: [String] = []
    
    func filterLessons(lessonLevel: LessonLevel) -> [String] {
        return lessons.filter { $0 == "" }
    }
}
