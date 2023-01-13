//
//  NewNoteAlert.swift
//  FocusStart-Swift-iOS-TestTask
//
//  Created by Дмитрий Скворцов on 13.01.2023.
//

import UIKit
import CoreData

struct NoteEditAlert {
    
    static let shared = NoteEditAlert()
    
    func newNoteAction() {
        
    }
}

    /*

    func editNoteTitleAction(on viewController: UIViewController, note: Note, tableView: UITableView) {

        let action = UIAlertController(title: "Название".localized(), message: "".localized(), preferredStyle: .alert)
        action.addTextField(configurationHandler: { (newTitle) -> Void in
            newTitle.text = note.noteText
        })

        let cancelAction = UIAlertAction(title: "Отмена".localized(), style: .cancel, handler: { (action) -> Void in
            viewController.presentingViewController?.dismiss(animated: true, completion: nil)
        })

        let okayAction = UIAlertAction(title: "Ок".localized(), style: .default, handler: { (action) -> Void in
            note.noteText = (action.textFields?.first?.text)!

//            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
//            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

            do {
//                try context.save()
                try CoreDataSaver.shared.loadPersistentContainer().save()
            } catch {
                print("Can't save the context")
            }

            }

            DispatchQueue.main.async {
            tableView.reloadData()
            }

            viewController.presentingViewController?.dismiss(animated: true, completion: nil)
        })

        action.addAction(okayAction)
        action.addAction(cancelAction)
        viewController.present(action, animated: true, completion: nil)

}

*/
