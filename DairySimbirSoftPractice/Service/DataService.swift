//
//  DataService.swift
//  DairySimbirSoftPractice
//
//  Created by pseq on 07.12.2024.
//

import Foundation
import RealmSwift

struct DataService {
    let realm = try! Realm() // swiftlint:disable:this force_try

    init() {
        try? addTaskFromFile("tasksFile")
    }

    func loadTasks() -> [TaskItem] {
        return realm.objects(TaskItem.self).map({ $0 })
    }

    func loadTasks(_ taskId: Int) -> TaskItem? {
        return realm.object(ofType: TaskItem.self, forPrimaryKey: taskId)
    }

    func addTask(_ task: TaskItem) {
        do {
            
            // ID generator
            if task.id == 0 {
                let maxId = realm.objects(TaskItem.self).max(ofProperty: "id") as Int?
                task.id = (maxId ?? 0) + 1
            }

            try realm.write {
                realm.add(task)
//                print("Date to realm: \(task.daƒte_start)")
//                print("Date from realm: \(realm.object(ofType: TaskItem.self, forPrimaryKey: task.id)?.date_start)")
            }
        } catch {
            print("Error save to Realm: \(error)")
        }
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
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            let jsonData = try Data(contentsOf: url)
            let jsonTasks = try decoder.decode([TaskItem].self, from: jsonData)

            for jsonTask in jsonTasks {
                if loadTasks(jsonTask.id) == nil {
                    addTask(jsonTask)
                    
                    print("Date from json: \(jsonTask.date_start)")

                } else {
                    print("There is another task with same id in realm: \(jsonTask.id)")
                }
            }
            
        } catch {
            print("Error: \(error)")
        }
        
    }
}
