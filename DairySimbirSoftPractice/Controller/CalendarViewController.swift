//
//  ViewController.swift
//  DairySimbirSoftPractice
//
//  Created by pseq on 01.12.2024.
//
// new branch v.12.0

import UIKit

class CalendarViewController: UIViewController, UITableViewDelegate {
    
    var tasksByHours = [Int: [TaskItem]]() // Номер часа в сутках : список задач на этот час
    var taskToDetails = TaskItem()
    var taskDistributor: TasksDistributionProtocol?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var hoursTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.addTarget(self, action: #selector(onDateChanged(sender:)), for: .valueChanged)
        hoursTableView.delegate = self
        hoursTableView.dataSource = self
        taskDistributor = TasksDistributor()
        hoursTableView.register(UINib(nibName: "HourCellView", bundle: nil), forCellReuseIdentifier: "hourCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Будем распределять список задач на каждый час суток при каждом появлении
        tasksByHours =  taskDistributor?.tasksByHoursDistribution(datePicker.date) ?? [:]
        hoursTableView.reloadData()
    }
    
    @objc func onDateChanged(sender: UIDatePicker) {
        // ...и при изменении даты в календаре
        tasksByHours =  taskDistributor?.tasksByHoursDistribution(datePicker.date) ?? [:]
        hoursTableView.reloadData()
    }
}

// MARK: Task table view -
extension CalendarViewController: UITableViewDataSource {
    
    // Отсортированный для вывода в  таблицу список часов, на которые есть задачи на текущую дату
    func hourByIndex(_ indexPathRow: Int) -> Int {
        let busyHours = Array(tasksByHours.keys).sorted()
        return busyHours[indexPathRow]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksByHours.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hourCell", for: indexPath) as! HourCell  // swiftlint:disable:this force_cast
        let currentHour = hourByIndex(indexPath.row)
        let currentHourTasks = tasksByHours[currentHour]
        cell.configure(currentHour, currentHourTasks)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentHour = hourByIndex(indexPath.row)
        let tasksCount = tasksByHours[currentHour]?.count ?? 0
        
        let taskTableViewHeight = CGFloat(tasksCount * 44)
        return 30 + taskTableViewHeight
    }
    
//        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            return UITableView.automaticDimension
//        }
//    
//        func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//            return UITableView.automaticDimension
//        }
}

// MARK: Segues -
extension CalendarViewController: HourCellDelegate {
    
    func showNextViewController(_ task: TaskItem) {
        taskToDetails = task
        performSegue(withIdentifier: "showTaskInfoScene", sender: self)
    }
    
    @IBAction func addTaskBtnPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showAddTaskScene", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddTaskScene" {
            if let destination = segue.destination as? AddTaskViewController {
                destination.taskDate = datePicker.date
            }
        } else if segue.identifier == "showTaskInfoScene" {
            if let destination = segue.destination as? TaskInfoViewController {
                destination.taskToDetails = taskToDetails
            }
        }
    }
    
}
