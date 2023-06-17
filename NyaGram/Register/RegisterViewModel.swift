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
    var errorLabelText = ""
    @Published var showError = false
    
    var signUpButtonVM = NyaButtonViewModel(title: NyaStrings.signUp)
    
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
                self.showError = true
                self.handleErrors(safeError)
            } else {
                self.path.append(.loggedInView)
            }
        }
    }
    
    func register() {
        service.register(email, password) { error in
            if let safeError = error {
                self.showError = true
                self.handleErrors(safeError)
            } else {
                self.login()
            }
        }
    }
    
    private func handleErrors(_ error: Error) {
        let nsError = error as NSError
        switch nsError.code {
        case AuthErrorCode.invalidEmail.rawValue:
            errorLabelText = NyaStrings.invalidEmail
        case AuthErrorCode.emailAlreadyInUse.rawValue:
            errorLabelText = NyaStrings.emailInUse
        case AuthErrorCode.weakPassword.rawValue:
            errorLabelText = NyaStrings.weakPassword
        case AuthErrorCode.wrongPassword.rawValue:
            errorLabelText = NyaStrings.wrongPassword
        case AuthErrorCode.userNotFound.rawValue:
            errorLabelText = NyaStrings.noUserWithThisID
        case AuthErrorCode.networkError.rawValue:
            errorLabelText = NyaStrings.checkConnection
        default:
            errorLabelText = NyaStrings.unknownError
        }
    }
}
