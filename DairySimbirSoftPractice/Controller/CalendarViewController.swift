//
//  ViewController.swift
//  DairySimbirSoftPractice
//
//  Created by pseq on 01.12.2024.
//

import UIKit

class CalendarViewController: UIViewController, UITableViewDelegate {
    
    let dataService = DataService()
    var tasksByHours = [Int: [TaskItem]]()
    var taskToDetails = TaskItem()
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var hoursTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.addTarget(self, action: #selector(onDateChanged(sender:)), for: .valueChanged)
        hoursTableView.delegate = self
        hoursTableView.dataSource = self
        hoursTableView.register(UINib(nibName: "HourCellView", bundle: nil), forCellReuseIdentifier: "HourCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tasksByHoursDistribution()
        hoursTableView.reloadData()
    }
    
    @objc func onDateChanged(sender: UIDatePicker) {
        tasksByHoursDistribution()
        hoursTableView.reloadData()
    }
}

// MARK: Tasks by hours distribution logic -
extension CalendarViewController {
    
    private func tasksByHoursDistribution() {
        let calendar = Calendar.current
        let currentDayStart = datePicker.date.getDatePlusDays(0)
        let nextDayStart = datePicker.date.getDatePlusDays(1)
        let dailyTasks = dataService.loadTasks().filter {
            $0.date_start < (nextDayStart) &&
            $0.date_finish >= (currentDayStart)
        }
        tasksByHours.removeAll()
        
        for dailyTask in dailyTasks {
            let taskStartedYesterday = dailyTask.date_start < currentDayStart
            let taskStartHour = taskStartedYesterday ? 0 : calendar.component(.hour, from: dailyTask.date_start)
            let taskFinishTomorrow = dailyTask.date_finish > nextDayStart
            let taskEndHour = taskFinishTomorrow ? 23 : calendar.component(.hour, from: dailyTask.date_finish - TimeInterval(1))
            for hour in taskStartHour...taskEndHour {
                
                if tasksByHours[hour] == nil {
                    tasksByHours[hour] = [dailyTask]
                } else {
                    tasksByHours[hour]!.append(dailyTask)
                }
            }
        }
    }
}

// MARK: Task table view -
extension CalendarViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksByHours.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HourCell", for: indexPath) as! HourCell  // swiftlint:disable:this force_cast
        let busyHours = Array(tasksByHours.keys).sorted()
        let currentHour = busyHours[indexPath.row]
        let currentHourTasks = tasksByHours[currentHour]
//        cell.isUserInteractionEnabled = false
        cell.configure(currentHour, currentHourTasks)
        cell.delegate = self
        return cell
    }
    
    // Вычисление высоты ячейки основной таблицы
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let busyHours = Array(tasksByHours.keys)
        let currentHour = busyHours[indexPath.row]
        let tasksCount = tasksByHours[currentHour]?.count ?? 0
        
        let childTableViewHeight = CGFloat(tasksCount * 44) // Предполагаем высота каждой строки дочерней таблицы 44 пункта
        return 44 + childTableViewHeight
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
