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

    enum SettingsKeys: String {
        case isFirstLoad
    }

    let defaults = UserDefaults.standard

    init(note: Note? = nil) {
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func check() {
        var initialStateLaunch = defaults.bool(forKey: SettingsKeys.isFirstLoad.rawValue)
        if !initialStateLaunch {
            initialStateLaunch = true
            defaults.set(initialStateLaunch, forKey: SettingsKeys.isFirstLoad.rawValue)
            CoreDataManager.shared.addHelloNote()
        } else {
            defaults.set(initialStateLaunch, forKey: SettingsKeys.isFirstLoad.rawValue)
            CoreDataManager.shared.fetchCoreData()
        }
    }

}
