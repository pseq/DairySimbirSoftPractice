//
//  TaskInfoViewController.swift
//  DairySimbirSoftPractice
//
//  Created by pseq on 05.12.2024.
//

import UIKit

class TaskInfoViewController: UIViewController {

    let dataService = DataService()
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskDate: UILabel!
    @IBOutlet weak var taskText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(dataService.loadTasks())
    }
}
