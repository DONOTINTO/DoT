//
//  DateUtil.swift
//  DoT
//
//  Created by 이중엽 on 3/9/24.
//

import Foundation

enum DateUtil {
    
    /// from -> to 까지 하루 단위로 Date 배열로 리턴
    static func getDatesRange(from: Date, to: Date) -> [Date] {
        if from > to { return [] }
        
        var datesRange: [Date] = [from]
        var newDate = from
        
        while newDate < to {
            newDate = Calendar.current.date(byAdding: .day, value: 1, to: newDate) ?? Date()
            
            datesRange.append(newDate)
        }
        
        return datesRange
    }
    
    /// ISO DateFormatter를 통해 Date를 String 형태로 변경
    static func getISOStringFromDate(date: Date, option: ISO8601DateFormatter.Options) -> String {
        
        let df = ISO8601DateFormatter()
        df.formatOptions = .withInternetDateTime
        df.timeZone = TimeZone.current
        let dateString = df.string(from: date)
        return dateString
    }
    
    /// Date Formatter로 입력받은 format의 String을 반환
    static func getStringFromDate(date: Date, format: String) -> String {
        
        let df = DateFormatter()
        df.dateFormat = format
        df.locale = Locale(identifier: "ko_KR")
        
        let dateString = df.string(from: date)
        return dateString
    }
    
    /// 년/월/일 00시 Date로 반환
    static func getOnlyDate(_ date: Date) -> Date {
        let component = Calendar.current.dateComponents([.year, .month, .day], from: date)
        return Calendar.current.date(from: component) ?? Date()
    }
    
    /// Date 사이의 "일" 차이를 반환
    static func getDateGap(from: Date, to: Date) -> Int {
        let fromDateOnly = DateUtil.getOnlyDate(from)
        let toDateOnly = DateUtil.getOnlyDate(to)
        
        return Calendar.current.dateComponents([.day], from: fromDateOnly, to: toDateOnly).day ?? 0
    }
    
    /// first와 second가 동일한 날짜인지 체크
    static func isSameDate(first: Date, second: Date) -> Bool {
        
        let firstDateString = self.getOnlyDate(first)
        let secondDateString = self.getOnlyDate(second)
        
        return firstDateString == secondDateString
    }
}