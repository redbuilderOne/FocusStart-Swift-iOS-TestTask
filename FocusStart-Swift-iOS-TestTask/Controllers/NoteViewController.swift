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

    private var editedDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .thin)
        label.textColor = .label
        label.textAlignment = .center
        label.text = "editedDateLabel"
        label.isHidden = true
        return label
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
        view.addSubview(editedDateLabel)
        noteTextView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        setupNavigationBar()
        noteTextView.delegate = self
        loadSelectedNoteText()
        setSwipesGestureSettings()
    }

    private func animateFrames(swipeDown: Bool) {
        if swipeDown {
            noteTextView.frame = CGRect(x: 0, y: 120, width: view.frame.width, height: view.frame.height)
            editedDateLabel.frame = CGRect(x: 0, y: 90, width: view.frame.width, height: 30)
            editedDateLabel.isHidden = false
        } else {
            noteTextView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
            editedDateLabel.isHidden = true
        }
    }

    private func setSwipesGestureSettings() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToDownSwipeGesture))
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToUpSwipeGesture))

        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up

        view.addGestureRecognizer(swipeDown)
        view.addGestureRecognizer(swipeUp)
    }

    @objc private func respondToDownSwipeGesture() {
        UILabel.animate(withDuration: 0.3) {
            self.animateFrames(swipeDown: true)
        }
    }

    @objc private func respondToUpSwipeGesture() {
        UILabel.animate(withDuration: 0.3) {
            self.animateFrames(swipeDown: false)
        }
    }

    private func loadSelectedNoteText() {
        if note != nil {
            noteTextView.text = note?.noteText
            editedDateLabel.text = DateConverter.shared.formatDate().string(from: note?.editedDate ?? Date())
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
        var createdDate: Date?
        switch note {
        case nil:
            print("note is nil")
        default:
            if let note, let selectedIndex {
                guard let previousNote = findPreviosNote(string: note.noteText ?? "") else {
                    print("не удалось найти предыдущую заметку")
                    return
                }
                createdDate = previousNote.createdDate
                CoreDataManager.shared.deleteNoteFromCoreData(note: previousNote)
                HomeViewController.notes.remove(at: selectedIndex)
            }
        }
        if createdDate == nil {
            createdDate = Date()
        }
        CoreDataManager.shared.saveNewNoteToCoreDataFromTextView(noteTextView: noteTextView, createdDate: createdDate, editedDate: Date(), viewController: self)
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
