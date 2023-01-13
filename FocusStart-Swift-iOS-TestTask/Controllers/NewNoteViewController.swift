//
//  NewNoteViewController.swift
//  FocusStart-Swift-iOS-TestTask
//
//  Created by Дмитрий Скворцов on 13.01.2023.
//

import UIKit

class NewNoteViewController: UIViewController, UITextViewDelegate {

    var noteTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 24, weight: .light)
        textView.textColor = .label
        textView.backgroundColor = .systemBackground
        textView.autocorrectionType = UITextAutocorrectionType.no
        textView.keyboardType = UIKeyboardType.default
        textView.returnKeyType = UIReturnKeyType.done
        textView.text = "Введите текст заметки".localized()
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(noteTextView)
        noteTextView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        setupNavigationBar()
        noteTextView.delegate = self
    }

    private func setupNavigationBar() {
        title = "Новая заметка".localized()
        navigationController?.navigationBar.tintColor = .label
        navigationItem.backBarButtonItem = UIBarButtonItem()
        let doneItem = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .plain, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItem = doneItem
    }

    @objc private func doneButtonTapped() {
        print("doneButtonTapped")
    }

    deinit {
        print("NewNoteViewController deinit")
    }

}
