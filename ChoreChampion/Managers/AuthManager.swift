//
//  AuthManager.swift
//  ChoreChampion
//
//  Created by Rhythm Bhandari on 3/30/24.
//

import Foundation

class AuthManager {
    private let authService: AuthenticationDelegate
    
    init(authService: AuthenticationDelegate) {
        self.authService = authService
    }
    
    func signIn(with credentials: Credentials, completion: @escaping (Result<Void, Error>) -> Void) {
        authService.signIn(with: credentials, completion: completion)
    }
    
    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        authService.signOut(completion: completion)
    }
}
