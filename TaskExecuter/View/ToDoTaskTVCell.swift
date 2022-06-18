//
//  tasksTVCell.swift
//  TaskExecuter
//
//  Created by Ahmed Abuelmagd on 18/06/2022.
//

import UIKit

class ToDoTaskTVCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var taskTitleLbl: UILabel!
}

extension ToDoTaskTVCell{
    // MARK: - Init Cell
    func initCell(task: TodoTask){
        let attributtedTask = task.taskTitle
        let boldAttribute = [NSAttributedString.Key.font: UIFont(name: Fonts.BOLD.rawValue, size: 17)!,
                          NSAttributedString.Key.foregroundColor: UIColor.black]
        let regularAttribute = [NSAttributedString.Key.font: UIFont(name: Fonts.REGULAR.rawValue, size: 16)!,
                          NSAttributedString.Key.foregroundColor: UIColor.black]
        let textCombination = NSMutableAttributedString()
            textCombination.append(NSAttributedString(string: task.tasktime, attributes: regularAttribute))
            textCombination.append(NSAttributedString(string: " \(attributtedTask)", attributes: boldAttribute))
        
        taskTitleLbl.attributedText = textCombination
        
    }
}
