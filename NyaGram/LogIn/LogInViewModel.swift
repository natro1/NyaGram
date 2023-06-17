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
    var loginButtonVM = NyaButtonViewModel(title: NyaStrings.login)
    var registerButtonVM = NyaButtonViewModel(title: NyaStrings.register)
    var errorLabelText = ""
    @Published var showError: Bool = false
    
    init(path: Binding<[Screens]>) {
        self._path = path
        loginButtonVM.action = login
        registerButtonVM.action = {
            self.path.append(.registerView)
        }
    }
    
    func login() {
        service.login(email, password) { error in
            if let safeError = error {
                self.showError = true
                self.handleErrors(safeError)
            } else {
                self.path.append(.loggedInView)
            }
        }
    }
    
    private func handleErrors(_ error: Error) {
        let nsError = error as NSError
        switch nsError.code {
        case AuthErrorCode.invalidEmail.rawValue:
            errorLabelText = NyaStrings.invalidEmail
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
