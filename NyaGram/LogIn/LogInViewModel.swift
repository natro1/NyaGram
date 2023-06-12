//
//  LogInViewModel.swift
//  NyaGram
//
//  Created by Natalia Rojek on 13/05/2023.
//

import SwiftUI
import FirebaseAuth

class LogInViewModel: ObservableObject {
    
    private var service = NyaGramService()
    @Published var email: String = ""
    @Published var password: String = ""
    @Binding private var path: [Screens]
    @Published var displayError = false
    var loginButtonVM = NyaButtonViewModel(title: "Log In")
    var registerButtonVM = NyaButtonViewModel(title: "Register")
    
    init(path: Binding<[Screens]>) {
        self._path = path
        loginButtonVM.action = login
        registerButtonVM.action = {
            self.path.append(.registerView)
        }
    }
    
    private func login() {
        service.login(email, password) { error in
            if let safeError = error {
                self.handleErrors(safeError)
                self.displayError = true
            } else {
                self.path.append(.loggedInView)
                self.displayError = false
            }
        }
    }
    
    private func handleErrors(_ error: Error) {
        print("Handle errors:")
        let nsError = error as NSError
        switch nsError.code {
        case AuthErrorCode.invalidEmail.rawValue:
            print("Invalid email")
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
