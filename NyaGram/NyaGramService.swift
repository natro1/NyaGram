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
        _ completion: @escaping (_ success: Bool, _ error: Error?) -> Void
    ) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
                if let maybeError = error {
                    let error = maybeError as NSError
                    switch error.code {
                    case AuthErrorCode.wrongPassword.rawValue:
                        print("Wrong password")
                    case AuthErrorCode.userNotFound.rawValue:
                        print("There is no user with this identifier")
                    case AuthErrorCode.networkError.rawValue:
                        print("Check your internet connection")
                    default:
                        print(error.code)
                        print("Unknown error: \(error.localizedDescription)")
                    }
                }
                return completion(false, error)
            } else {
                return completion(true, nil)
            }
        }
    }
    
    func register(
    _ email: String,
    _ password: String,
    _ completion: @escaping (_ success: Bool) -> Void
    ) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            if error != nil {
                print(error!.localizedDescription)
                return completion(false)
            } else {
                return completion(true)
            }
        }
    }
}
