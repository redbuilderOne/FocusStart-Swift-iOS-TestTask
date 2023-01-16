//
//  CoreDataSaver.swift
//  FocusStart-Swift-iOS-TestTask
//
//  Created by Дмитрий Скворцов on 13.01.2023.
//

import UIKit
import CoreData

struct CoreDataManager {

    static let shared = CoreDataManager()

    func loadPersistentContainer() -> NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        return context
    }

    private func loadEntity(context: NSManagedObjectContext) -> NSEntityDescription {
        guard let entity = NSEntityDescription.entity(forEntityName: "Note", in: context) else { fatalError() }
        return entity
    }

    private func tryContextSave(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("Can't save the context")
        }
    }

    func addHelloNote() {
        let context = CoreDataManager.shared.loadPersistentContainer()
        let entity = loadEntity(context: context)
        let _ = self.createCoreDataNewNote(noteString: "Ваша первая заметка".localized(), entity: entity, insertInto: context)
        tryContextSave(context: context)
        fetchCoreData()
    }

    func fetchCoreData() {
        let context = self.loadPersistentContainer()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")

        do {
            let results: NSArray = try context.fetch(request) as NSArray
            for result in results {
                let note = result as! Note
                HomeViewController.notes.append(note)
            }
        } catch {
            print("Fetch failed")
        }
    }

    func createCoreDataNewNote(controller: HomeViewController? = nil, noteString: String, createdDate: Date? = nil, editedDate: Date? = nil, entity: NSEntityDescription, insertInto: NSManagedObjectContext) -> Note {
        let newNote = Note(entity: entity, insertInto: loadPersistentContainer())
        newNote.noteText = noteString
        newNote.createdDate = createdDate
        newNote.editedDate = editedDate
        return newNote
    }

    func saveNewNoteToCoreDataFromTextView(noteTextView: UITextView? = nil, createdDate: Date? = nil, editedDate: Date? = nil, viewController: UIViewController? = nil) {
        let context = self.loadPersistentContainer()
        let entity = loadEntity(context: context)

        if let noteTextView, let viewController {
            if !noteTextView.text.isEmpty {
                let newNote = self.createCoreDataNewNote(noteString: noteTextView.text, createdDate: createdDate, editedDate: editedDate, entity: entity, insertInto: context)
                tryContextSave(context: context)
                print("Note: \(newNote.noteText ?? "") is created at \(String(describing: newNote.createdDate)) saved at \(String(describing: newNote.editedDate))")
                HomeViewController.notes.append(newNote)
            } else {
                Alert.shared.isEmptyCheck(on: viewController, message: "Заметка не может быть пустой")
                return
            }
        }
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
