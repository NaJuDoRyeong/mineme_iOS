//
//  DayOfTheWeek.swift
//  Common
//
//  Created by 김민령 on 2023/03/05.
//

import Foundation

public enum DayOfWeek: CaseIterable{
    case sun
    case mon
    case tue
    case wed
    case thr
    case fri
    case sat
    
}

extension DayOfWeek {
    public var eng : String {
        switch self {
        case .sun:
            return "Sun"
        case .mon:
            return "Mon"
        case .tue:
            return "Tue"
        case .wed:
            return "Wed"
        case .thr:
            return "Thr"
        case .fri:
            return "Fri"
        case .sat:
            return "Sat"
        }
    }
    
    public var kor : String {
        switch self {
        case .sun:
            return "일"
        case .mon:
            return "월"
        case .tue:
            return "화"
        case .wed:
            return "수"
        case .thr:
            return "목"
        case .fri:
            return "금"
        case .sat:
            return "토"
        }
    }
}
