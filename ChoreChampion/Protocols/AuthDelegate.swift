//
//  AuthDelegate.swift
//  ChoreChampion
//
//  Created by Rhythm Bhandari on 3/28/24.
//

protocol AuthenticationDelegate {
    func signIn(with credentials: Credentials, completion: @escaping (Result<Void, Error>) -> Void)
    func signOut(completion: @escaping (Result<Void, Error>) -> Void)
    func getToken(completion: @escaping (Result<String, Error>) -> Void)
}

