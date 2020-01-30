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

    private let sections = ["銭湯", "サウナ", "水風呂", "hoge"]
    private let cellTitles = [
        ["光明泉", "文化浴泉", "北欧", "八幡湯"],
        ["81~85", "86~90", "91~95", "96~100", ""],
        ["25~21", "20~18", "17~15", ""],
        ["hoge", "hoge", "hoge", "hoge", "hoge",
         "hoge", "hoge", "hoge", "hoge", "hoge",
         "hoge", "hoge", "hoge", "hoge", "hoge"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .secondarySystemBackground
        tableView.tableFooterView = UIView()
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
        headerView.setup(title: sections[section])
        return headerView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath)
        cell.textLabel?.text = cellTitles[indexPath.section][indexPath.row]
        return cell
    }
}

extension SimpleAndMultipleSelectionTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if sections[indexPath.section] == "銭湯" {
            return nil
        } else {
            return indexPath
        }
    }

}

final class CustomHeaderView: UIView {
    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.tintColor = .label
        titleLabel.font = .boldSystemFont(ofSize: 14)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(title: String) {
        titleLabel.text = title
    }
}

final class CustomCell: UITableViewCell {
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        accessoryType = selected ? .checkmark : .none
    }
}
