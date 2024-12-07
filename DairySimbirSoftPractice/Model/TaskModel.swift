//
//  TaskModel.swift
//  DairySimbirSoftPractice
//
//  Created by pseq on 07.12.2024.
//

import Foundation
import RealmSwift

class TaskItem: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var date_start: Int = 0
    @objc dynamic var date_finish: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var desc: String = ""
}
