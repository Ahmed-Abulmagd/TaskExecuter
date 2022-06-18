//
//  UITableView+Extension.swift
//  TaskExecuter
//
//  Created by Ahmed Abuelmagd on 18/06/2022.
//

import UIKit

extension UITableView {
    /**
     It register table view cell nib file to the table.
     ### For Example ###
     let me suppose that the outlet of table view is TV
     ````
     TV.registerNib(cell: DetailsCell.self)
     ````
     */
    func registerNib<Cell: UIView>(cellClass: Cell.Type){
        
        let nibName = String(describing: Cell.self)
        switch cellClass {
        case is UITableViewCell.Type: self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
            
        case is UITableViewHeaderFooterView.Type: self.register(UINib(nibName: nibName, bundle: nil), forHeaderFooterViewReuseIdentifier: nibName)
            
        default:
            fatalError("Error in cell")
        }
    }
    /**
     It dequeue the cell in cellForRowAt.
     ## Important Notes ##
     we call that function in cellForRowAt
     ### For Example ###
     ````
     cell = tableview.dequeue() as DetailsCell
     return cell
     ````
     */
    func dequeue<Cell: UIView>() -> Cell{
        let identifier = String(describing: Cell.self)
        switch Cell.self {
        case is UITableViewCell.Type: guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? Cell else {
            fatalError("Error in cell")
        }
            return cell
        case is UITableViewHeaderFooterView.Type: guard let cell = self.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? Cell else {
            fatalError("Error in cell")
        }
            return cell
        default:
            fatalError("Error in cell")
        }
    }
    func scrollToBottom(animated: Bool, numOfSections: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            let numberOfSections = numOfSections
            let numberOfRows = self.numberOfRows(inSection: numberOfSections-1)
            
            if numberOfRows > 0 {
                let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
            }
        }
    }
    
    func scrollToTop(animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
}
class ContentSizedTableView: UITableView {
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}


