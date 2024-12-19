//
//  DataService.swift
//  DairySimbirSoftPractice
//
//  Created by pseq on 07.12.2024.
//

import Foundation
import RealmSwift

struct DataService {
    let realm = try! Realm() // Если Realm не работает, то дальше и пробовать нечего // swiftlint:disable:this force_try

    init() {
        try? addTaskFromFile("tasksFile") // Для начала пробуем загрузить задачи из json
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
                task.id = (maxId ?? 0) + 1  // Генерируем ID задач простым инкрементом
                                            // Realm может генерировать UUID и самостоятельно,
                                            // но тогда будет затруднительно добавить записи из json, т.к. по ТЗ они Int
            }

            try realm.write {
                realm.add(task)
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
    
    // Берём задачи  из json, который лежит известно где
    func addTaskFromFile(_ fileName: String) throws {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json")
        else {
            throw Error.fileNotFound(name: fileName)
        }

        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970 // Даты в json указаны в timestamp
            let jsonData = try Data(contentsOf: url)
            let jsonTasks = try decoder.decode([TaskItem].self, from: jsonData)

            for jsonTask in jsonTasks {
                if loadTasks(jsonTask.id) == nil {
                    addTask(jsonTask)
                } else {
                    print("There is another task with same id in realm: \(jsonTask.id)")
                }
            }
            
        } catch {
            print("Error: \(error)")
        }
    }
}
