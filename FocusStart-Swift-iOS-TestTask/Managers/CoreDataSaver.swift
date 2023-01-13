//
//  CoreDataSaver.swift
//  FocusStart-Swift-iOS-TestTask
//
//  Created by Дмитрий Скворцов on 13.01.2023.
//

import UIKit
import CoreData

class CoreDataSaver {

    static let shared = CoreDataSaver()

    func loadPersistentContainer() -> NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        return context
    }

    func createCoreDataNewNote(controller: HomeViewController? = nil, noteString: String, entity: NSEntityDescription, insertInto: NSManagedObjectContext) -> Note {

        let newNote = Note(entity: entity, insertInto: loadPersistentContainer())
        newNote.noteText = noteString
        return newNote

    }

}
