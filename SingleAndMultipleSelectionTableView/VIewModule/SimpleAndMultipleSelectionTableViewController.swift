//
//  SimpleAndMultipleSelectionTableViewController.swift
//  SingleAndMultipleSelectionTableView
//
//  Created by Kohei Hayashi on 2020/01/30.
//  Copyright © 2020 Kohei Hayashi. All rights reserved.
//

import Foundation
import UIKit

class SimpleAndMultipleSelectionTableViewController: UIViewController {
    private let tableView = UITableView()

    private let sections = ["お好きな銭湯", "サウナ温度", "水風呂温度", "hoge"]
    private let cellTitles = [
        ["光明泉", "文化浴泉", "北欧", "八幡湯", "かるまる"],
        ["81~85", "86~90", "91~95", "96~100", "100度越えがええ"],
        ["25~21", "20~18", "17~15", "かるまるのサンダートルネードくらいくキンキンで"],
        ["hoge", "hoge", "hoge", "hoge", "hoge",
         "hoge", "hoge", "hoge", "hoge", "hoge",
         "hoge", "hoge", "hoge", "hoge", "hoge"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .secondarySystemBackground
        tableView.tableFooterView = UIView()
        // UITableView全体は複数選択可能に設定
        tableView.allowsMultipleSelection = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        view.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

extension SimpleAndMultipleSelectionTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellTitles[section].count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CustomHeaderView()
        headerView.setup(headerTitle: sections[section])
        return headerView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath)
        cell.textLabel?.text = cellTitles[indexPath.section][indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}

extension SimpleAndMultipleSelectionTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        return sections[indexPath.section] == "銭湯" ? nil : indexPath
    }

}

private final class CustomCell: UITableViewCell {
    // Cellが生成されるタイミングでselectedの状態がtrueならチェックを付ける
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        accessoryType = selected ? .checkmark : .none
    }
}
