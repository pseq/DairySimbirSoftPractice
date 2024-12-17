//
//  HourCell.swift
//  DairySimbirSoftPractice
//
//  Created by mac on 15.12.2024.
//

import UIKit

class  HourCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var taskTableView: UITableView!
    
    var tasksToHour = [TaskItem]()
    weak var delegate: HourCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        taskTableView.delegate = self
        taskTableView.dataSource = self
        taskTableView.register(UITableViewCell.self, forCellReuseIdentifier: "taskCell")
        taskTableView.isScrollEnabled = false
    }
    
    func configure(_ hour: Int, _ tasks: [TaskItem]?) {
        titleLabel.text = "\(hour):00 - \((hour == 23) ? 0 : (hour + 1)):00"
        tasksToHour = tasks ?? []
        taskTableView.reloadData()
    }

}

extension HourCell: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksToHour.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        let task = tasksToHour[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm d/MM/yy"
        cell.textLabel?.text = task.name + " c: " + dateFormatter.string(from: task.date_start)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tasksToHour[indexPath.row]
        delegate?.showNextViewController(task)
    }
}

// MARK: Protocols -
protocol HourCellDelegate: AnyObject {
    
    func showNextViewController(_  task: TaskItem)
    
}
