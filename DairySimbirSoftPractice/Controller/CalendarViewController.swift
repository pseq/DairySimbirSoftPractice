//
//  ViewController.swift
//  DairySimbirSoftPractice
//
//  Created by pseq on 01.12.2024.
//

import UIKit

class CalendarViewController: UIViewController {

    let dataService = DataService()
    var tasksForDate = [TaskItem]()
    
//    var tasksByHours = [[TaskItem]]()
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var taskTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.addTarget(self, action: #selector(onDateChanged(sender:)), for: .valueChanged)
        

    }
    
    private func hourGapLabel(_ hour: Int) -> String {
        return "\(hour):00 - \((hour == 23) ? 0 : (hour + 1)):00"
    }
    
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
            for i in taskStartHour...taskEndHour {
                taskByHours[i].append(dailyTask)
            }
        }
        return taskByHours
    }

    @IBAction func addTaskBtnPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showAddTaskScene", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showAddTaskScene" else { return }
        guard let destination = segue.destination as? AddTaskViewController else { return }
        destination.taskDate = datePicker.date
    }
    
    @objc func onDateChanged(sender: UIDatePicker) {
//        tasksForDate = dataService.loadTasks(datePicker.date)
        taskTableView.reloadData()
        print(tasksByHours())
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        tasksForDate = dataService.loadTasks(datePicker.date)
        taskTableView.reloadData()
    }
}

extension CalendarViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return taskbyhours non empty count
        return tasksForDate.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // сделать массив занятых часов, и брать из него заголовки
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        cell.textLabel?.text = tasksForDate[indexPath.row].name             // text
        
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        cell.detailTextLabel?.text = formatter.string(from: tasksForDate[indexPath.row].date_start) // time
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return self.sectTitle[section]
//    }
    
    //    func loadDishes() {
    //        dishes = realm.objects(Dishes.self).sorted(byKeyPath: "name")
    //        tableView.reloadData()
    //    }
    //
    //    func taskTable(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        //показать ингридиенты выбранного блюда
    //        selectedDish = dishes![indexPath.row]
    //        performSegue(withIdentifier: "showIngreds", sender: self)
    //    }
    //
    //    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //
    //        let destinationVC = segue.destination as! IngredientsViewController
    //        //указывает, какие ингридиенты показывать
    //        destinationVC.selectedDish = selectedDish
    //    }
    //
    //    func taskTable(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    //
    //        let swipeDishLeft = UIContextualAction(style: .normal, title: "Delete") {
    //            [weak self] (action, view, completionHandler) in self?.deleteDish(self!.dishes![indexPath.row])
    //            completionHandler(true)
    //      }
    //        swipeDishLeft.backgroundColor = .systemRed
    //
    //        return UISwipeActionsConfiguration(actions: [swipeDishLeft])
    //    }
    //
    //    func deleteDish (_ dish: Dishes) {
    //        do {
    //            try realm.write {
    //                realm.delete(dish)
    //                tableView.reloadData()
    //            }
    //        } catch {
    //            print("Error delete dish: \(error)")
    //        }
    //    }
}

