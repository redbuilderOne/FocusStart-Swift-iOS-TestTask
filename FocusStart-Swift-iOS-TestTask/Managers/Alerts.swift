//
//  Alerts.swift
//  FocusStart-Swift-iOS-TestTask
//
//  Created by Дмитрий Скворцов on 13.01.2023.
//

import UIKit

struct Alert {

    static let shared = Alert()

    func isEmptyCheck(on viewController: UIViewController, with title: String? = nil, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок".localized(), style: .cancel, handler: nil))
        viewController.present(alert, animated: true)
    }

    func noteTextEditAction(on viewController: UIViewController, note: Note, tableView: UITableView) {
        let actionController = UIAlertController(title: "".localized(), message: "Измените заметку".localized(), preferredStyle: .alert)

        actionController.addTextField{ (newText) in
            newText.text = note.noteText
        }

        let cancelAction = UIAlertAction(title: "Отмена".localized(), style: .cancel, handler: { (action) -> Void in
            viewController.presentingViewController?.dismiss(animated: true, completion: nil)
        })

        let okayAction = UIAlertAction(title: "Ок".localized(), style: .default, handler: { (action) -> Void in
            note.noteText = (actionController.textFields?.first?.text)!

            let context = CoreDataManager.shared.loadPersistentContainer()

                do {
                    try context.save()
                } catch {
                    print("Can't save the context")
                }

            DispatchQueue.main.async {
                tableView.reloadData()
            }

            viewController.presentingViewController?.dismiss(animated: true, completion: nil)
        })

        actionController.addAction(okayAction)
        actionController.addAction(cancelAction)
        viewController.present(actionController, animated: true, completion: nil)
    }

}
