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
        startDatePicker.setDate(taskDate!, animated: false) //  Сразу установим на текущее время
        finishDatePicker.setDate(taskDate!, animated: false)
        startDatePicker.addTarget(self, action: #selector(onStartDateChanged(sender:)), for: .valueChanged)
        finishDatePicker.addTarget(self, action: #selector(onFinishChanged(sender:)), for: .valueChanged)
    }
    
    @objc func onStartDateChanged(sender: UIDatePicker) {
        // Время окончания задачи не должно быть раньше времени её начала
        finishDatePicker.minimumDate = startDatePicker.date
    }
    
    @objc func onFinishChanged(sender: UIDatePicker) {
        // Время начала задачи не должно быть позже времени её окончания
        startDatePicker.maximumDate = finishDatePicker.date
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let task = TaskItem()
        task.name = taskTitle.text ?? ""
        task.date_start = startDatePicker.date
        task.date_finish = finishDatePicker.date
        task.desc = taskDescripton.text
        
        dataService.addTask(task)
    }
}
