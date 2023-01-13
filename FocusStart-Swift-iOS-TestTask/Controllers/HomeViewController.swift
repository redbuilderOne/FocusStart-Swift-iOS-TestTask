//
//  ViewController.swift
//  FocusStart-Swift-iOS-TestTask
//
//  Created by Дмитрий Скворцов on 13.01.2023.
//

import UIKit
import Combine
import CoreData

class HomeViewController: UIViewController {

    static var notes: [Note] = []

    private let notesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NotesTableViewCell.self, forCellReuseIdentifier: NotesTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(notesTableView)
        FirstLoadChecker.shared.check()
        notesTableView.dataSource = self
        notesTableView.delegate = self
        notesTableView.frame = view.bounds
        setupNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        notesTableView.reloadData()
    }

    private func setupNavigationBar() {
        title = "Все заметки".localized()
        let addItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action:  #selector(addNewNote))
        navigationItem.rightBarButtonItem = addItem
        navigationItem.rightBarButtonItem?.tintColor = .label
    }

    @objc func addNewNote() {
        let newNoteViewController = NewNoteViewController()
        show(newNoteViewController, sender: self)
    }

}

// MARK: - Extension

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HomeViewController.notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotesTableViewCell.identifier) as? NotesTableViewCell else { fatalError() }
        cell.configure(with: HomeViewController.notes[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Alert.shared.noteTextEditAction(on: self, note: HomeViewController.notes[indexPath.row], tableView: notesTableView)
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataManager.shared.deleteNoteFromCoreData(note: HomeViewController.notes[indexPath.row])
            HomeViewController.notes.remove(at: indexPath.row)
            notesTableView.deleteRows(at: [indexPath], with: .fade)
            notesTableView.reloadData()
        }
    }

}
