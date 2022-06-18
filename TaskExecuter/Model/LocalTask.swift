//
//  LocalTask.swift
//  TaskExecuter
//
//  Created by Ahmed Abuelmagd on 18/06/2022.
//

import Foundation

struct LocalTask: Codable {
    let id: Int
    let title: String
    var isSelected: Bool = false
}

struct TodoTask{
    let tasktime: String
    let taskTitle: String
}
