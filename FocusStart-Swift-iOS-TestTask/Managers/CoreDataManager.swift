//
//  CoreDataSaver.swift
//  FocusStart-Swift-iOS-TestTask
//
//  Created by Дмитрий Скворцов on 13.01.2023.
//

import UIKit
import CoreData

class CoreDataManager {

    static let shared = CoreDataManager()

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

    func deleteNoteFromCoreData(note: Note) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }

        do {
            appDelegate.persistentContainer.viewContext.delete(note)
            try appDelegate.persistentContainer.viewContext.save()
            print("\(note.noteText ?? "") is deleted from CoreData")
        } catch {
            print("Deletion is failed")
        }
    }

}
