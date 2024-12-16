//
//  ViewController.swift
//  DairySimbirSoftPractice
//
//  Created by pseq on 01.12.2024.
//

import UIKit

class CalendarViewController: UIViewController, UITableViewDelegate {

    let dataService = DataService()
    var tasksForDate = [TaskItem]()
    
//    var tasksByHours = [[TaskItem]]()
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var hoursTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.addTarget(self, action: #selector(onDateChanged(sender:)), for: .valueChanged)
        
        hoursTableView.delegate = self
        hoursTableView.dataSource = self
        hoursTableView.register(UINib(nibName: "HourCellView", bundle: nil), forCellReuseIdentifier: "HourCell")
        hoursTableView.reloadData()
    }
    
    private func hourGapLabel(_ hour: Int) -> String {
        return "\(hour):00 - \((hour == 23) ? 0 : (hour + 1)):00"
    }
    
    @objc func onDateChanged(sender: UIDatePicker) {
//        tasksForDate = dataService.loadTasks(datePicker.date)
        hoursTableView.reloadData()
//        print(tasksByHours())
    }
}

// MARK: Tasks by hours distribution logic -
extension CalendarViewController {
    
    private func tasksByHours() -> [[TaskItem]] {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        let currentDayStart = datePicker.date.getDatePlusDays(0)
        let nextDayStart = datePicker.date.getDatePlusDays(1)
        let dailyTasks = dataService.loadTasks().filter {
            $0.date_start < (nextDayStart) &&
            $0.date_finish >= (currentDayStart)
        }
        var taskByHours = Array(repeating: [TaskItem](), count: 24)
        
        for dailyTask in dailyTasks {
            let taskStartedYesterday = dailyTask.date_start < currentDayStart
            let taskStartHour = taskStartedYesterday ? 0 : calendar.component(.hour, from: dailyTask.date_start)
            let taskFinishTomorrow = dailyTask.date_finish > nextDayStart
            let taskEndHour = taskFinishTomorrow ? 23 : calendar.component(.hour, from: dailyTask.date_finish)
            for hour in taskStartHour...taskEndHour {
                taskByHours[hour].append(dailyTask)
            }
        }
        return taskByHours
    }
}

// MARK: Task table view -
extension CalendarViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return taskbyhours non empty count
//        return tasksForDate.count
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // сделать массив занятых часов, и брать из него заголовки
        let cell = tableView.dequeueReusableCell(withIdentifier: "HourCell", for: indexPath) as! HourCell  // swiftlint:disable:this force_cast
//        cell.textLabel?.text = tasksForDate[indexPath.row].name             // text
        cell.textLabel?.text = hourGapLabel(indexPath.row)             // text
        cell.configure()

//        let formatter = DateFormatter()
//        formatter.timeStyle = .medium
//        cell.detailTextLabel?.text = formatter.string(from: tasksForDate[indexPath.row].date_start) // time
        
        return cell
    }
    
    // Вычисление высоты ячейки основной таблицы
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let item = parentItems[indexPath.row]
//        let childTableViewHeight = CGFloat(item.children.count * 44) // Предполагаем высота каждой строки дочерней таблицы 44 пункта
//        return 44 + childTableViewHeight // Добавляем высоту для заголовка ячейки

        let childTableViewHeight = CGFloat(4 * 44) // Предполагаем высота каждой строки дочерней таблицы 44 пункта
        return 44 + childTableViewHeight // Добавляем высоту для заголовка ячейки
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
}

// MARK: Nav buttons -
extension CalendarViewController {
    @IBAction func addTaskBtnPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showAddTaskScene", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showAddTaskScene" else { return }
        guard let destination = segue.destination as? AddTaskViewController else { return }
        destination.taskDate = datePicker.date
    }
}
