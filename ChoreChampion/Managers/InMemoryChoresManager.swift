//
//  InMemoryChoresManager.swift
//  ChoreChampion
//
//  Created by Rhythm Bhandari on 3/31/24.
//

import Foundation

class InMemoryChoresManager: ChoresManaging {
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
        chores.append(Chore(title: "First Chore", description: "First Description", status: .completed, annotation: "First Annotation"))
        chores.append(Chore(title: "Second Chore", description: "Second Description", status: .inProgress, annotation: "Second Annotation"))
        chores.append(Chore(title: "Third Chore", description: "Third Description", status: .notStarted, annotation: "Third Annotation"))
    }
}
