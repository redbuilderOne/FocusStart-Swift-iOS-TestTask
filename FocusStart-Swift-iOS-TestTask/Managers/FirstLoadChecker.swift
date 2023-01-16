//
//  FirstLoadChecker.swift
//  FocusStart-Swift-iOS-TestTask
//
//  Created by Дмитрий Скворцов on 13.01.2023.
//

import Foundation

struct FirstLoadChecker {

    static let shared = FirstLoadChecker()

    enum SettingsKeys: String {
        case isFirstLoad
    }

    let defaults = UserDefaults.standard

    func check() {
        var initialStateLaunch = defaults.bool(forKey: SettingsKeys.isFirstLoad.rawValue)
        if !initialStateLaunch {
            print("first load initiated")
            initialStateLaunch = true
            defaults.set(initialStateLaunch, forKey: SettingsKeys.isFirstLoad.rawValue)
            CoreDataManager.shared.addHelloNote()
        } else {
            defaults.set(initialStateLaunch, forKey: SettingsKeys.isFirstLoad.rawValue)
            CoreDataManager.shared.fetchCoreData()
        }
    }

}
