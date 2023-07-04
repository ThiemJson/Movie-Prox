//
//  Date+Extension.swift
//  movie
//
//  Created by Macbook Pro 2017 on 7/14/20.
//  Copyright © 2020 Shantaram K. All rights reserved.
//

import Foundation
extension Date {
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm\ndd'\(self.daySuffix())' MMM yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    
    private func daySuffix() -> String {
        let calendar = Calendar.current
        let dayOfMonth = calendar.component(.day, from: self)
        
        switch dayOfMonth {
        case 1, 21, 31:
            return "st"
        case 2, 22:
            return "nd"
        case 3, 23:
            return "rd"
        default:
            return "th"
        }
    }
    
    func currentYear() -> Int {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        return year
    }
    
    func convertToVietnamTimeZone() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Ho_Chi_Minh")
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss" // Customize the date format as per your needs
        return dateFormatter.string(from: self)
    }
    
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    var startOfMonth: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        return  calendar.date(from: components)!
    }
    
    func isSunday() -> Bool {
        let calendar    = Calendar.calendarVietnam
        let weekday     = calendar.component(.weekday, from: self)
        return weekday == 1
    }
    
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
    }
    
    var startOfYear: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: self)
        return  calendar.date(from: components)!
    }
    
    var endOfYear: Date {
        var components = DateComponents()
        components.year = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfYear)!
    }
    
    func isOnSelectedDate(_ _startTime: Date, _ _endTime: Date) -> Bool {
        let startday  = self.startOfDay.millisecondsSince1970
        let endday    = self.endOfDay.millisecondsSince1970
        let startTime   = _startTime.millisecondsSince1970
        let endTime     = _endTime.millisecondsSince1970
        return (startTime >= startday) && (endTime <= endday)
    }
}

extension Date {
    var withoutTime: Date {
        let dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: self)
        return Calendar.current.date(from: dateComponents) ?? self
    }
    
    var isToday: Bool {
        let today = Date()
        return today.withoutTime.compare(self.withoutTime) == .orderedSame
    }
    
    static func datesInMonth(year: Int, month: Int) -> [[Date]] {
        let calendar = Calendar.current
        var datesArray: [[Date]] = []
        
        // Tạo một ngày đầu tháng
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = 1
        let startDate = calendar.date(from: components)!
        
        // Tìm ngày cuối cùng của tháng
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        let numberOfDaysInMonth = range.count
        
        // Lặp qua từng ngày trong tháng
        var currentDate = startDate
        while calendar.component(.month, from: currentDate) == month {
            // Tạo một mảng con chứa 7 ngày
            var weekArray: [Date] = []
            for _ in 1...7 {
                if calendar.component(.month, from: currentDate) != month {
                    // Thêm ngày không thuộc tháng vào để đảm bảo mảng con có đúng 7 phần tử
                    //weekArray.append(nil)
                } else {
                    weekArray.append(currentDate)
                }
                currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
            }
            datesArray.append(weekArray)
        }
        
        return datesArray
    }
}

extension Calendar {
    static func getRecentYears(maxLen: Int) -> [Date] {
        let currentYear = Calendar.current.component(.year, from: Date())
        var recentYears: [Date] = []
        
        for i in 0..<maxLen {
            if let year = Calendar.current.date(byAdding: .year, value: -i, to: Date()) {
                recentYears.append(year)
            }
        }
        
        return recentYears
    }
    
    func numberOfWeeksInMonth(year: Int, month: Int) -> Int {
        // Tạo một date components chỉ với năm và tháng
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        
        // Lấy ngày đầu tiên trong tháng
        guard let startDate = self.date(from: dateComponents) else {
            return 0
        }
        
        // Tính toán ngày cuối cùng trong tháng
        guard let endDate = self.date(byAdding: DateComponents(month: 1, day: -1), to: startDate) else {
            return 0
        }
        
        // Lấy tuần đầu tiên và tuần cuối cùng trong tháng
        let startWeek = self.component(.weekOfYear, from: startDate)
        let endWeek = self.component(.weekOfYear, from: endDate)
        
        // Tính toán số lượng tuần
        let numberOfWeeks = endWeek - startWeek + 1
        
        return numberOfWeeks
    }
    
    static var calendarUS: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        let timeZone = TimeZone(identifier: "America/New_York")!
        calendar.timeZone = timeZone
        return calendar
    }()
    
    static var calendarVietnam: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        let timeZone = TimeZone(identifier: "Asia/Ho_Chi_Minh")!
        calendar.timeZone = timeZone
        return calendar
    }()
    
    func weekDaysInMonth(_ month: Int, year: Int) -> [Date]? {
        var dateComponents = DateComponents(year: year, month: month, day: 1)
        guard let startDate = self.date(from: dateComponents) else {
            return nil
        }
        
        var weekDays: [Date] = []
        enumerateDates(startingAfter: startDate, matching: DateComponents(hour: 0, minute: 0, second: 0, weekday: self.firstWeekday), matchingPolicy: .nextTime) { (date, _, stop) in
            if let date = date {
                if self.component(.month, from: date) != month {
                    stop = true
                } else {
                    weekDays.append(date)
                }
            }
        }
        
        return weekDays
    }
    
    func numberOfWeeks(inYear year: Int, month: Int) -> Int? {
        let dateComponents = DateComponents(year: year, month: month)
        guard let startDate = self.date(from: dateComponents),
              let endDate = self.date(byAdding: .month, value: 1, to: startDate),
              let weekRange = self.range(of: .weekOfMonth, in: .month, for: startDate)
        else {
            return nil
        }
        return weekRange.count
    }
    
    func isDate(_ date: Date, inWeek week: Int, ofYear year: Int, month: Int) -> Bool {
        let dateComponents = self.dateComponents([.weekOfMonth, .year, .month], from: date)
        return dateComponents.year == year && dateComponents.month == month && dateComponents.weekOfMonth == week
    }
}

extension TimeInterval {
    func formattedTimeString() -> String {
        let totalSeconds = Int(self)
        let minutes = (totalSeconds / 60) % 60
        let hours = totalSeconds / 3600
        
        if hours > 0 {
            return String(format: "%dh%02dm", hours, minutes)
        } else if minutes > 0 {
            return String(format: "%dm%02ds", minutes, totalSeconds % 60)
        } else {
            return String(format: "%ds", totalSeconds)
        }
    }
}
