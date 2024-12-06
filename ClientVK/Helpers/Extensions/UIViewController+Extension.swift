//
//  UIViewController+Extension.swift
//  ClientVK
//
//  Created by Vlad on 4.12.24.
//

import UIKit

extension UIViewController {
    
    //MARK: Overlay
    func addOverlay() {
        let overlayView = UIView(frame: view.bounds)
        overlayView.backgroundColor = .black.withAlphaComponent(0.5)
        overlayView.tag = 100
        view.addSubview(overlayView)
    }

    func removeOverlay() {
        if let overlayView = view.viewWithTag(100) {
            overlayView.removeFromSuperview()
        }
    }
    
    //MARK: Alert
    func presentErrorAlert(message: String, okTitle: String = "Хорошо") {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default)
        alert.addAction(okAction)
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }
}
