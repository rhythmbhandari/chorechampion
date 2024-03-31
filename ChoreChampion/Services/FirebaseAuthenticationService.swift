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
}
