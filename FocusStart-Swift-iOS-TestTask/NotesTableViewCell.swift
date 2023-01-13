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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(noteTextLabel)
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
    }

    public func configure(with note: Note) {
        self.noteTextLabel.text = note.noteText
    }

}
