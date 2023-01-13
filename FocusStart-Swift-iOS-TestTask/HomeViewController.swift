//
//  ViewController.swift
//  FocusStart-Swift-iOS-TestTask
//
//  Created by Дмитрий Скворцов on 13.01.2023.
//

import UIKit

class HomeViewController: UIViewController {


    private let notesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NotesTableViewCell.self, forCellReuseIdentifier: NotesTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(notesTableView)
        notesTableView.dataSource = self
        notesTableView.frame = view.bounds

    }


}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()

    }
}

