//
//  DateFormatter.swift
//  Common
//
//  Created by 김민령 on 2023/01/16.
//

import Foundation

public struct CommonDateFormatter {
    
    let formatter = DateFormatter()
    let calendar = Calendar(identifier: .gregorian)
    
    public init(){ }
    
    public func formatter(_ format: String){
        formatter.dateFormat = format
    }
    
    public func DateToString(_ date: Date, format : String) -> String{
        formatter(format)
        return formatter.string(from: date)
        
    }
    
    public func StringToDate(_ string : String, format: String) -> Date?{
        formatter(format)
        guard let date = formatter.date(from: string) else {
            return nil
        }
        return date
    }
    
    public func DateToInt(_ date: Date, format: String) -> Int?{
        let string = DateToString(date, format: format)
        guard let int = Int(string) else {
            return nil
        }
        return int
    }
    
    public func lastDay(year: String, month: String) -> Int?{
        formatter("yyyy-MM-dd")
        let st = formatter.date(from: "\(year)-\(month)-01")!
        let end = calendar.date(byAdding: .month, value: +1, to: st)!
        let result = calendar.dateComponents([.day], from: st, to: end)
        
        guard let day = result.day else {
            return nil
        }
        return day
    }
    
    public func today() -> Date{
        return Date()
    }
    
    public func todayToString() -> String{
        formatter("yyyy-MMM")
        let string = formatter.string(from: today())
        return string
    }
    
    public func dayOfTheWeek(date: Date) -> Int{
        return calendar.component(.weekday, from: date)
//        let string = formatter.string(from: date)
//        return string
    }
}
