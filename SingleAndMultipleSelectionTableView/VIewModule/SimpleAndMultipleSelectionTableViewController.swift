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
    private let tableView = UITableView(frame: .zero, style: .grouped)

    private let sections = ["お好きな銭湯", "サウナ温度", "水風呂温度", "hoge"]
    private let cellTitles = [
        ["光明泉", "文化浴泉", "北欧", "八幡湯", "かるまる"],
        ["81~85", "86~90", "91~95", "96~100", "100度越えがお好き"],
        ["25~21", "20~18", "17~15", "かるまるのサンダートルネードくらいくキンキンで"],
        ["hoge", "hoge", "hoge", "hoge", "hoge",
         "hoge", "hoge", "hoge", "hoge", "hoge",
         "hoge", "hoge", "hoge", "hoge", "hoge"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        tableView.backgroundColor = .secondarySystemBackground
        tableView.tableFooterView = UIView()
        // UITableView全体は複数選択可能に設定
        tableView.allowsMultipleSelection = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        view.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
    }
}

extension SimpleAndMultipleSelectionTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellTitles[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath)
        cell.textLabel?.text = cellTitles[indexPath.section][indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}

extension SimpleAndMultipleSelectionTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        // SingleSelectionSectionであれば処理を通す
        guard sections[indexPath.section] == "お好きな銭湯" else { return indexPath }
        // tableViewから選択されているIndexPathの配列を取得
        guard let selectedIndexPaths = tableView.indexPathsForSelectedRows else { return indexPath }
        selectedIndexPaths.filter {
            // 選択したCell以外で既に選択されているIndexPathに絞る
            sections[$0.section] == "お好きな銭湯" && $0 != indexPath
        }.forEach {
            // 非選択状態にする
            tableView.deselectRow(at: $0, animated: true)
        }
        return indexPath
    }

    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        // 既に選択済みのCellであればnilを返して非選択処理を弾く
        return sections[indexPath.section] == "お好きな銭湯" ? nil : indexPath
    }
}

private final class CustomCell: UITableViewCell {
    // Cellが生成されるタイミングでselectedの状態がtrueならチェックを付ける
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        accessoryType = selected ? .checkmark : .none
    }
}
