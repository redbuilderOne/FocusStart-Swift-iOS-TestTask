//
//  NotesTableViewCell.swift
//  FocusStart-Swift-iOS-TestTask
//
//  Created by Дмитрий Скворцов on 13.01.2023.
//

import UIKit
import Combine

class NotesTableViewCell: UITableViewCell {

    static var identifier: String {
            return NSStringFromClass(self)
        }

    var noteTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()

    var editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(noteTextLabel)
        contentView.addSubview(editButton)
        editButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func didTapEditButton() {
        print("tap")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        noteTextLabel.frame = CGRect(x: 20, y: 0, width: contentView.frame.size.width - 20, height: contentView.frame.size.height - 6)
        setConstraints()
    }

    private func setConstraints() {
        let editButtonConstraints = [
            editButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            editButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: contentView.frame.size.width - 40),
            editButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            editButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            editButton.widthAnchor.constraint(equalToConstant: contentView.frame.size.width - 20),
            editButton.heightAnchor.constraint(equalToConstant: contentView.frame.size.height - -6)
        ]

        NSLayoutConstraint.activate(editButtonConstraints)
    }

}
