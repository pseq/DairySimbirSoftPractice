//
//  AddTaskViewController.swift
//  DairySimbirSoftPractice
//
//  Created by pseq on 05.12.2024.
//

import UIKit

class AddTaskViewController: UIViewController {
    
//    var taskDate: Date
    var taskDate: Date?
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskDatePicker: UIDatePicker!
    @IBOutlet weak var taskText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskDatePicker.setDate(taskDate!, animated: true)
    }
    
}
