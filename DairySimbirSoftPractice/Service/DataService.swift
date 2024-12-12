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
            let maxId = realm.objects(TaskItem.self).max(ofProperty: "id") as Int?
            task.id = (maxId ?? 0) + 1
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

extension DataService {
    
    enum Error: Swift.Error {
        case fileNotFound(name: String)
        case fileDecodingFailed(name: String, Swift.Error)
    }
    
    
    func addTaskFromFile(_ fileName: String) throws {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json")
        else {
            throw Error.fileNotFound(name: fileName)
        }

        do {
            print(url)
            let decoder = JSONDecoder()
//            JSONDecoder().dateDecodingStrategy = .secondsSince1970
            let jsonData = try Data(contentsOf: url)
            let jsonTasks = try decoder.decode([TaskItem].self, from: jsonData)
            
            print("DECODED HERE:")
            print(jsonTasks)
            
        } catch {
            print("Error: \(error)")
        }
        
    }
}
