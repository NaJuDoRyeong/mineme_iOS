//
//  CalendarViewModel.swift
//  Story
//
//  Created by 김민령 on 2023/04/17.
//

import Foundation
import RxSwift
import Common

class CalendarViewModel {
    
    let getPostByCalendarUseCase : GetPostByCalendarUseCase
    let posts : BehaviorSubject<[CalendarPostPreview?]>
    let disposeBag = DisposeBag()
    var year: BehaviorSubject<Int>
    var month: BehaviorSubject<Int>
    var selectedDate: Observable<(year: Int, month: Int)>
    
    init(_ getPostByCalendarUseCase : GetPostByCalendarUseCase = DefaultPostByCalendarUseCase()){
        self.getPostByCalendarUseCase = getPostByCalendarUseCase
        
        posts = BehaviorSubject(value: [])
        
        let defaultYear = dateFormatter.DateToInt(Date(), format: "yyyy")!
        let defaultMonth = dateFormatter.DateToInt(Date(), format: "M")!
        
        year = BehaviorSubject(value: defaultYear)
        month = BehaviorSubject(value: defaultMonth)
        selectedDate = Observable.combineLatest(year, month) { (year: $0, month: $1)}
        
        selectedDate
            .subscribe(onNext: { [weak self] in
                self?.updateDays("\($0.0)", "\($0.1)")
            }).disposed(by: disposeBag)
        
        getPostByCalendarUseCase.posts
            .subscribe(onNext: { [weak self] data in
                guard let startDay = self?.startDay, let day = self?.day else{ return }
                let emptyPost : [CalendarPostPreview?] = Array(repeating: nil, count: startDay-1)
                var realPost = [CalendarPostPreview]()
                for i in 1...day {
                    realPost.append(CalendarPostPreview(day: i, post: nil))
                }
                for post in data {
                    let idx = Int(post.date.split(separator: "-").last!)!
                    realPost[idx] = CalendarPostPreview(day: idx, post: post)
                }
                self?.posts.onNext(emptyPost + realPost)
            }).disposed(by: disposeBag)
        
    }
    
    private var dateFormatter = CommonDateFormatter()
    private var years = [Int]()
    private var months = [Int]()
    private var day : Int = 1
    private var startDay : Int = 1
    
    func updateDays(_ year: String?, _ month: String?){
        let year = year ?? dateFormatter.DateToString(Date(), format: "yyyy")
        let month = month ?? dateFormatter.DateToString(Date(), format: "M")
        
        day = dateFormatter.lastDay(year: year, month: month)!
        
        let firstDate = dateFormatter.StringToDate("\(year)-\(month)-\(1)", format: "yyyy-M-d")
        startDay = dateFormatter.dayOfTheWeek(date: firstDate!)
        
        getPostByCalendarUseCase.fetchPost(year: year, month: month)
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
    }
    
    func selectYear(_ row: Int){
        year.onNext(years[row])
    }
    
    func selectMonth(_ row: Int){
        month.onNext(months[row])
    }
    
//    func Dateformatting() -> String? {
//        guard let yyyy = year, let m = month else { return nil }
//        guard let tmp = dateFormatter.StringToDate(m, format: "M") else { return nil }
//        let mmm = dateFormatter.DateToString(tmp, format: "MMM")
//        return "\(yyyy)-\(mmm)"
//    }
    
    func getYears() -> [Int] {
        return years
    }
    
    func getMonths() -> [Int] {
        return months
    }
}
