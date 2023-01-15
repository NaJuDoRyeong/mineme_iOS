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
    
    func formatter(_ format: String){
        formatter.dateFormat = format
    }
    
    func DateToString(_ date: Date, format : String) -> String{
        formatter(format)
        return formatter.string(from: date)
        
    }
    
    func StringToDate(_ string : String, format: String) -> Date?{
        formatter(format)
        guard let date = formatter.date(from: string) else {
            return nil
        }
        return date
    }
    
    func DateToInt(_ date: Date, format: String) -> Int?{
        let string = DateToString(date, format: format)
        guard let int = Int(string) else {
            return nil
        }
        return int
    }
    
    func lastDay(year: String, month: String) -> Int?{
        formatter.dateFormat = "yyyy-MM-dd"
        let st = formatter.date(from: "\(year)-\(month)-01")!
        let end = calendar.date(byAdding: .month, value: +1, to: st)!
        let result = calendar.dateComponents([.day], from: st, to: end)
        
        guard let day = result.day else {
            return nil
        }
        return day
    }
}
