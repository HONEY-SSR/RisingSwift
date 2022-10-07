//
//  ScheduleCourse.swift
//  RisingSwift
//
//  Created by SSR on 2022/10/7.
//

import Foundation

struct ScheduleCourse {
    /// 星期
    var inWeek: Int
    /// 散列周
    var inSections: Set<Int>
    /// 节
    var period: Range<Int>
    
    /// 课程
    var course: String
    /// 教室
    var classRoom: String
    /// 课程号
    var courseID: String
    
    /// 循环周
    var rawWeek: String?
    /// 选修
    var type: String
    /// 老师
    var teacher: String?
    /// "xx"节
    var lesson: String?
    
    public init(dictionary dic: Dictionary<String, Any>) {
        inWeek = dic["hash_day"] as! Int
        inSections = dic["week"] as! Set<Int>
        let location = dic["begin_lesson"] as! Int
        let lenth = dic["period"] as! Int
        period = Range(uncheckedBounds: (location, location + lenth))
        course = dic["course"] as! String
        classRoom = dic["classroom"] as! String
        courseID = dic["course_num"] as! String
        rawWeek = dic["rawWeek"] as? String
        type = dic["type"] as! String
        teacher = dic["teacher"] as? String
        lesson = dic["lesson"] as? String
    }
}
