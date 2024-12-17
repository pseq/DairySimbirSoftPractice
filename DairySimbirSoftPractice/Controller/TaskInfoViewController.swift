//
//  TaskInfoViewController.swift
//  DairySimbirSoftPractice
//
//  Created by pseq on 05.12.2024.
//

import UIKit

class TaskInfoViewController: UIViewController {

    var taskToDetails = TaskItem()
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskDate: UILabel!
    @IBOutlet weak var taskText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTitle.text =  taskToDetails.name
        taskText.text =  taskToDetails.desc
                
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm d M yyyy"
        taskDate.text = dateFormatter.string(from: taskToDetails.date_start)
    }
}
