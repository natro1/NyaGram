//
//  RegisterViewModel.swift
//  NyaGram
//
//  Created by Natalia Rojek on 13/05/2023.
//

import SwiftUI
import FirebaseAuth

class RegisterViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Binding private var path: [Screens]
    private var service = NyaGramService()
    
    var signUpButtonVM = NyaButtonViewModel(title: "Sign Up")
    
    init(path: Binding<[Screens]>) {
        self._path = path
        signUpButtonVM.action = register
    }
    
    func goToRoot() {
        path = []
    }
    
    private func login() {
        service.login(email, password) { error in
            if let safeError = error {
                self.handleErrors(safeError)
            } else {
                self.path.append(.loggedInView)
            }
        }
    }
    
    private func register() {
        service.register(email, password) { error in
            if let safeError = error {
                self.handleErrors(safeError)
            } else {
                self.login()
            }
        }
    }
    
    private func handleErrors(_ error: Error) {
        print("Handle errors:")
        let nsError = error as NSError
        switch nsError.code {
        case AuthErrorCode.invalidEmail.rawValue:
            print("Invalid email")
        case AuthErrorCode.emailAlreadyInUse.rawValue:
            print("Email already in use")
        case AuthErrorCode.weakPassword.rawValue:
            print("Weak password")
        case AuthErrorCode.wrongPassword.rawValue:
            print("Wrong password")
        case AuthErrorCode.userNotFound.rawValue:
            print("There is no user with this identifier")
        case AuthErrorCode.networkError.rawValue:
            print("Check your internet connection")
        default:
            print(nsError.code)
            print("Unknown error: \(nsError.localizedDescription)")
        }
    }
}
