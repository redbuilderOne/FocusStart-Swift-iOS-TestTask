//
//  NotesTableViewCell.swift
//  FocusStart-Swift-iOS-TestTask
//
//  Created by Дмитрий Скворцов on 13.01.2023.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

    var noteTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        label.textAlignment = .left
        label.text = "title"
        return label
    }()

    static var identifier: String {
            return NSStringFromClass(self)
        }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(noteTextLabel)
//        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        noteTextLabel.frame = CGRect(x: 10, y: 5, width: contentView.frame.size.width - 20, height: contentView.frame.size.height - 6)
    }

}
