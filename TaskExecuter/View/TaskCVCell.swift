//
//  ButtonsCVCell.swift
//  TaskExecuter
//
//  Created by Ahmed Abuelmagd on 18/06/2022.
//

import UIKit

class TaskCVCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var taskNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.addRadius(radius: 7)
    }

}

extension TaskCVCell{
    // MARK: - Init Cell
    func initCell(cellData: LocalTask){
        taskNameLbl.text = cellData.title
        mainView.backgroundColor = cellData.isSelected ? .black : .white
        taskNameLbl.textColor = cellData.isSelected ? .white : .black
    }
}
