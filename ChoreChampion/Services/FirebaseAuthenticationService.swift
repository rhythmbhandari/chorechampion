//
//  FirebaseAuthenticationService.swift
//  ChoreChampion
//
//  Created by Rhythm Bhandari on 3/30/24.
//

import Foundation
import FirebaseAuth

class FirebaseAuthenticationService: AuthenticationDelegate {
    func signIn(with credentials: Credentials, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: credentials.email, password: credentials.password) {  (authResult, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    func getToken(completion: @escaping (Result<String, Error>) -> Void) {
            guard let currentUser = Auth.auth().currentUser else {
                let error = AuthenticationError.noAuthenticatedUser
                completion(.failure(error))
                return
            }
            
            currentUser.getIDTokenResult(forcingRefresh: true) { tokenResult, error in
                if let error = error {
                    completion(.failure(error))
                } else if let tokenResult = tokenResult {
                    completion(.success(tokenResult.token))
                } else {
                    let error = AuthenticationError.unableToFetchToken
                    completion(.failure(error))
                }
            }
        }
}

enum AuthenticationError: Error {
    case noAuthenticatedUser
    case unableToFetchToken
    case customError(message: String)
    
    var localizedDescription: String {
        switch self {
        case .noAuthenticatedUser:
            return "No authenticated user found."
        case .unableToFetchToken:
            return "Unable to fetch authentication token."
        case .customError(let message):
            return message
        }
    }
}
