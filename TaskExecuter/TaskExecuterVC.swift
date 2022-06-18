//
//  ViewController.swift
//  TaskExecuter
//
//  Created by Ahmed Abuelmagd on 18/06/2022.
//

import UIKit
import Combine


let value = 3
let semaphore = DispatchSemaphore(value: value)
let queue = DispatchQueue(label: "heavyTask", attributes: .concurrent)

class TaskExecuterVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tasksView: UIView!
    @IBOutlet weak var tasksTV: UITableView!
    @IBOutlet weak var buttonsActionView: UIView!
    @IBOutlet weak var buttonsCV: UICollectionView!
    
    
    // MARK: - Properties
    private var tVCellHeight = 26*iPhoneXFactor
    private var anyCancellable = Set<AnyCancellable>()
    private let viewModel = TasksViewModel()
    private var localTasks: [LocalTask]?
    
    var todoTasks: [TodoTask] = [] {
        didSet {
            tasksTV.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        bindToViewModel()
        Task { await viewModel.getLocalTask() }
    }
    private func bindToViewModel () {
        viewModel.$tasks
            .receive(on: DispatchQueue.main)
            .sink { [ weak self] tasks in
                guard let self = self else { return }
                self.localTasks = tasks
                self.buttonsCV.reloadData()
            }.store(in: &anyCancellable)
    }
}

extension TaskExecuterVC{
    func initUI(){
        initTV(tv: tasksTV)
        initCV(cv: buttonsCV)
        for view in [tasksView,buttonsActionView]{
            view?.addRadius(radius: 7.5)
            view?.addBorder(borderColor: .CE6E7E7, borderWidth: 1)
        }
        
    }
    func initTV(tv: UITableView){
        tv.dataSource = self
        tv.delegate = self
        tv.registerNib(cellClass: ToDoTaskTVCell.self)
    }
    func initCV(cv: UICollectionView){
        cv.dataSource = self
        cv.delegate = self
        cv.registerCVNib(cell: TaskCVCell.self)
    }
    
    func heavyTask(task: LocalTask){
        var counter = 0
        for i in 0..<Int.random(in: 1...10000000){
            counter += i
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.todoTasks.append(TodoTask(tasktime: self?.getCurrentDate() ?? "", taskTitle: task.title))
        }
    }
    
    func implementHeavyTask(task: LocalTask) {
        queue.async { [weak self] in
            //lock shared resource access
            semaphore.wait()
            
            //heavy Task
            self?.heavyTask(task: task)
            
            // Release the lock
            semaphore.signal()
        }
    }
}

// MARK: - UITableViewDataSource
extension TaskExecuterVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as ToDoTaskTVCell
        cell.initCell(task: todoTasks[indexPath.row])
        return cell
    }
}
// MARK: - UITableViewDelegate
extension TaskExecuterVC: UITableViewDelegate{

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tVCellHeight
    }
}

// MARK: - UICollectionViewDelegate
extension TaskExecuterVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for i in 0..<(localTasks?.count ?? 0) {
            localTasks?[i].isSelected = false
        }
        localTasks?[indexPath.item].isSelected.toggle()
        buttonsCV.reloadData()
        if let task = localTasks?[indexPath.item] {
            implementHeavyTask(task: task)
        }
    }
}
// MARK: - UICollectionViewDataSource
extension TaskExecuterVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return localTasks?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCV(index: indexPath) as TaskCVCell
        if let localTask = localTasks?[indexPath.item] {
            cell.initCell(cellData: localTask)
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension TaskExecuterVC : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        let width = (collectionView.frame.width / 4)
        let size = CGSize(width: width, height: height)
        return size
    }
}
