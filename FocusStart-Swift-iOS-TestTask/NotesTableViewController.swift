//
//  NotesTableViewController.swift
//  FocusStart-Swift-iOS-TestTask
//
//  Created by Дмитрий Скворцов on 13.01.2023.
//

import UIKit
import CoreData

class NotesTableViewController: UITableViewController {

    static var identifier: String {
        return NSStringFromClass(self)
    }

    var activityDetailedViewController: UITabBarController?
    var homeViewController = HomeViewController()


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        configureTableView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        view.backgroundColor = .systemBackground
    }

    private func configureTableView() {
//        tableView.register(ActivitiesTableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.rowHeight = 40
        tableView.estimatedRowHeight = 80
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupNavigationBar() {
        self.title = "Заметки".localized()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.leftBarButtonItem?.tintColor = .label
        let addItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action:  #selector(addNewActivity))
        self.navigationItem.rightBarButtonItem = addItem
        self.navigationItem.rightBarButtonItem?.tintColor = .label
    }

    @objc func addNewActivity() {
//        let newActivityVC = NewActivityViewController()
//        newActivityVC.actionHandler = { [weak newActivityVC] in
//            newActivityVC?.dismiss(animated: true, completion: nil)
//        }
//        show(newActivityVC, sender: self)
    }

    @objc func cellDidTapped() {
        if let activityDetailedViewController = activityDetailedViewController {
            present(activityDetailedViewController, animated: true)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

