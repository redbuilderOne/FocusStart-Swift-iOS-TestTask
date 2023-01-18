//
//  DateFormatter.swift
//  FocusStart-Swift-iOS-TestTask
//
//  Created by Дмитрий Скворцов on 18.01.2023.
//

import Foundation

struct DateConverter {

    static let shared = DateConverter()

    func formatDate() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY, MMM d, HH:mm:ss"
        return dateFormatter
    }

}
