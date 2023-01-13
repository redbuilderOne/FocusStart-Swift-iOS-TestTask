//
//  FirstLoadChecker.swift
//  FocusStart-Swift-iOS-TestTask
//
//  Created by Дмитрий Скворцов on 13.01.2023.
//

import Foundation
import CoreData

class FirstLoadChecker {

    static let shared = FirstLoadChecker()

    var firstLoad = true

    init(note: Note? = nil) {
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func firstLoadTableCheck() {
        if firstLoad {
            firstLoad = false
            let context = CoreDataSaver.shared.loadPersistentContainer()
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
    }

}
