//
//  UIColor+Extension.swift
//  ClientVK
//
//  Created by Vlad on 2.12.24.
//

import UIKit.UIColor

extension UIColor {
    public convenience init?(hex: String, alpha: Float = 1.0) {
        let r, g, b: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 6 {
                let scaner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scaner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: CGFloat(alpha))
                    return
                }
            }
        }
        return nil
    }
}
