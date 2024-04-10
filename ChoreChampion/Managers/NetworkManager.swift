//
//  NetworkManager.swift
//  ChoreChampion
//
//  Created by Rhythm Bhandari on 4/10/24.
//

import Foundation

class NetworkManager {
    static func fetchChores(authToken: String, completion: @escaping ([Chore]?, Error?) -> Void) {
        let endPoint = "https://info-6125-5c725-default-rtdb.firebaseio.com/w24/project.json?auth=\(authToken)"
        
        guard let url: URL = URL(string: endPoint) else {
            let error = FetchError.invalidURL
            completion(nil, error)
            return
        }
        
        let urlSession = URLSession(configuration: .default)
        
        let task = urlSession.dataTask(with: url) { data, response, error in
            print("In fetchChores completion handler")
            if let error = error {
                print("Error fetching chores: \(error)")
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                let error = FetchError.invalidServerResponse
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                print("No data received")
                let error = FetchError.noDataReceived
                completion(nil, error)
                return
            }
            
            let parsedChores = parseChoresData(data: data)
            completion(parsedChores, nil)
        }
        task.resume()
    }
    
    static func parseChoresData(data: Data) -> [Chore]? {
        let decoder = JSONDecoder()
        do {
            let choresDictionary = try decoder.decode([String: ResponseChore].self, from: data)
            let chores = choresDictionary.map { (key, value) -> Chore in
                return Chore(
                    id: key,
                    title: value.name,
                    status: convertStatus(value.status),
                    type: convertType(value.taskType),
                    assignee: value.assignee,
                    completionDate: value.dateCompleted != nil ? dateFormatter.date(from: value.dateCompleted!) : nil
                )
            }
            return chores
        } catch {
            print("Error parsing chores data: \(error)")
            return nil
        }
    }
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    private static func convertStatus(_ status: Int) -> ChoreStatus {
        guard let choreStatus = ChoreStatus(rawValue: status) else {
            return .notStarted
        }
        return choreStatus
    }
    
    private static func convertType(_ type: Int) -> ChoreType {
        guard let choreType = ChoreType(rawValue: type - 1) else {
            return .authentication
        }
        return choreType
    }
}

enum FetchError: Error {
    case invalidURL
    case invalidServerResponse
    case noDataReceived
}
