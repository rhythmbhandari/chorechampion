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
    
    func addChores(_ newChores: [Chore]) {
        var existingChores = fetchChores()
        
        for newChore in newChores {
            if let index = existingChores.firstIndex(where: { $0.id == newChore.id }) {
                existingChores[index] = newChore
            } else {
                existingChores.append(newChore)
            }
        }
        
        do {
            let encodedChores = try JSONEncoder().encode(existingChores)
            userDefaults.set(encodedChores, forKey: choresKey)
        } catch {
            print("Error encoding chores data: \(error)")
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
    
    func updateChore(at index: Int, chore: Chore) {
        var chores = fetchChores()
        guard index >= 0 && index < chores.count else {
            print("Index out of range")
            return
        }
        chores[index] = chore
        
        do {
            let encodedChores = try JSONEncoder().encode(chores)
            userDefaults.set(encodedChores, forKey: choresKey)
        } catch {
            print("Error encoding updated chores data: \(error)")
        }
    }
    
    func deleteChore(at index: Int) {
        var chores = fetchChores()
        guard index >= 0 && index < chores.count else {
            print("Index out of range")
            return
        }
        
        chores.remove(at: index)
        
        do {
            let encodedChores = try JSONEncoder().encode(chores)
            userDefaults.set(encodedChores, forKey: choresKey)
        } catch {
            print("Error encoding chores data after deletion: \(error)")
        }
    }
}
