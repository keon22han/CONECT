//
//  DateUtil.swift
//  MarketProject
//
//  Created by 한건희 on 8/25/24.
//

import Foundation

final class DateUtil {
    static let instance = DateUtil()
    
    let dateFormatter = DateFormatter()
    private init() {
        self.dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // UTC
        self.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    }
    
    public func stringToDate(date: String) -> Date{
        
        let dateTypeDate = self.dateFormatter.date(from: date)
        
        return dateTypeDate!
    }
    
    public func dateToString(date: Date) -> String {
        
        let stringTypeDate = self.dateFormatter.string(from: date)
        
        return stringTypeDate
    }
}
