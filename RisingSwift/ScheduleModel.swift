//
//  ScheduleModel.swift
//  RisingSwift
//
//  Created by SSR on 2022/10/7.
//

import Foundation

class ScheduleModel {
    class ScheduleCombine: Identifiable {
        enum CombineType: String {
            case system = "system"
            case custom = "custom"
        }
        
        var sno: String
        var type: CombineType
        var courses: [ScheduleCourse]
        let id: String
        
        public init(sno: String, type: CombineType) {
            courses = []
            self.sno = sno
            self.type = type
            id = type.rawValue + sno
        }
    }
    
    private var combineMap: Dictionary<String, ScheduleCombine> = [:]
    var courseMap: Dictionary<Int ,Array<ScheduleCourse>> = [:]
    
    func combine(_ combine: ScheduleCombine) -> Void {
        combineMap[combine.id] = combine
        for course in combine.courses {
            add(course)
        }
    }
    
    private func add(_ course: ScheduleCourse) {
        for section in course.inSections {
            if courseMap[section] == nil{
                courseMap[section] = []
            }
            courseMap[section]?.append(course)
        }
    }
}
