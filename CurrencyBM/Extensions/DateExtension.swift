//
//  DateExtension.swift
//  CurrencyBM
//
//  Created by Omar M1 on 10/06/2023.
//

import Foundation

extension Date {
    func getDateBack(dayback: Int) -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        let previousDay = calendar.date(byAdding: .day, value: -1 * dayback, to: currentDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let previousDayString = dateFormatter.string(from: previousDay!)
        return previousDayString
    }
    
    func getTodayDate() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDateString = dateFormatter.string(from: currentDate)
        return currentDateString
    }
}
