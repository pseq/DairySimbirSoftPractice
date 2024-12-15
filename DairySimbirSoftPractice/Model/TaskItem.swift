//
//  TaskModel.swift
//  DairySimbirSoftPractice
//
//  Created by pseq on 07.12.2024.
//

import Foundation
import RealmSwift

final class TaskItem: Object, Codable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var date_start: Date     // swiftlint:disable:this identifier_name
    @Persisted var date_finish: Date    // swiftlint:disable:this identifier_name
    @Persisted var name: String = ""
    @Persisted var desc: String = ""
}
