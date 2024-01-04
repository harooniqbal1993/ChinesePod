//
//  HomeRequestModel.swift
//  ChinesePod
//
//  Created by Haroon Iqbal on 26/12/2023.
//

import Foundation

enum LessonLevel: Int, CaseIterable {
    case NewbieLevel = 0
    case ElementaryLevel = 1
    case IntermediateLevel = 2
    case UpperIntermediateLevel = 3
    case AdvancedLevel = 4
    case MediaLevel = 5
    case AllLevel = 6
    case UnknownLevel = 7
    case PreIntermediateLevel = 8
    func toParamString() -> String {
        switch(self){
        case .AllLevel:
            return ""
        case .NewbieLevel:
            return "Newbie"
        case .ElementaryLevel:
            return "Elementary"
        case .PreIntermediateLevel:
            return "Pre Intermediate"
        case .IntermediateLevel:
            return "Intermediate"
        case .UpperIntermediateLevel:
            return "Upper Intermediate"
        case .AdvancedLevel:
            return "Advanced"
        case .MediaLevel:
            return "Media"
        case .UnknownLevel:
            return "Unknown"
        }
    }
}

struct HomeRequestModel: Encodable {

}

struct LessonRequestModel: Encodable {
    var page:Int?
    var count:Int?
    var level:String?
    var free:Int?
    var bookmarked:Int?
    var studied:Int?
    var keyword:String?
    var video:Int?
    
//    init(page:Int, count: Int, level: LessonLevel, free: Bool?,bookmarked: Bool?, studied: Bool?,video: Bool?, keyword: String?) {
//        self.page = page
//        self.count = count
//        if(level != .AllLevel){
//            self.level = level.toParamString()
//        }
//
//        if let fr = free{
//            self.free = free
//        }
//
//        if let bm = bookmarked{
//            self.bookmarked = Int(bool:bm)
//        }
//
//        if let stu = studied{
//            self.studied = Int(bool:stu)
//        }
//
//        if let vi = video{
//            self.video = Int(bool:vi)
//        }
//
//        self.keyword = keyword
//    }
}
