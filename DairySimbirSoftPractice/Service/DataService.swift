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


    func loadTasks() -> Results<TaskItem> {
    //TODO why self
        return realm.objects(TaskItem.self)
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

