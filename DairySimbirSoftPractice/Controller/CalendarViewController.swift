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
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var taskTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.addTarget(self, action: #selector(onDateChanged(sender:)), for: .valueChanged)
        
        //TO DEL
//        try? dataService.addTaskFromFile("tasksFile.json")
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
        tasksForDate = dataService.loadTasks(datePicker.date)
        taskTableView.reloadData()
        print(tasksForDate)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tasksForDate = dataService.loadTasks(datePicker.date)
        taskTableView.reloadData()
    }
}

extension CalendarViewController: UITableViewDataSource {

//    func numberOfSections(in tableView: UITableView) -> Int {
//        // посчитать количество занятых часов в день
//    return tasksForDate.count
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//         посчитать количество дел на каждый час
//        if section == 0 { return 2 }
//        else if section == 1 { return 2 }
//        else if section == 2 { return 1 }
//        else {return 0}
        return tasksForDate.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // для каждого часа посчитать номер ячейки в часе
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

