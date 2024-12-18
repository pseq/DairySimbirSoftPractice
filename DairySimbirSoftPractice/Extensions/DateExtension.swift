//
//  DateExtension.swift
//  DairySimbirSoftPractice
//
//  Created by pseq on 13.12.2024.
//

import Foundation

extension Date {

    func getDatePlusDays(_ plusDays: Int) -> Date {
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let onlyDate = Calendar.current.date(from: dateComponents)!
        let datePlusDays = Calendar.current.date(byAdding: .day, value: plusDays, to: onlyDate)!
        return datePlusDays
    }
}
