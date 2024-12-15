//
//  HourCell.swift
//  DairySimbirSoftPractice
//
//  Created by mac on 15.12.2024.
//

import UIKit

class  HourCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var  taskTableView: UITableView!
    
//    var children: [ChildItem] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        taskTableView.delegate = self
        taskTableView.dataSource = self
        taskTableView.register(UITableViewCell.self, forCellReuseIdentifier: "taskCell")
    }
    
//    func configure(with item: ParentItem) {
//        titleLabel.text = item.title
//        children = item.children
//        childTableView.reloadData()
//    }

    func configure() {
        titleLabel.text = "hour text"
        taskTableView.reloadData()
    }
}

extension HourCell: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return tasks count in current hour
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)// as! TaskCell   // swiftlint:disable:this force_cast
        cell.textLabel?.text = "task text"           // text
        print("Вывод ячейки  дела \(indexPath.description):\(indexPath.row)")
        return cell
    }
}
