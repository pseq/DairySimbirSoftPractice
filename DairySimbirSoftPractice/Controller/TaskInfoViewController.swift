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
    @IBOutlet weak var taskDateStart: UILabel!
    @IBOutlet weak var taskDateFinish: UILabel!
    @IBOutlet weak var taskText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTitle.text =  taskToDetails.name
        taskText.text =  taskToDetails.desc
                
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm dd MMMM yyyy"
        taskDateStart.text = dateFormatter.string(from: taskToDetails.date_start)
        taskDateFinish.text = dateFormatter.string(from: taskToDetails.date_finish)
    }
}
