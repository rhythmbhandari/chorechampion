//
//  ChoresManaging.swift
//  ChoreChampion
//
//  Created by Rhythm Bhandari on 3/31/24.
//

import Foundation

protocol ChoresManaging {
    func fetchChores () -> [Chore]
    func addChore(_ chore: Chore)
    func deleteChore(at index: Int)
}
