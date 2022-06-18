//
//  UIView+Extension.swift
//  TaskExecuter
//
//  Created by Ahmed Abuelmagd on 18/06/2022.
//

import UIKit


extension UIView {
    
    func addRadius(radius : CGFloat) {
        self.layer.cornerRadius = radius*iPhoneXFactor
    }
    func addBorder(borderColor : Colors = .CE6E7E7, borderWidth : CGFloat = 1) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = UIColor(hexString: borderColor.rawValue).cgColor
    }
}
