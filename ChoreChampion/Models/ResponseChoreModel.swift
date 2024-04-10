//
//  ResponseChoreModel.swift
//  ChoreChampion
//
//  Created by Rhythm Bhandari on 4/10/24.
//

import Foundation

struct ResponseChore: Codable {
    let assignee: String?
    let dateCompleted: String?
    let name: String
    let status: Int
    let taskType: Int
}
