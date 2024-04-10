//
//  InMemoryChoresManager.swift
//  ChoreChampion
//
//  Created by Rhythm Bhandari on 3/31/24.
//

import Foundation

class InMemoryChoresManager: ChoresManaging {
    func updateChore(at index: Int, chore: Chore) {
        
    }
    
    private var chores: [Chore] = []

    func fetchChores() -> [Chore] {
        return chores
    }

    func addChore(_ chore: Chore) {
        chores.append(chore)
    }

    func deleteChore(at index: Int) {
        if chores.indices.contains(index) {
            chores.remove(at: index)
        }
    }

    init() {
        loadDefaultChores()
    }
    
    private func loadDefaultChores() {
        let dateFormatter = DateFormatter()

        chores.append(Chore(id: UUID().uuidString, title: "First Chore", status: ChoreStatus.completed, type: ChoreType.authentication, assignee: "John Doe", completionDate: dateFormatter.date(from: "03-31-2024") ))
        
        
        chores.append(Chore(id: UUID().uuidString, title: "Second Chore", status: ChoreStatus.completed, type: ChoreType.design, assignee: "Another John", completionDate: dateFormatter.date(from: "04-01-2024")))
        
        
        chores.append(Chore(id: UUID().uuidString, title: "Third Chore", status: ChoreStatus.completed, type: ChoreType.deliverables, assignee: "Another Doe", completionDate: dateFormatter.date(from: "04-02-2024")))
    }
}
