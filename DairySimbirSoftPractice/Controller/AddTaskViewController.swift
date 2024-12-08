//
//  AddTaskViewController.swift
//  DairySimbirSoftPractice
//
//  Created by pseq on 05.12.2024.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    let dataService = DataService()
    var taskDate: Date?
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskDatePicker: UIDatePicker!
    @IBOutlet weak var taskText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskDatePicker.setDate(taskDate!, animated: false)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("Now call write to Realm service")
        let task = TaskItem()
        //TODO не добавлять пустые
        task.name = taskTitle.text ?? ""
        dataService.addTask(task)
    }
    
    
    
}
