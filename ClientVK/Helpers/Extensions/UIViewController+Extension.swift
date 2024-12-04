//
//  UIViewController+Extension.swift
//  ClientVK
//
//  Created by Vlad on 4.12.24.
//

import UIKit

extension UIViewController {
    
    func presentErrorAlert(message: String, okTitle: String = "Хорошо") {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default)
        alert.addAction(okAction)
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }
}
