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

}


