//
//  DataService.swift
//  DairySimbirSoftPractice
//
//  Created by pseq on 07.12.2024.
//

import Foundation
import RealmSwift

struct DataService {
    let realm = try! Realm()


    func loadTasks(_ taskDate: Date) -> [TaskItem] {
//    TODO why self
        print("Ограничение >= \(taskDate.getDatePlusDays(0))")
        print("Ограничение < \(taskDate.getDatePlusDays(1))")
        
        let filteredTasks = realm.objects(TaskItem.self).where {
            $0.date_start >= taskDate.getDatePlusDays(0) &&
            $0.date_start < taskDate.getDatePlusDays(1)
        }
        return filteredTasks.map { $0 }
    }

    func loadTasks(_ taskId: Int) -> TaskItem? {
        return realm.object(ofType: TaskItem.self, forPrimaryKey: taskId)
    }

    func addTask(_ task: TaskItem) {
        do {
            try realm.write {
                realm.add(task)
            }
        } catch {
            print("Error save to Realm: \(error)")
        }
        
    }
}

extension Date {

    func getDatePlusDays(_ plusDays: Int) -> Date {
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: self)
        dateComponents.timeZone = TimeZone(abbreviation: "UTC")!
        let onlyDate = Calendar.current.date(from: dateComponents)!
        let datePlusDays = Calendar.current.date(byAdding: .day, value: plusDays, to: onlyDate)!
        return datePlusDays
    }
}

