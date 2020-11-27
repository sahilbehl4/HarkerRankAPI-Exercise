//
//  NewsStoryTableViewCell.swift
//  TestProject
//
//  Created by Sahil Behl on 2020-11-23.
//  Copyright © 2020 sahil. All rights reserved.
//

import UIKit
import SnapKit

class NewsStoryTableViewCell: UITableViewCell {
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        design()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: Data) {
        titleLabel.text = data.titleText
        descriptionLabel.text = data.descriptionText
    }
    
    private func design() {
        self.addSubview(stackView)
//        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)


        stackView.snp.makeConstraints {
        $0.leadingMargin.bottomMargin.topMargin.trailingMargin.equalTo(10)
        }
    }
}

extension NewsStoryTableViewCell {
    struct Data {
        let titleText: String?
        let descriptionText: String?
    }
}
