//
//  NyaGramService.swift
//  NyaGram
//
//  Created by Natalia Rojek on 15/05/2023.
//

import Foundation
import Firebase

struct NyaGramService {
    
    func login(
        _ email: String,
        _ password: String,
        _ completion: @escaping (_ error: Error?) -> Void
    ) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
                return completion(error)
            } else {
                return completion(nil)
            }
        }
    }
    
    func register(
    _ email: String,
    _ password: String,
    _ completion: @escaping (_ error: Error?) -> Void
    ) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            if error != nil {
                return completion(error)
            } else {
                return completion(nil)
            }
        }
    }
}
