//
//  UserDefaultsChoresManager.swift
//  ChoreChampion
//
//  Created by Rhythm Bhandari on 3/31/24.
//

import Foundation

class UserDefaultsChoresManager: ChoresManaging {
    private let userDefaults = UserDefaults.standard
    private let choresKey = "Chores"

    func fetchChores() -> [Chore] {
        guard let choresData = userDefaults.data(forKey: choresKey) else {
            return []
        }

        do {
            let chores = try JSONDecoder().decode([Chore].self, from: choresData)
            return chores
        } catch {
            print("Error decoding chores data: \(error)")
            return []
        }
    }

    func addChore(_ chore: Chore) {
        var chores = fetchChores()
        chores.append(chore)

        do {
            let encodedChores = try JSONEncoder().encode(chores)
            userDefaults.set(encodedChores, forKey: choresKey)
        } catch {
            print("Error encoding chores data: \(error)")
        }
    }

    func deleteChore(at index: Int) {
        
    }
}
