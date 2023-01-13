//
//  Localisation.swift
//  FocusStart-Swift-iOS-TestTask
//
//  Created by Дмитрий Скворцов on 13.01.2023.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self,
                                 tableName: "Localizable",
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }
}

