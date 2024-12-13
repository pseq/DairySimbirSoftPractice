//
//  DateExtension.swift
//  DairySimbirSoftPractice
//
//  Created by pseq on 13.12.2024.
//

import Foundation

extension Date {

    func getDatePlusDays(_ plusDays: Int) -> Date {
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: self)
        dateComponents.timeZone = TimeZone(abbreviation: "UTC")!
        let onlyDate = Calendar.current.date(from: dateComponents)!
        let datePlusDays = Calendar.current.date(byAdding: .day, value: plusDays, to: onlyDate)!
        return datePlusDays
    }
}
