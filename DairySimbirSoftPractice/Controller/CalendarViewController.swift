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
    
    private var taskData = [
    "Проснуться",
    "Выпить кофе",
    "Выпить кофе",
    "Выпить кофе",
    "Лечь спать"
    ]
    private var taskTime = [
    "8:00",
    "8:30",
    "9:00",
    "9:20",
    "23:00"
    ]
    private var sectTitle = [
    "8:00 - 9:00",
    "9:00 - 10:00",
    "23:00 - 0:00"
    ]
}

extension CalendarViewController: UITableViewDataSource {

//    func numberOfSections(in tableView: UITableView) -> Int {
//        // посчитать количество занятых часов в день
//        return 3
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // посчитать количество дел на каждый час
//        if section == 0 { return 2 }
//        else if section == 1 { return 2 }
//        else if section == 2 { return 1 }
//        else {return 0}
        return dataService.loadTasks().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // для каждого часа посчитать номер ячейки в часе
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
//        cell.textLabel?.text = self.taskData[indexPath.row] // text
//        cell.detailTextLabel?.text = self.taskTime[indexPath.row]    // time
//        cell.textLabel?.text =
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectTitle[section]
    }
    
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

