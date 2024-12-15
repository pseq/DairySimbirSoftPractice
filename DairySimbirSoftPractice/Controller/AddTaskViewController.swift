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
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var finishDatePicker: UIDatePicker!
    @IBOutlet weak var taskDescripton: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startDatePicker.setDate(taskDate!, animated: false)
        finishDatePicker.setDate(taskDate! + TimeInterval(3600), animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let task = TaskItem()
        // TODO не добавлять пустые
        task.name = taskTitle.text ?? ""
        task.date_start = startDatePicker.date
        task.date_finish = finishDatePicker.date
        task.desc = taskDescripton.text
        
        dataService.addTask(task)
        print("Date from datapicker: \(startDatePicker.date)")
    }
}
