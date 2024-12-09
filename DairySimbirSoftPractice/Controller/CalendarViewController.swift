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
//        print(dataService.loadTasks())
    }
    
    private var data = [
    "8:00   Проснуться",
    "8:30   Выпить кофе",
    "23:00  Лечь спать"
    ]


}

extension CalendarViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        return dishes?.count ?? 1
        print(dataService.loadTasks())
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
    //        let dish = dishes?[indexPath.item]
    //        var content = cell.defaultContentConfiguration()
    //        content.text = dish?.name ?? "No dishes"

        cell.textLabel?.text = self.data[indexPath.row]
        print("Make cell with text:")
        print(self.data[indexPath.row])
        
        return cell
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

