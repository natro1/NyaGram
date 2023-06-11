//
//  RegisterViewModel.swift
//  NyaGram
//
//  Created by Natalia Rojek on 13/05/2023.
//

import SwiftUI
import Firebase

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
        service.login(email, password) { success, error in
            if success {
                self.path.append(.loggedInView)
            } else {

            }
        }
    }
    
    private func register() {
        service.register(email, password) { success in
            if success {
                self.login()
            } else {
                
            }
        }
    }
}
