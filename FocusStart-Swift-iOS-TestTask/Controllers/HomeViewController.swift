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
        FirstLoadChecker.shared.firstLoadTableCheck()
        notesTableView.dataSource = self
        notesTableView.frame = view.bounds
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        title = "Все заметки".localized()
        navigationItem.leftBarButtonItem = self.editButtonItem
        navigationItem.leftBarButtonItem?.tintColor = .label
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

        DispatchQueue.main.async { [weak self] in
            self?.notesTableView.reloadData()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotesTableViewCell.identifier) as? NotesTableViewCell else { fatalError() }
    }
}

