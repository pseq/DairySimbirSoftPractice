//
//  ViewController.swift
//  DairySimbirSoftPractice
//
//  Created by pseq on 01.12.2024.
//

import UIKit

class CalendarViewController: UIViewController {

    let dataService = DataService()
    @IBOutlet weak var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addTaskBtnPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showAddTaskScene", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showAddTaskScene" else { return }
        guard let destination = segue.destination as? AddTaskViewController else { return }
        destination.taskDate = datePicker.date
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Load from Realm:")
        print(dataService.loadTasks())
    }
    
}


