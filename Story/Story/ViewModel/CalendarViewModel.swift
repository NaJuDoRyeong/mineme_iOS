//
//  CalendarViewModel.swift
//  Story
//
//  Created by 김민령 on 2023/04/17.
//

import Foundation
import Common

class CalendarViewModel {
    
    private var dateFormatter = CommonDateFormatter()
    private var years = [Int]()
    private var months = [Int]()
    private var days = [Int]()
    private var year : String?
    private var month : String?
    
    func updateDays(_ year: String?, _ month: String?){
        let year = year ?? dateFormatter.DateToString(Date(), format: "yyyy")
        let month = month ?? dateFormatter.DateToString(Date(), format: "M")
        
        let last = dateFormatter.lastDay(year: year, month: month)!
        let firstDate = dateFormatter.StringToDate("\(year)-\(month)-\(1)", format: "yyyy-M-d")
        let day = dateFormatter.dayOfTheWeek(date: firstDate!)
        days = Array(repeating: 0, count: day-1)
        for i in 1...last{
            days.append(i)
        }
    }
    
    func getDays() -> [Int] {
        return days
    }
    
    func dateSetting(){
        var years = [Int]()
        guard let today = dateFormatter.DateToInt(Date(), format: "yyyy") else { return }
        for i in 1970...today {
            years.append(i)
        }
        self.years = years.reversed()
        
        var months: [Int] = []
        for i in 1...12 {
            months.append(i)
        }
        self.months = months
        
        self.year = dateFormatter.DateToString(Date(), format: "yyyy")
        self.month = dateFormatter.DateToString(Date(), format: "M")
    }
    
    func selectYear(_ row: Int){
        year = "\(years[row])"
    }
    
    func selectMonth(_ row: Int){
        month = "\(months[row])"
    }
    
    func selectedYear() -> String? {
        return year
    }
    
    func selectedMonth() -> String? {
        return month
    }
    
    func Dateformatting() -> String? {
        guard let yyyy = year, let m = month else { return nil }
        guard let tmp = dateFormatter.StringToDate(m, format: "M") else { return nil }
        let mmm = dateFormatter.DateToString(tmp, format: "MMM")
        return "\(yyyy)-\(mmm)"
    }
    
    func getYears() -> [Int] {
        return years
    }
    
    func getMonths() -> [Int] {
        return months
    }
}
