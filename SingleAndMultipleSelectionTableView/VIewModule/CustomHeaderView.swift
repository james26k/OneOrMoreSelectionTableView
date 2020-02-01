//
//  CustomHeaderView.swift
//  SingleAndMultipleSelectionTableView
//
//  Created by Kohei Hayashi on 2020/02/01.
//  Copyright © 2020 Kohei Hayashi. All rights reserved.
//

import Foundation
import UIKit

final class CustomHeaderView: UIView {
    let headerTitleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        headerTitleLabel.tintColor = .label
        headerTitleLabel.font = .boldSystemFont(ofSize: 16)
        headerTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(headerTitleLabel)
        headerTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        headerTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        headerTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(headerTitle: String) {
        headerTitleLabel.text = headerTitle
    }
}
