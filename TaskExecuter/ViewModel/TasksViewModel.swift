//
//  TasksViewModel.swift
//  TaskExecuter
//
//  Created by Ahmed Abuelmagd on 18/06/2022.
//

import Foundation
import Combine

class TasksViewModel {
    @Published private (set) var tasks: [LocalTask] = []
    
    func getLocalTask() async {
        let localTasks = await loadLocalTasks()
        tasks = localTasks ?? []
    }
    
    private func loadLocalTasks() async -> [LocalTask]? {
        guard let url = Bundle.main.url(forResource: "LocalTasks", withExtension: "json") else {
            fatalError()
        }
        do {
            let data = try Data(contentsOf: url)
            let localTasks = try JSONDecoder().decode([LocalTask].self, from: data)
            return localTasks
        } catch {
            print("error\(error)")
        }
        return nil
    }
}
