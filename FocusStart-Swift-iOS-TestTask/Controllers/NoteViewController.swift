//
//  NewNoteViewController.swift
//  FocusStart-Swift-iOS-TestTask
//
//  Created by Дмитрий Скворцов on 13.01.2023.
//

import UIKit
import CoreData

class NoteViewController: UIViewController, UITextViewDelegate {

    var note: Note? = nil
    var selectedIndex: Int? = nil

    var noteTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 24, weight: .light)
        textView.textColor = .label
        textView.backgroundColor = .systemBackground
        textView.autocorrectionType = UITextAutocorrectionType.no
        textView.keyboardType = UIKeyboardType.default
        textView.returnKeyType = UIReturnKeyType.done
        return textView
    }()

    init(note: Note? = nil, selectedIndex: Int? = nil) {
        self.note = note
        self.selectedIndex = selectedIndex
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(noteTextView)
        noteTextView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        setupNavigationBar()
        noteTextView.delegate = self
        loadSelectedNoteText()
    }

    private func loadSelectedNoteText() {
        if note != nil {
            noteTextView.text = note?.noteText
        }
    }

    private func setupNavigationBar() {
        title = "Новая заметка".localized()
        navigationController?.navigationBar.tintColor = .label
        navigationItem.backBarButtonItem = UIBarButtonItem()
        let doneItem = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .plain, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItem = doneItem
    }

    @objc private func doneButtonTapped() {
        CoreDataManager.shared.saveNewNoteToCoreData(noteTextView: noteTextView, viewController: self)
        switch note {
        case nil:
            print("case nil")
        default:
            if let note, let selectedIndex {
                guard let previousNote = findPreviosNote(string: note.noteText ?? "") else { return }
                CoreDataManager.shared.deleteNoteFromCoreData(note: previousNote)
                HomeViewController.notes.remove(at: selectedIndex)
            }
            print("default")
        }
        navigationController?.popViewController(animated: true)
    }

    private func findPreviosNote(string: String) -> Note? {
        var selectedNote: Note
        for note in HomeViewController.notes {
            if note.noteText == string {
                selectedNote = note
                return selectedNote
            } else {
                print("не удалось найти текст")
            }
        }
        return nil
    }

    deinit {
        print("NewNoteViewController deinit")
        note = nil
        selectedIndex = nil
    }

}
