//
//  Date+Extension.swift
//  ClientVK
//
//  Created by Vlad on 3.12.24.
//

import Foundation

extension Date {
    func getCustomFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm dd.MM.yy"
        let formattedDate = dateFormatter.string(from: self)
        return "В \(formattedDate)"
    }
}
