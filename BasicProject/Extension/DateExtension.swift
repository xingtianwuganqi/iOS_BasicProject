//
//  DateExtension.swift
//  LoveCat
//
//  Created by Admin on 2022/3/31.
//
import Foundation

extension Date {
    //年的数字
    public func year() -> Int {
        var calendar = NSCalendar.current
        calendar.firstWeekday = 2
        return calendar.component(.year, from: self)
    }
    //月的数字
    public func month() -> Int {
        var calendar = NSCalendar.current
        calendar.firstWeekday = 2
        return calendar.component(.month, from: self)
    }
    //天的数字
    public func day() -> Int {
        var calendar = NSCalendar.current
        calendar.firstWeekday = 2
        return calendar.component(.day, from: self)
    }
    //周日是第一天，周六是第七天
    public func weekday() -> Int {
        var calendar = NSCalendar.current
        calendar.firstWeekday = 2
        return calendar.component(.weekday, from: self)
    }
    public func isToday() -> Bool {
        self.day() == Date().day() && self.month() == Date().month() && self.year() == Date().year()
    }
    public func numberOfDaysInMonth() -> Int {
        if let monthRange = NSCalendar(calendarIdentifier: .gregorian)?.range(of: .day, in: .month, for: self) {
            return monthRange.length
        }
        return 0
    }
    //传入一个类型的dateFormat，返回一个日期的字符串
    public func dateStringFromFormatString(_ formatString: String?) -> String {
        guard let formatString = formatString else { return "" }
        let format = DateFormatter()
        format.dateFormat = formatString
        format.locale = Locale.current
        return format.string(from: self)
    }
    //月份前后的偏移。
    public func dateByAddingMonths(_ months: Int?) -> Date {
        guard let months = months else { return self }
        var components = DateComponents()
        components.month = months
        return NSCalendar.current.date(byAdding: components, to: self) ?? self
    }
    //由日期字符串和日期的格式生成Date的日期
    public static func dateWithString(_ dateString: String?, _ formatString: String?) -> Date? {
        guard let dateString = dateString , let formatString = formatString else { return nil }
        let format = DateFormatter()
        format.dateFormat = formatString
        format.locale = .current
        return format.date(from: dateString)
    }
    
    ///判断传入的日期是不是本周日期
    public func isSameWeekWithDate(date:Date) -> Bool {
        var calendar = Calendar(identifier: .chinese)
        calendar.firstWeekday = 2
        let nowCmps = calendar.dateComponents([.year,.month,.day,.weekday,.minute,.hour], from: Date())
        let sourceCmps = calendar.dateComponents([.year,.month,.day,.weekday,.minute,.hour], from: date)
        let dateCom = calendar.dateComponents([.year,.month,.day,.weekday,.minute,.hour], from:  Date(), to: date)
        let subDay = labs(dateCom.day!)
        let subMonth = labs(dateCom.month!)
        let subYear = labs(dateCom.year!)
        if subYear == 0 && subMonth == 0 {
            if subDay > 6 {
                return false
            }else {
                if dateCom.day! >= 0 && dateCom.hour! >= 0 && dateCom.minute! >= 0 {
                    let chinaWeekday = sourceCmps.weekday! == 1 ? 7 : sourceCmps.weekday! - 1
                    if subDay >= chinaWeekday {
                        return false
                    }else {
                        return true
                    }
                }else {
                    let  chinaWeekday = sourceCmps.weekday == 1 ? 7 : nowCmps.weekday! - 1
                    if subDay >= chinaWeekday {
                        return false
                    }else {
                        return true
                    }
                }
            }
        }else {
            return false
        }
        
    }
    
    ///是否为今年
    public func isThisYear() -> Bool {
        let calendar = Calendar.current
        let nowCmps = calendar.dateComponents([.year], from: Date())
        let selfCmps = calendar.dateComponents([.year], from: self)
        let result = nowCmps.year == selfCmps.year
        return result
    }
}
