//
//  Date+Utils.swift
//  CalendarView
//
//  Created by Jonathan Pereira Bijos on 18/10/19.
//

import Foundation

extension Date {
    
    var day: Int {
        let myCalendar = self.setUpGregorianCalendar()
        
        let myComponents = (myCalendar as NSCalendar).components(.day, from: self)
        let day = myComponents.day
        return day!
    }
    
    var month: Int {
        let myCalendar = self.setUpGregorianCalendar()
        
        let myComponents = (myCalendar as NSCalendar).components(.month, from: self)
        let month = myComponents.month
        return month!
    }
    
    var year: Int {
        let myCalendar = self.setUpGregorianCalendar()
        
        let myComponents = (myCalendar as NSCalendar).components(.year, from: self)
        let year = myComponents.year
        return year!
    }
    
    var firstDate: Date {
        let calendar = self.setUpGregorianCalendar()
        
        var components = calendar.dateComponents([.month, .year], from: self)
        components.day = 1
        return calendar.date(from: components)!
    }
    
    var lastDate: Date {
        let calendar = self.setUpGregorianCalendar()
        
        var components = calendar.dateComponents([.month, .year], from: self)
        components.day = -1
        return calendar.date(from: components)!
    }
    
    var shortDate: String {
        return String(format: "%@ %04d", self.monthString, self.year)
    }
    
    var firstWeekday: Int {
        let calendar = self.setUpGregorianCalendar()
        
        return calendar.dateComponents([.weekday], from: self).weekday!
    }
    
    var daysInMonth: Int {
        let calendar = self.setUpGregorianCalendar()
        
        return calendar.range(of: .day, in: .month, for: self)!.count
    }
    
    func shortDayOfWeekByDay(_ day : Int, charactersLimit: Int) -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        guard let weekdays = formatter.weekdaySymbols else { return "" }
        
        let dayString = day < weekdays.count ? weekdays[day] : ""
        
        return String(dayString.prefix(charactersLimit)).capitalized
    }
    
    var monthString: String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "LLLL"
        formatter.locale = Locale.current
        let month = formatter.string(from: self)
        return month.capitalized
    }
    
    func equalsDay(date: Date) -> Bool {
        let calendar = self.setUpGregorianCalendar()
        return calendar.compare(self, to: date, toGranularity: .day) == ComparisonResult.orderedSame
    }
    
    func setUpGregorianCalendar() -> Calendar {
        var calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.locale = .current
        return calendar
    }
    
    mutating func setHour(with hour: Int) {
        let calendar = self.setUpGregorianCalendar()
        var components = calendar.dateComponents([.day, .month, .year], from: self)
        components.hour = hour
        self = calendar.date(from: components)!
    }
}

