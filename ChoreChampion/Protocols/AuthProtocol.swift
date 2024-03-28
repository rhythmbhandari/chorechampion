//
//  AuthProtocol.swift
//  ChoreChampion
//
//  Created by Rhythm Bhandari on 3/28/24.
//
import FirebaseAuth

protocol AuthenticationDelegate: AnyObject {
    func signIn(with credentials: Credentials, completion: @escaping (Error?) -> Void)
}

class AuthManager: AuthenticationDelegate {
    func signIn(with credentials: Credentials, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: credentials.email, password: credentials.password) { authResult, error in
            completion(error)
        }
    }
}
