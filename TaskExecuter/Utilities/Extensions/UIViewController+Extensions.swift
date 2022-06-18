//
//  UIViewController+Extensions.swift
//  TaskExecuter
//
//  Created by Ahmed Abuelmagd on 18/06/2022.
//

import UIKit

extension UIViewController{
    
    func getCurrentDate()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let time = dateFormatter.string(from: Date())
        return time
    }
}
